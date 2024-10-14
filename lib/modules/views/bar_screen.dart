import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:tanjun_app/core/utils/constants.dart';

class BarScreen extends StatefulWidget {
  const BarScreen({
    super.key,
    required this.drawerKey,
    required this.onDeleteAll,
  });

  final GlobalKey<SliderDrawerState> drawerKey;
  final VoidCallback onDeleteAll;

  @override
  State<BarScreen> createState() => _BarScreenState();
}

class _BarScreenState extends State<BarScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onDrawerToggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        _animationController.forward();
        widget.drawerKey.currentState?.closeSlider();
      } else {
        _animationController.reverse();
        widget.drawerKey.currentState?.openSlider();
      }
    });
  }

  // View notification before deleting all tasks
  void deleteAllTasks() {
    showDeleteAllTasksWarning(context).then((confirmed) {
      if (confirmed == true) {
        widget.onDeleteAll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: onDrawerToggle,
                icon: AnimatedIcon(
                  icon: AnimatedIcons.close_menu,
                  progress: _animationController,
                  size: 30,
                ),
              ),
            ),
            // Trash all button
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: deleteAllTasks,
                icon: const Icon(
                  CupertinoIcons.trash_fill,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
