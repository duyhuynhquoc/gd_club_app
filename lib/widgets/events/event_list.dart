import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/event.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/event/manage_events_screen.dart';

import 'package:gd_club_app/widgets/events/event_item.dart';

import 'package:provider/provider.dart';

class EventList extends StatefulWidget {
  final bool isManaging;
  final bool isRegistered;

  const EventList(
      {super.key, this.isManaging = false, this.isRegistered = false});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var events = List<Event>.empty();

    if (widget.isManaging) {
      events = Provider.of<Events>(context).ownedEvents;
    } else if (widget.isRegistered) {
      events = Provider.of<Events>(context).registeredEvents;
    } else {
      events = Provider.of<Events>(context).allEvents;
    }

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: ChangeNotifierProvider.value(
              value: events[i],
              child: EventItem(
                isEdit: ModalRoute.of(context)!.settings.name ==
                    ManageEventsScreen.routeName,
              ),
            ),
          );
        },
      ),
    );
  }
}
