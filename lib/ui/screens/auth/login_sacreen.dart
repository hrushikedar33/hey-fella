import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hey_fellas/helper/helperFunction.dart';
import 'package:hey_fellas/services/auth.dart';
import 'package:hey_fellas/services/database.dart';
import 'package:hey_fellas/ui/screens/auth/common/authbackground.dart';
import 'package:hey_fellas/ui/screens/auth/common/sample_logo.dart';
import 'package:hey_fellas/ui/screens/auth/forget_pass.dart';
import 'package:hey_fellas/ui/screens/home/home_screen.dart';
import 'package:hey_fellas/ui/widgets/loader.dart';
import 'package:hey_fellas/common/constants/size_constants.dart';
import 'package:hey_fellas/common/extensions/size_extension.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({this.toggleView});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthServices _auth = AuthServices();
  final DatabaseMethods _databaseMethods = DatabaseMethods();

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  final FocusNode passFild = FocusNode();

  bool _obsecurePassword = true;
  bool isLoading = false;

  TextEditingController _emaileditingcontroller = new TextEditingController();
  TextEditingController _passwordeditingcontroller =
      new TextEditingController();

  QuerySnapshot snapshotUserInfo;

  void dispose() {
    _emaileditingcontroller.dispose();
    _passwordeditingcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return Authbackground(
      content: Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        body: isLoading
            ? Center(
                child: Container(
                  child: Loader(),
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: Sizes.dimen_36.h, left: Sizes.dimen_16.w),
                        child: SamoleLogo(), //todo Logo
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Sizes.dimen_16.w,
                            right: Sizes.dimen_16.w,
                            top: Sizes.dimen_12.h),
                        child: Text(
                          "Welcome back!",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Sizes.dimen_16.w,
                            right: Sizes.dimen_16.w,
                            top: Sizes.dimen_4.h),
                        child: Text(
                          "Enter your email address and password to get access your account.",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Sizes.dimen_16.w,
                            right: Sizes.dimen_16.w,
                            top: Sizes.dimen_20.h),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(
                                0xFF262630), //todo change color //BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: <Widget>[
                              emailTextField(),
                              formDivider(),
                              passwordTextField(),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlatButton(
                            onPressed: () {
                              ForgetPassword(); //TODO
                            },
                            child: Text(
                              'Forget password',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Sizes.dimen_18.h),
                            child:
                                loginButton(), //todo:same as login with button
                          ),
                        ],
                      ),
                      loginViaGoogleButton(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Sizes.dimen_16.w,
                            right: Sizes.dimen_16.w,
                            top: Sizes.dimen_24.h),
                        child: Text(
                          'Don\'t have an account?',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      FlatButton(
                        highlightColor:
                            Colors.red, //todo:change to splash color
                        onPressed: () {
                          //navigatorToSignupScreen();
                          widget.toggleView();
                        },
                        child: Text(
                          "Create account",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .apply(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: EdgeInsets.only(
          left: Sizes.dimen_16.w, right: Sizes.dimen_16.w, bottom: 0),
      child: TextFormField(
        validator: (val) {
          if (val.isEmpty) {
            return "Email is required";
          } else if (RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(val)) {
            return null;
          } else {
            return "Please enter valid email";
          }
        },
        // onChanged: (val) {
        //   setState(() {
        //     return _emaileditingcontroller.text = val;
        //   });
        // },
        controller: _emaileditingcontroller,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.white24,
        style: Theme.of(context).textTheme.bodyText2.apply(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Email',
          border: InputBorder.none,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          icon: Icon(
            Icons.mail_outline,
            color: Colors.white,
          ),
        ),
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }

  Widget formDivider() {
    return Padding(
      padding: EdgeInsets.only(left: Sizes.dimen_16.w, right: Sizes.dimen_16.w),
      child: Divider(
        color: Colors.white54,
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: EdgeInsets.only(
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
          top: 0,
          bottom: Sizes.dimen_2.h),
      child: TextFormField(
        validator: (val) {
          if (val.isEmpty) {
            return "Password is required";
          } else if (val.length < 4) {
            return "Password is too short";
          }
          return null;
        },
        // onChanged: (val) {
        //   setState(() {
        //     return _passwordeditingcontroller.text = val;
        //   });
        // },
        controller: _passwordeditingcontroller,
        obscureText: _obsecurePassword,
        cursorColor: Colors.white24,
        style: Theme.of(context).textTheme.bodyText2.apply(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Password',
          border: InputBorder.none,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          icon: Icon(
            Icons.lock_outline,
            color: Colors.white,
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _obsecurePassword = !_obsecurePassword;
              });
            },
            child: _obsecurePassword
                ? Icon(
                    Icons.visibility,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.visibility_off,
                    color: Colors.white,
                  ),
          ),
          suffixIconConstraints:
              BoxConstraints.tight(Size(Sizes.dimen_48.w, Sizes.dimen_12.h)),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Login',
          style: Theme.of(context).textTheme.headline2,
        ),
        Padding(
          padding: EdgeInsets.all(Sizes.dimen_16.w),
          child: FloatingActionButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });

                await _auth
                    .signIn(_emaileditingcontroller.text.trim(),
                        _passwordeditingcontroller.text.trim())
                    .then((result) async {
                  if (result != null) {
                    snapshotUserInfo = await _databaseMethods
                        .getUserInfo(_emaileditingcontroller.text.trim());

                    HelperFunctions.saveUserEmailSharedPreference(
                        snapshotUserInfo.docs[0].data()["email"]);

                    HelperFunctions.saveUserNameSharedPreference(
                        snapshotUserInfo.docs[0].data()['name']);

                    HelperFunctions.saveUserLoggedInSharedPreference(true);

                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ));
                  }
                });
              } else {
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: Icon(FontAwesomeIcons.arrowRight),
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget loginViaGoogleButton() {
    return Padding(
      padding: EdgeInsets.only(
          left: Sizes.dimen_80.w,
          top: Sizes.dimen_14.h,
          right: Sizes.dimen_80.w),
      child: InkWell(
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          await _auth.signInWithGoogle();

          // String _gEmail = _googleSignIn.currentUser.email;
          // String _gDisplayName = _googleSignIn.currentUser.displayName;
          // // String _gPhoto = _googleSignIn.currentUser.photoUrl;
          // // String _gId = _googleSignIn.currentUser.id;

          // HelperFunctions.saveUserEmailSharedPreference(_gEmail);
          // HelperFunctions.saveUserNameSharedPreference(_gDisplayName);
          // HelperFunctions.saveUserLoggedInSharedPreference(true);

          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF262630),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_14.w),
                  child: SvgPicture.asset(
                    'assets/images/GoogleLogo.svg',
                    // color: Colors.white,
                    width: Sizes.dimen_20.w,
                    height: Sizes.dimen_10.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h),
                  child: VerticalDivider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.dimen_16.w, vertical: Sizes.dimen_6.h),
                  child: Text(
                    'Login with Google',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .apply(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void navigatorToSignupScreen() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => SignupScreeen(),
  //     ),
  //   );
  // }
}
