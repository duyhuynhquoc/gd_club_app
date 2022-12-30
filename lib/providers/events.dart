import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/event.dart';

class Events with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<Event> _list = [];

  List<Event> get allEvents {
    return [..._list];
  }

  void fetchEvents() async {
    final eventData = await db.collection('events').orderBy('_createdAt').get();

    var eventList = [];

    _list = [];

    for (var event in eventData.docs) {
      eventList.insert(
        0,
        Event(
          id: event.id,
          title: event.data()['title'],
          location: event.data()['location'],
          dateTime: DateTime.fromMicrosecondsSinceEpoch(
              (event.data()['dateTime'] as Timestamp).microsecondsSinceEpoch),
          description: event.data()['description'],
          organizerId: event.data()['organizerId'],
          isRegistered: false,
        ),
      );
    }

    _list = [...eventList];

    notifyListeners();
  }

  void addEvent(Event event) async {
    final eventData = await db.collection('events').add({
      'title': event.title,
      'location': event.location,
      'dateTime': event.dateTime,
      'description': event.description,
      'organizerId': event.organizerId,
      '_createdAt': Timestamp.now(),
    });

    event.id = eventData.id;
    _list.add(event);

    notifyListeners();
  }

  void updateEvent(String updatingEvenId, Event newEvent) async {
    for (Event event in _list) {
      if (event.id == updatingEvenId) {
        event = Event(
          title: newEvent.title,
          location: newEvent.location,
          dateTime: newEvent.dateTime,
          organizerId: newEvent.organizerId,
        );

        event.id = updatingEvenId;

        break;
      }
    }

    final eventData = await db.collection('events').doc(updatingEvenId).set({
      'title': newEvent.title,
      'location': newEvent.location,
      'dateTime': newEvent.dateTime,
      'description': newEvent.description,
      'organizerId': newEvent.organizerId,
      '_createdAt': Timestamp.now(),
    });

    notifyListeners();
  }
}