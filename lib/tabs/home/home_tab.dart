import 'package:evently/event_details_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:evently/widgets/event_item.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<EventModel> allEvents = [];
  List<EventModel> displayEvents = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(filterEvents: filterEvents),
        SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, index) {
              EventModel event = displayEvents[index];
              return InkWell(
                onTap: () async {
                  final result = await Navigator.of(
                    context,
                  ).pushNamed(EventDetailsScreen.routeName, arguments: event);
                  if (result == true) {
                    await getEvents();
                  }
                },
                child: EventItem(event: event),
              );
            },
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: displayEvents.length,
          ),
        ),
      ],
    );
  }

  Future<void> getEvents() async {
    allEvents = await FirebaseService.getEvents();
    displayEvents = allEvents;
    setState(() {});
  }

  void filterEvents(CategoryModel? Category) {
    if (Category == null) {
      displayEvents = allEvents;
    } else {
      displayEvents = allEvents
          .where((event) => event.category == Category)
          .toList();
    }
    setState(() {});
  }
}
