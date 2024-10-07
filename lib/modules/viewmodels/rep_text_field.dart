import 'package:flutter/material.dart';
import 'package:tanjun_app/core/utils/app_colors.dart';
import 'package:tanjun_app/core/utils/task_strings.dart';

class RepTextField extends StatelessWidget {
  const RepTextField({
    super.key,
    required TextEditingController titleController,
    this.isForDescription = false,
  }) : controller = titleController;

  final TextEditingController controller;
  final bool isForDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: TextField(
          controller: controller,
          maxLines: !isForDescription ? 6 : null,
          cursorHeight: !isForDescription ? 60 : null,
          style: const TextStyle(color: AppColors.textColor),
          decoration: InputDecoration(
            border: isForDescription ? InputBorder.none : null,
            counter: Container(),
            hintText: isForDescription ? TaskStrings.addNote : null,
            prefixIcon: isForDescription
                ? const Icon(
                    Icons.bookmark_add_outlined,
                    color: AppColors.textHintColor,
                  )
                : null,
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
              color: AppColors.textHintColor,
            )),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(42, 33, 58, 87),
              ),
            ),
          ),
          onSubmitted: (value) {},
          onChanged: (value) {},
        ),
      ),
    );
  }
}
