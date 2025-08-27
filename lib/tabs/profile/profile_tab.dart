import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/tabs/profile/profile_header.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  List<Language> Languages = [
    Language(code: "en", name: "English"),
    Language(code: "ar", name: "العربية"),
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileHeader(),
        SizedBox(height: 24),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Language",
                  style: textTheme.titleLarge!.copyWith(
                    color: AppTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primary),
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: DropdownButton(
                    value: "en",

                    items: Languages.map(
                      (Language) => DropdownMenuItem(
                        child: Text(
                          Language.name,
                          style: textTheme.titleLarge!.copyWith(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        value: Language.code,
                      ),
                    ).toList(),

                    onChanged: (value) {},

                    borderRadius: BorderRadius.circular(16),
                    underline: SizedBox(),
                    iconEnabledColor: AppTheme.primary,

                    isExpanded: true,
                  ),
                ),

                SizedBox(height: 16),

                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " Dark Theme",
                      style: textTheme.titleLarge!.copyWith(
                        color: AppTheme.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Switch(
                      value: true,
                      onChanged: (value) {},
                      activeTrackColor: AppTheme.primary,
                    ),
                  ],
                ),

                Spacer(),

                InkWell(
                  onTap: () {
                    FirebaseService.logout().then((_) {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(LoginScreen.routeName);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      color: AppTheme.red,
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 24, color: AppTheme.white),
                        Text("Logout", style: textTheme.titleLarge),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Language {
  String code;
  String name;

  Language({required this.code, required this.name});
}
