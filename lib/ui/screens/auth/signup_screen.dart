import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hey_fellas/common/constants/size_constants.dart';
import 'package:hey_fellas/helper/helperFunction.dart';
import 'package:hey_fellas/services/auth.dart';
import 'package:hey_fellas/services/database.dart';
import 'package:hey_fellas/ui/screens/auth/common/authbackground.dart';
import 'package:hey_fellas/ui/screens/auth/common/sample_logo.dart';
import 'package:hey_fellas/ui/screens/home/home_screen.dart';
import 'package:hey_fellas/ui/widgets/loader.dart';
import 'package:hey_fellas/common/extensions/size_extension.dart';

class SignupScreeen extends StatefulWidget {
  final Function toggleView;
  SignupScreeen({this.toggleView});

  @override
  _SignupScreeenState createState() => _SignupScreeenState();
}

class _SignupScreeenState extends State<SignupScreeen> {
  final AuthServices _auth = AuthServices();
  final DatabaseMethods _databaseMethods = DatabaseMethods();

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  final FocusNode mailFild = FocusNode();
  final FocusNode passFild = FocusNode();
  final FocusNode confPassFild = FocusNode();

  bool _obsecurePassword = true;
  bool isLoading = false;
  // ignore: unused_field

  // ignore: unused_field
  TextEditingController _emaileditingcontroller = new TextEditingController();
  TextEditingController _passwordeditingcontroller =
      new TextEditingController();
  TextEditingController _confirmPasseditingcontroller =
      new TextEditingController();
  TextEditingController _nameeditingcontroller = new TextEditingController();

  // String _mail = '';
  // String _pass = '';
  // String _confPass = '';
  // String _name = '';

  @override
  Widget build(BuildContext context) {
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
                        child: SamoleLogo(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Sizes.dimen_16.w,
                            right: Sizes.dimen_16.w,
                            top: Sizes.dimen_12.h),
                        child: Text(
                          "Create Account",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Sizes.dimen_16.w,
                            right: Sizes.dimen_16.w,
                            top: Sizes.dimen_4.h),
                        child: Text(
                          "Please enter valid information to access your account",
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
                                0xFF262630), //todo:change color//BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: <Widget>[
                              fullNameTextField(),
                              formDivider(),
                              emailTextField(),
                              formDivider(),
                              passwordTextField(),
                              formDivider(),
                              confirmPasswordTextField(),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Sizes.dimen_12.h),
                        child: createAccountButton(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Sizes.dimen_16.w,
                            right: Sizes.dimen_16.w,
                            top: Sizes.dimen_10.h),
                        child: Text(
                          "Alredy have an account?",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          // navigateToLogin();
                          widget.toggleView();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: Sizes.dimen_4.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .apply(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget fullNameTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      child: TextFormField(
        validator: (val) {
          if (val.isEmpty || val.length < 3) {
            return "Valid name is required";
          }
          return null;
        },
        controller: _nameeditingcontroller,
        // onChanged: (val) {
        //   setState(() {
        //     return _nameeditingcontroller.text = val;
        //   });
        // },
        textInputAction: TextInputAction.next,
        cursorColor: Colors.white24,
        style: Theme.of(context).textTheme.bodyText2.apply(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Username",
          border: InputBorder.none,
          icon: Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
          hintStyle: Theme.of(context).textTheme.bodyText1,
        ),
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }

  Widget formDivider() {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.dimen_20.w,
        right: Sizes.dimen_20.w,
      ),
      child: Divider(
        // color: Color(0xFF2c2f37),
        color: Colors.white54,
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
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
          hintText: "Email",
          border: InputBorder.none,
          icon: Icon(
            Icons.mail_outline,
            color: Colors.white,
          ),
          hintStyle: Theme.of(context).textTheme.bodyText1,
        ),
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      child: TextFormField(
        validator: (val) {
          if (val.isEmpty) {
            return "Password is required";
          } else if (val.length < 4) {
            return "Password is to short";
          }
          return null;
        },
        // onChanged: (val) {
        //   setState(() {
        //     return _passwordeditingcontroller.text = val;
        //   });
        // },
        controller: _passwordeditingcontroller,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.white24,
        obscureText: _obsecurePassword,
        style: Theme.of(context).textTheme.bodyText2.apply(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Password is requird",
          border: InputBorder.none,
          icon: Icon(
            Icons.lock_outline,
            color: Colors.white,
          ),
          hintStyle: Theme.of(context).textTheme.bodyText1,
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
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }

  Widget confirmPasswordTextField() {
    return Padding(
      padding: EdgeInsets.only(
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
          bottom: Sizes.dimen_2.h),
      child: TextFormField(
        validator: (val) {
          if (val.isEmpty) {
            return "Cofirm password required";
          } else if (val.length < 4) {
            return "Password is to short";
          }
          return null;
        },
        // onChanged: (val) {
        //   setState(() {
        //     return _confirmPasseditingcontroller.text = val;
        //   });
        // },
        controller: _confirmPasseditingcontroller,
        cursorColor: Colors.white24,
        obscureText: _obsecurePassword,
        style: Theme.of(context).textTheme.bodyText2.apply(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Confirm password",
          border: InputBorder.none,
          icon: Icon(
            Icons.lock_outline,
            color: Colors.white,
          ),
          hintStyle: Theme.of(context).textTheme.bodyText1,
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

  Widget createAccountButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Create",
          style: Theme.of(context).textTheme.headline2,
        ),
        Padding(
          padding: EdgeInsets.all(Sizes.dimen_16.w),
          child: FloatingActionButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                if (_confirmPasseditingcontroller.text.trim() ==
                    _passwordeditingcontroller.text.trim()) {
                  setState(() {
                    isLoading = true;
                  });
                  await _auth.signUp(_emaileditingcontroller.text.trim(),
                      _passwordeditingcontroller.text.trim());

                  Map<String, String> userInfoMap = {
                    "name": _nameeditingcontroller.text.trim(),
                    "email": _emaileditingcontroller.text.trim(),
                  };

                  _databaseMethods.uploadUserInfo(userInfoMap);

                  HelperFunctions.saveUserEmailSharedPreference(
                      _emaileditingcontroller.text.trim());
                  HelperFunctions.saveUserNameSharedPreference(
                      _nameeditingcontroller.text.trim());
                  HelperFunctions.saveUserLoggedInSharedPreference(true);

                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ));
                }
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

  // void navigateToLogin() {
  //   Navigator.of(context).pop();
  // }
}
