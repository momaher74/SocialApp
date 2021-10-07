import 'package:flutter/material.dart';


class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(child: Text("Notifications")),

        ],
      ),
    );
  }
}
