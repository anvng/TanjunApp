import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanjun_app/core/utils/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  // Icons and titles
  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person,
    CupertinoIcons.settings,
    CupertinoIcons.info,
  ];

  final List<String> titles = [
    "Home",
    "Profile",
    "Settings",
    "Details",
  ];

  // Define routes
  final List<String> routes = [
    '/home',
    '/profile',
    '/settings',
    '/details',
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 80,
        horizontal: 10,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.colorGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/152575252?v=4"),
          ),
          const SizedBox(height: 10),
          Text("An Nguyen", style: textTheme.displaySmall),
          Text("Flutter Developer", style: textTheme.bodyLarge),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // Navigate to the corresponding route
                    Navigator.pushNamed(context, routes[index]);
                  },
                  child: ListTile(
                    leading: Icon(
                      icons[index],
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    title: Text(
                      titles[index],
                      style:
                          const TextStyle(color: Color.fromARGB(165, 0, 0, 0)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
