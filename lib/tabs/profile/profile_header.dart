import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64)),
      ),

      child: SafeArea(
        child: Row(
          children: [
            Image.asset(
              "assets/images/route_logo.png",
              height: MediaQuery.sizeOf(context).height * 0.12,
              fit: BoxFit.fill,
            ),

            SizedBox(width: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("UserName", style: textTheme.headlineSmall),

                SizedBox(height: 10),
                Text(
                  "userEmail@gmail.com",
                  style: textTheme.titleMedium!.copyWith(color: AppTheme.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
