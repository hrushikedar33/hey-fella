import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hey_fellas/helper/helperFunction.dart';
import 'package:hey_fellas/services/auth.dart';
import 'package:hey_fellas/services/database.dart';
import 'package:hey_fellas/ui/screens/auth/common/authbackground.dart';
import 'package:hey_fellas/ui/screens/auth/common/sample_logo.dart';
import 'package:hey_fellas/ui/screens/home/home_screen.dart';

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
                          "Create Account",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Text(
                          "Please enter valid information to access your account",
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
                        padding: EdgeInsets.only(top: 30),
                        child: createAccountButton(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 30),
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
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login",
                            style: Theme.of(context).textTheme.headline3,
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
      padding: EdgeInsets.symmetric(horizontal: 16),
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
        style: Theme.of(context).textTheme.bodyText1,
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
      padding: EdgeInsets.only(left: 16),
      child: Divider(
        color: Color(0xFF2c2f37),
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
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
        style: Theme.of(context).textTheme.bodyText1,
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
      padding: EdgeInsets.symmetric(horizontal: 16),
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
        obscureText: _obsecurePassword,
        style: Theme.of(context).textTheme.bodyText1,
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
          suffixIconConstraints: BoxConstraints.tight(Size(56, 24)),
        ),
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }

  Widget confirmPasswordTextField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
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
        obscureText: _obsecurePassword,
        style: Theme.of(context).textTheme.bodyText1,
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
          suffixIconConstraints: BoxConstraints.tight(Size(56, 24)),
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
          padding: EdgeInsets.all(16),
          child: FloatingActionButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                if (_confirmPasseditingcontroller.text ==
                    _passwordeditingcontroller.text) {
                  setState(() {
                    isLoading = true;
                  });
                  await _auth.signUp(_emaileditingcontroller.text,
                      _passwordeditingcontroller.text);

                  Map<String, String> userInfoMap = {
                    "name": _nameeditingcontroller.text,
                    "email": _emaileditingcontroller.text,
                  };

                  _databaseMethods.uploadUserInfo(userInfoMap);

                  HelperFunctions.saveUserEmailSharedPreference(
                      _emaileditingcontroller.text);
                  HelperFunctions.saveUserNameSharedPreference(
                      _nameeditingcontroller.text);
                  HelperFunctions.saveUserLoggedInSharedPreference(true);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
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
