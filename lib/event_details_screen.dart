import 'package:evently/app_theme.dart';
import 'package:evently/edit_event_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/ui_utlis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    EventModel event = ModalRoute.of(context)!.settings.arguments as EventModel;
    TextTheme textTheme = Theme.of(context).textTheme;
    DateFormat dateFormat = DateFormat("d MMMM yyyy");
    DateFormat timeFormat = DateFormat("hh:mm a");
    String formattedDate = dateFormat.format(event.dateTime);
    String formattedTime = timeFormat.format(event.dateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text("Event Details"),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditEventScreen(event: event),
                ),
              );
              if (result == true) {
                Navigator.of(context).pop(true);
              }
            },
            icon: SvgPicture.asset(
              "assets/icons/edit.svg",
              width: 24,
              height: 24,
            ),
          ),

          IconButton(
            onPressed: () {
              FirebaseService.deleteEvent(event.id).then((_) {
                Navigator.of(context).pop(true);
                UiUtlis.showSuccessMessage("Event deleted Successfully");
              });
            },
            icon: SvgPicture.asset(
              "assets/icons/delete.svg",
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/${event.category.imageName}.png",
                height: MediaQuery.sizeOf(context).height * 0.23,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${event.title}",
                    style: textTheme.headlineSmall!.copyWith(
                      color: AppTheme.primary,
                    ),
                  ),

                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.primary),
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/images/calender_event_details.png"),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formattedDate,
                              style: textTheme.titleMedium!.copyWith(
                                color: AppTheme.primary,
                              ),
                            ),
                            Text(
                              formattedTime,
                              style: textTheme.titleMedium!.copyWith(
                                color: AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.primary),
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/images/location_event_details.png"),
                        SizedBox(width: 8),
                        Text(
                          "Cairo , Egypt",
                          style: textTheme.titleMedium!.copyWith(
                            color: AppTheme.primary,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/arrow _right_event_details.svg",
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),
                  Image.asset(
                    "assets/images/location.png",
                    width: double.infinity,
                    fit: BoxFit.fill,
                    height: MediaQuery.sizeOf(context).height * 0.30,
                  ),
                  SizedBox(height: 16),

                  Text(
                    "Description \n ${event.description}",
                    style: textTheme.titleMedium!.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
