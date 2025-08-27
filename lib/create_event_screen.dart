import 'package:evently/app_theme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/ui_utlis.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = "event";

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int currentIndex = 0;
  //
  CategoryModel selectedCategory = CategoryModel.categories.first;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateFormat dateFormat = DateFormat("d/M/yyyy");

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text("Create Event")),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/${selectedCategory.imageName}.png",
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
                //
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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("Title", style: textTheme.titleMedium),
                    SizedBox(height: 8),

                    DefaultTextFormField(
                      hintText: "Event Title",
                      prefixIconImageName: "Note_Edit",
                      controller: titleController,
                      //
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title Can Not Be Empty";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    Text("Description", style: textTheme.titleMedium),
                    SizedBox(height: 8),

                    DefaultTextFormField(
                      hintText: "Event Description",
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Description Can Not Be Empty";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/Calendar_Days.svg"),
                        SizedBox(width: 10),

                        Text("Event Date", style: textTheme.titleMedium),
                        Spacer(),
                        InkWell(
                          //
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            );

                            if (date != null) {
                              selectedDate = date;
                              setState(() {});
                            }
                          },
                          child: Text(
                            selectedDate == null
                                ? "Choose Date"
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

                            //

                            if (time != null) {
                              selectedTime = time;
                              setState(() {});
                            }
                          },

                          child: Text(
                            selectedTime == null
                                ? "Choose Time"
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
                      label: "Add Event",
                      onPressed: createEvent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createEvent() {
    if (formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      DateTime dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      EventModel event = EventModel(
        category: selectedCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
      );

      FirebaseService.createEvent(event)
          .then((_) {
            Navigator.of(context).pop();
            UiUtlis.showSuccessMessage("Event create Successfully");
          })
          .catchError((_) {
            UiUtlis.showErrorMessage("Failed to create event");
          });
    }
  }
}
