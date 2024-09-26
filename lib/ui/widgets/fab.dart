import 'package:flutter/material.dart';
import 'package:tanjun_app/utils/app_colors.dart';

class Fab extends StatelessWidget {
  const Fab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('View Task');
      },
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 10,
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
