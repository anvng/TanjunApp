import 'package:flutter/material.dart';

class TaskBarWidget extends StatelessWidget {
  const TaskBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios_new_rounded)),
            ),
          )
        ],
      ),
    );
  }

  Size get preferredSize => const Size.fromHeight(130);
}
