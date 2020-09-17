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
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 80, left: 16),
                        child: SamoleLogo(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 28),
                        child: Text(
                          "Welcome back!",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Text(
                          "Enter your email address and password to get access your account.",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color:
                                Color(0xFF262630), //BorderRadius.circular(10),
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
                            padding: EdgeInsets.only(top: 40),
                            child: loginButton(),
                          ),
                        ],
                      ),
                      loginViaGoogleButton(),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 50),
                        child: Text(
                          'Don\'t have an account?',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          //navigatorToSignupScreen();
                          widget.toggleView();
                        },
                        child: Text(
                          "Create account",
                          style: Theme.of(context).textTheme.headline3,
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
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 0),
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
        style: Theme.of(context).textTheme.bodyText1,
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
      padding: EdgeInsets.only(left: 16),
      child: Divider(
        color: Color(0xFF2c2f37),
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
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
        style: Theme.of(context).textTheme.bodyText1,
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
          suffixIconConstraints: BoxConstraints.tight(Size(56, 24)),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: Theme.of(context).textTheme.headline2,
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: FloatingActionButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });

                await _auth
                    .signIn(_emaileditingcontroller.text,
                        _passwordeditingcontroller.text)
                    .then((result) async {
                  if (result != null) {
                    snapshotUserInfo = await _databaseMethods
                        .getUserInfo(_emaileditingcontroller.text);

                    HelperFunctions.saveUserEmailSharedPreference(
                        snapshotUserInfo.documents[0].data["email"]);

                    HelperFunctions.saveUserNameSharedPreference(
                        snapshotUserInfo.documents[0].data['name']);

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
      padding: EdgeInsets.only(left: 16, top: 35, right: 16),
      child: InkWell(
        onTap: () async {
          await _auth.signInWithGoogle();
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: SvgPicture.asset(
                    'assets/images/GoogleLogo.svg',
                    // color: Colors.white,
                    width: 24,
                    height: 24,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: VerticalDivider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Text(
                    'Login with Google',
                    style: Theme.of(context).textTheme.headline3,
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
