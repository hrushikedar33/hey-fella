import 'package:flutter/material.dart';
import 'package:hey_fellas/common/constants/size_constants.dart';
import 'package:hey_fellas/services/auth.dart';
import 'package:hey_fellas/ui/screens/auth/authantication.dart';
import 'package:hey_fellas/ui/theme/themecolor.dart';
import 'package:hey_fellas/common/extensions/size_extension.dart';

class NavDrawer extends StatelessWidget {
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(Sizes.dimen_20.w),
        topRight: Radius.circular(Sizes.dimen_20.w),
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: Sizes.dimen_48.h,
              child: DrawerHeader(
                child: Center(
                  child: Text(
                    'Menu',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                decoration: BoxDecoration(
                  color: AppColor.royalBlue, //todo change color
                  //todo insert image if you want
                ),
              ),
            ),
            ListTile(
              tileColor: Colors.black,
              leading: Icon(
                Icons.input,
                color: AppColor.white,
              ),
              title: Text(
                "Welcome",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(color: AppColor.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.verified_user,
                color: AppColor.white,
              ),
              title: Text(
                "Profile",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(color: AppColor.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.border_color,
                color: AppColor.white,
              ),
              title: Text(
                "Feedback",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(color: AppColor.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: AppColor.white,
              ),
              title: Text(
                "Setting",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(color: AppColor.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: AppColor.white,
              ),
              title: Text(
                "Logout",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(color: AppColor.white),
              ),
              onTap: () async {
                await _auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Authantication(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
