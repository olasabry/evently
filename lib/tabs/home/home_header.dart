import 'package:evently/app_theme.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  void Function(CategoryModel?) filterEvents;

  HomeHeader({required this.filterEvents});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 16),

      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back ✨", style: textTheme.titleSmall),
            Text("User Name", style: textTheme.headlineSmall),
            SizedBox(height: 16),

            DefaultTabController(
              length: CategoryModel.categories.length + 1,
              child: TabBar(
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.only(right: 10),

                onTap: (index) {
                  if (currentindex == index) return;
                  currentindex = index;

                  CategoryModel? selectedCategory = currentindex == 0
                      ? null
                      : CategoryModel.categories[currentindex - 1];

                  widget.filterEvents(selectedCategory);
                  setState(() {});
                },

                tabs: [
                  TabItem(
                    label: "All",
                    icon: Icons.ac_unit,
                    isSelected: currentindex == 0,
                    selectedForegroundColor: AppTheme.primary,
                    unselectedForegroundColor: AppTheme.white,
                    selectedbackgroundColor: AppTheme.white,
                  ),
                  ...CategoryModel.categories.map(
                    (category) => TabItem(
                      label: category.name,
                      icon: category.icon,
                      isSelected:
                          currentindex ==
                          CategoryModel.categories.indexOf(category) + 1,
                      selectedForegroundColor: AppTheme.primary,
                      unselectedForegroundColor: AppTheme.white,
                      selectedbackgroundColor: AppTheme.white,
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
