import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/consts.dart';
import 'package:quiz_app/features/quiz_feature/cubit/cubit/quiz_cubit.dart';
import 'package:quiz_app/features/quiz_feature/widgets/custombutton.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({super.key});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();
  final TextEditingController _option4Controller = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _questionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _submitQuestion() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final success = await context.read<QuizCubit>().addQuestionToFirebase(
      question: _questionController.text.trim(),
      options: [
        _option1Controller.text.trim(),
        _option2Controller.text.trim(),
        _option3Controller.text.trim(),
        _option4Controller.text.trim(),
      ],
      answer: _answerController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'Question added to Firestore.' : 'Failed to add question.',
        ),
      ),
    );

    if (success) {
      _formKey.currentState?.reset();
      _questionController.clear();
      _option1Controller.clear();
      _option2Controller.clear();
      _option3Controller.clear();
      _option4Controller.clear();
      _answerController.clear();
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: AppConsts.secondarycolor,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Question'), centerTitle: true),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppConsts.primarycolor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add your own quiz question',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Write the question, four options, and the correct answer exactly as one of the options.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _questionController,
                  decoration: _inputDecoration('Question'),
                  validator: (value) => _requiredValidator(value, 'Question'),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _option1Controller,
                  decoration: _inputDecoration('Option 1'),
                  validator: (value) => _requiredValidator(value, 'Option 1'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _option2Controller,
                  decoration: _inputDecoration('Option 2'),
                  validator: (value) => _requiredValidator(value, 'Option 2'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _option3Controller,
                  decoration: _inputDecoration('Option 3'),
                  validator: (value) => _requiredValidator(value, 'Option 3'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _option4Controller,
                  decoration: _inputDecoration('Option 4'),
                  validator: (value) => _requiredValidator(value, 'Option 4'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _answerController,
                  decoration: _inputDecoration('Correct Answer'),
                  validator: (value) {
                    final answerError = _requiredValidator(
                      value,
                      'Correct Answer',
                    );
                    if (answerError != null) {
                      return answerError;
                    }

                    final options = [
                      _option1Controller.text.trim(),
                      _option2Controller.text.trim(),
                      _option3Controller.text.trim(),
                      _option4Controller.text.trim(),
                    ];
                    if (!options.contains(value!.trim())) {
                      return 'Answer must match one of the four options';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: _isSubmitting ? 'Saving...' : 'Save Question',
                  backgroundColor: AppConsts.primarycolor,
                  textColor: AppConsts.secondarycolor,
                  icon: Icons.save_rounded,
                  iconcolor: AppConsts.secondarycolor,
                  shapecircularradius: 15,
                  fixedSize: const WidgetStatePropertyAll(
                    Size(double.maxFinite, 52),
                  ),
                  onPressed: _isSubmitting ? null : _submitQuestion,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
