import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/screens/event_edit_screen.dart';
import 'package:gd_club_app/widgets/app_drawer.dart';
import 'package:gd_club_app/widgets/events/event_list.dart';

class EventsScreen extends StatelessWidget {
  static const routeName = "/events";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EventList(),
      appBar: AppBar(
        title: const Text('Sự kiện'),
      ),
      drawer: AppDrawer(),
    );
  }
}