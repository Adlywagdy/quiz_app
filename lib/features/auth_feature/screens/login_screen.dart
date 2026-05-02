import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/consts.dart';
import 'package:quiz_app/features/auth_feature/cubit/login_cubit.dart';
import 'package:quiz_app/features/auth_feature/cubit/login_states.dart';
import 'package:quiz_app/features/quiz_feature/screens/homescreen.dart';
import 'package:quiz_app/features/quiz_feature/widgets/custombutton.dart';
import 'package:quiz_app/features/quiz_feature/widgets/customicon.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Quiz Master",
            style: TextStyle(color: AppConsts.primarycolor),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState || state is SignupSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            } else if (state is LoginFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is SignupFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoadingState || state is SignupLoadingState;

            return Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppConsts.primarycolor,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIcon(radius: 50, icon: Icons.person_rounded),
                        SizedBox(height: 20),
                        Text(
                          isLogin ? "Welcome Back" : "Create Account",
                          style: TextStyle(
                            fontSize: 23,
                            color: AppConsts.secondarycolor,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          isLogin
                              ? "Sign in to continue"
                              : "Sign up to get started",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppConsts.secondarycolor,
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            color: AppConsts.secondarycolor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email_outlined, color: AppConsts.primarycolor),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppConsts.primarycolor)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            color: AppConsts.secondarycolor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(Icons.lock_outline, color: AppConsts.primarycolor),
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: AppConsts.greycolor),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppConsts.primarycolor)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        if (isLoading)
                          CircularProgressIndicator(color: AppConsts.secondarycolor)
                        else
                          CustomButton(
                            text: isLogin ? "Sign In" : "Sign Up",
                            backgroundColor: AppConsts.secondarycolor,
                            textColor: AppConsts.primarycolor,
                            fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 50)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (isLogin) {
                                  context.read<LoginCubit>().login(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                                } else {
                                  context.read<LoginCubit>().signup(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                                }
                              }
                            },
                          ),
                        SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(
                            isLogin
                                ? "Don't have an account? Sign Up"
                                : "Already have an account? Sign In",
                            style: TextStyle(
                              color: AppConsts.secondarycolor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}