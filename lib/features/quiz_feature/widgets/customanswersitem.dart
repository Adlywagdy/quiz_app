import 'package:flutter/material.dart';
import 'package:quiz_app/core/consts.dart';
import 'package:quiz_app/features/quiz_feature/models/questionmodel.dart';

class CustomAnswersItem extends StatelessWidget {
  final int questionsindex;
  final int index;
  CustomAnswersItem({
    super.key,
    required this.questionsindex,
    required this.index,
  });
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: selected
              ? BoxBorder.all(color: AppConsts.primarycolor)
              : BoxBorder.all(color: AppConsts.greycolor.withValues(alpha: .2)),
        ),
        child: ListTile(
          leading: selected
              ? CircleAvatar(
                  backgroundColor: AppConsts.primarycolor,
                  radius: 10,
                  child: CircleAvatar(
                    radius: 3.5,
                    backgroundColor: AppConsts.secondarycolor,
                  ),
                )
              : CircleAvatar(
                  radius: 10,
                  backgroundColor: AppConsts.greycolor.withValues(alpha: .15),
                ),
          title: Text(
            questions[questionsindex].options[index],
            style: TextStyle(fontWeight: .w500),
          ),
          trailing: selected
              ? Icon(Icons.check_circle_outline, color: AppConsts.primarycolor)
              : null,
        ),
      ),
    );
  }
}
