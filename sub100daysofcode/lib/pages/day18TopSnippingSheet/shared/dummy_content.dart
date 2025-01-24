import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';

class DummyContent extends StatelessWidget {
  final bool reverse;
  final ScrollController? controller;

  const DummyContent({Key? key, this.controller, this.reverse = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          _buildInfoCard(
            context,
            "Flutter Development Tips",
            "Learn how to build high-quality mobile apps using Flutter. Here are some useful resources and tutorials to get started.",
            Icons.code,
          ),
          _buildInfoCard(
            context,
            "Design Principles",
            "Good design is crucial for creating an amazing user experience. Understand key principles of design and UI/UX.",
            Icons.design_services,
          ),
          _buildInfoCard(
            context,
            "Productivity Tips",
            "Maximize your productivity with these helpful tools and techniques for developers and designers alike.",
            Icons.access_time,
          ),
          _buildInfoCard(
            context,
            "Flutter Packages to Explore",
            "Explore the most popular Flutter packages that can make your app development faster and easier.",
            Icons.extension,
          ),
          _buildInfoCard(
            context,
            "Understanding State Management",
            "State management in Flutter is key to maintaining your app’s logic. Learn about the different state management solutions.",
            Icons.assignment,
          ),
          _buildInfoCard(
            context,
            "Effective Debugging Techniques",
            "Debugging is an essential skill in development. Discover common debugging tools and techniques to fix issues faster.",
            Icons.bug_report,
          ),
          _buildInfoCard(
            context,
            "App Testing Best Practices",
            "Testing your app thoroughly can save you a lot of time. Here are the best practices for unit testing and UI testing.",
            Icons.check_circle,
          ),
        ],
      ),
    );
  }

  // Helper function to build each card with title, description, and icon
  Widget _buildInfoCard(BuildContext context, String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
        onTap: () {
          _showDetail(context, title, description);
        },
      ),
    );
  }

  void _showDetail(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close",style: TextStyle(color: AppColors.black),),
            ),
          ],
        );
      },
    );
  }
}
