import 'package:flutter/material.dart';
import 'package:hey_fellas/common/constants/size_constants.dart';
import 'package:hey_fellas/common/extensions/size_extension.dart';
import 'package:hey_fellas/ui/screens/auth/authantication.dart';
import 'package:hey_fellas/ui/theme/themecolor.dart';

class Onboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "onboard screen",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .apply(fontWeightDelta: 10),
            ),
          ),
          SizedBox(
            height: Sizes.dimen_40.h,
          ),
          // Spacer(
          //   flex: 1,
          // ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Authantication();
                },
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: Sizes.dimen_4.h, horizontal: Sizes.dimen_20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: AppColor.red,
              ),
              child: Text(
                "Get Started",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          SizedBox(
            height: Sizes.dimen_2.h,
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(
          //       builder: (context) {
          //         return SignupScreeen();
          //       },
          //     ));
          //   },
          //   child: Container(
          //     padding: EdgeInsets.symmetric(
          //         vertical: Sizes.dimen_4.h, horizontal: Sizes.dimen_20.w),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20.0),
          //       color: AppColor.red,
          //     ),
          //     child: Text(
          //       "Get Started",
          //       style: Theme.of(context).textTheme.headline5,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
