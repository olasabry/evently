import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/app_theme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/ui_utlis.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EditEventScreen extends StatefulWidget {
  EventModel event;

  EditEventScreen({required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat("d/M/yyyy");
  DateFormat timeFormat = DateFormat("hh:mm a");
  late int currentIndex;
  CategoryModel? selectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: widget.event.title);
    descriptionController = TextEditingController(
      text: widget.event.description,
    );
    currentIndex = CategoryModel.categories.indexWhere(
      (category) => category.name == widget.event.category.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    String formattedDate = dateFormat.format(widget.event.dateTime);
    String formattedTime = timeFormat.format(widget.event.dateTime);

    return Scaffold(
      appBar: AppBar(title: Text("Edit Event")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  selectedCategory == null
                      ? "assets/images/${widget.event.category.imageName}.png"
                      : "assets/images/${selectedCategory!.imageName}.png",
                  height: MediaQuery.sizeOf(context).height * 0.23,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),

            DefaultTabController(
              length: CategoryModel.categories.length,

              child: TabBar(
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.only(right: 10),
                padding: EdgeInsets.only(left: 16),

                onTap: (index) {
                  if (currentIndex == index) return;
                  currentIndex = index;
                  selectedCategory = CategoryModel.categories[currentIndex];
                  setState(() {});
                },

                tabs: CategoryModel.categories
                    .map(
                      (category) => TabItem(
                        label: category.name,
                        icon: category.icon,
                        isSelected:
                            currentIndex ==
                            CategoryModel.categories.indexOf(category),
                        selectedForegroundColor: AppTheme.white,
                        unselectedForegroundColor: AppTheme.primary,
                        selectedbackgroundColor: AppTheme.primary,
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title", style: textTheme.titleMedium),
                  SizedBox(height: 8),
                  DefaultTextFormField(
                    controller: titleController,
                    prefixIconImageName: "Note_Edit",
                  ),

                  SizedBox(height: 16),

                  Text("Description", style: textTheme.titleMedium),
                  SizedBox(height: 8),
                  DefaultTextFormField(controller: descriptionController),

                  SizedBox(height: 16),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/Calendar_Days.svg"),
                      SizedBox(width: 10),

                      Text("Event Date", style: textTheme.titleMedium),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                          );

                          if (date != null) {
                            selectedDate = date;
                            setState(() {});
                          }
                        },

                        child: Text(
                          selectedDate == null
                              ? formattedDate
                              : dateFormat.format(selectedDate!),
                          style: textTheme.titleMedium!.copyWith(
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/time.svg"),
                      SizedBox(width: 10),

                      Text("Event Time", style: textTheme.titleMedium),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (time != null) {
                            selectedTime = time;
                            setState(() {});
                          }
                        },

                        child: Text(
                          selectedTime == null
                              ? formattedTime
                              : selectedTime!.format(context),
                          style: textTheme.titleMedium!.copyWith(
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  DefaultElevatedButton(
                    label: "Update Event",
                    onPressed: updateEvent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateEvent() {
    DateTime dateTime = DateTime(
      selectedDate?.year ?? widget.event.dateTime.year,
      selectedDate?.month ?? widget.event.dateTime.month,
      selectedDate?.day ?? widget.event.dateTime.day,
      selectedTime?.hour ?? widget.event.dateTime.hour,
      selectedTime?.minute ?? widget.event.dateTime.minute,
    );
    EventModel event = EventModel(
      id: widget.event.id,
      category: selectedCategory ?? widget.event.category,
      title: titleController.text,
      description: descriptionController.text,
      dateTime: dateTime,
    );
    FirebaseService.updateEvent(event)
        .then((_) {
          Navigator.of(context).pop(true);
          UiUtlis.showSuccessMessage("Event updated Successfully");
        })
        .catchError((error) {
          UiUtlis.showErrorMessage("Failed to update event");
          print(error);
        });
  }
}
