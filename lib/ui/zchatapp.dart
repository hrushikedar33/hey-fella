import 'package:flutter/material.dart';
import 'package:hey_fellas/common/screenutil/screenutil.dart';
import 'package:hey_fellas/models/userdata/user_model.dart';
import 'package:hey_fellas/services/auth.dart';
import 'package:hey_fellas/ui/screens/home/home_screen.dart';
import 'package:hey_fellas/ui/screens/onboard/onboard.dart';
import 'package:hey_fellas/ui/theme/texttheme.dart';
import 'package:hey_fellas/ui/theme/themecolor.dart';
import 'package:provider/provider.dart';

class ChatApp extends StatefulWidget {
  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return StreamProvider<UserModel>.value(
      value: AuthServices().user,
      child: MaterialApp(
        title: 'Hey Fellas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          unselectedWidgetColor: AppColor.royalBlue,
          primaryColor: AppColor.vulcan,
          accentColor: AppColor.royalBlue,
          scaffoldBackgroundColor: AppColor.vulcan,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: ThemeText.getTextTheme(),
          appBarTheme: const AppBarTheme(elevation: 0),
        ),
        builder: (context, child) {
          return child;
        },
        home: Wrapper(),
        // onGenerateRoute: (RouteSettings settings) {
        //   final routes = Routes.getRoutes(settings);
        //   final WidgetBuilder builder = routes[settings.name];
        //   return FadePageRouteBuilder(
        //     builder: builder,
        //     settings: settings,
        //   );
        // },
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    // print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Onboard();
    } else {
      return HomeScreen();
    }
  }
}
