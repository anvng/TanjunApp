import 'package:flutter/material.dart';

class TaskBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TaskBarWidget({super.key, this.title});

  final String? title; // Optional title parameter

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      padding: const EdgeInsets.only(left: 20, top: 20),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .appBarTheme
            .backgroundColor, // Use app bar color from theme
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          const SizedBox(width: 20), // Add some spacing between icon and title
          Expanded(
            child: Semantics(
              label:
                  title ?? "Task Bar", // Add semantic label for accessibility
              child: Text(
                title ?? "Task", // Default title if not provided
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}
