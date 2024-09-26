import 'package:flutter/material.dart';
import 'package:tanjun_app/ui/widgets/fab.dart';
import 'package:tanjun_app/utils/app_colors.dart';
import 'package:tanjun_app/utils/task_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      floatingActionButton: const Fab(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 90),
              width: double.infinity,
              height: 100,
              color: AppColors.secondaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      value: 1 / 3,
                      backgroundColor: AppColors.secondaryColor,
                      valueColor: AlwaysStoppedAnimation(AppColors.buttonColor),
                    ),
                  ),
                  const SizedBox(width: 25),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TaskStrings.mainTitle,
                        style: textTheme.titleLarge?.copyWith(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "1 of 3 tasks",
                        style: textTheme.titleMedium?.copyWith(
                          color: AppColors.textColor.withOpacity(0.5),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Divider(
                thickness: 2,
                indent: 97,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    duration: const Duration(milliseconds: 600),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          // check or uncheck
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.primaryColor, width: .8),
                          ),
                          child: const Icon(Icons.check, color: Colors.white),
                        ),
                      ),
                      // title
                      title: const Padding(
                        padding: EdgeInsets.only(bottom: 5, top: 3),
                        child: Text(
                          "Done",
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      // description
                      subtitle: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w300),
                          ),
                          // date
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 10),
                              child: Column(
                                children: [
                                  Text(
                                    "Time",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
