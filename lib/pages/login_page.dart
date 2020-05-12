import 'package:app/widgets/basic_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

import 'package:app/core/core.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logoWidthRatio = 0.4;
  String _lastDetectedError = "";
  TextEditingController _usernameTextController;
  TextEditingController _passwordTextController;

  @override
  void initState() {
    _lastDetectedError = "";
    _usernameTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var localization = context.watch<Localization>();

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 10,
                shape: CircleBorder(),
                child: Container(
                  width: MediaQuery.of(context).size.width * logoWidthRatio,
                  height: MediaQuery.of(context).size.width * logoWidthRatio,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/foto-vittorio.jpg")),
                      boxShadow: [BoxShadow()]),
                ),
              ),
              SizedBox(height: 15),

              Column(children: <Widget>[
                Text(
                    _lastDetectedError.length > 0
                        ? _lastDetectedError
                        : localization["loginPageInviteToLogin"],
                    textAlign: TextAlign.center,
                    style: _lastDetectedError.length > 0
                        ? Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.redAccent)
                        : Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 5),
              ]),

              _CredentialTextField(
                leadingIcon: Icon(Icons.person),
                isPassword: false,
                hintText: localization["placeholderEmailTextField"],
                textController: _usernameTextController,
              ),

              _CredentialTextField(
                leadingIcon: Icon(Icons.vpn_key),
                isPassword: true,
                hintText: localization["placeholderPasswordTextField"],
                textController: _passwordTextController,
              ),
              SizedBox(height: 10),

              // Submit button
              BasicButton(
                onTap: _onSubmitButtonPressed,
                animationScale: -1.2,
                color: Theme.of(context).primaryColor,
                hasShadow: false,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                borderRadius: BorderRadius.circular(100),
                child: Text(localization["loginPageLoginWithCredentialsLabel"],
                    textAlign: TextAlign.center, maxLines: 2),
              ),
              SizedBox(height: 20),

              Text(localization["labelOr"],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1),
              SizedBox(height: 20),

              SignInButton(
                Buttons.Google,
                onPressed: _onGoogleButtonPressed,
                text: localization["loginPageLoginWithGoogleLabel"],
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              ),
              SizedBox(height: 10),

              SignInButton(
                Buttons.Facebook,
                onPressed: _onFacebookButtonPressed,
                text: localization["loginPageLoginWithFacebookLabel"],
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _onSubmitButtonPressed() {
    // TODO: Attempt real authentication here
  }

  void _onGoogleButtonPressed() {
    // TODO: Attempt real authentication here
  }

  void _onFacebookButtonPressed() {
    // TODO: Attempt real authentication here
  }

  void _printError(String error) {
    setState(() => _lastDetectedError = error);
  }
}

class _CredentialTextField extends StatelessWidget {
  final Icon leadingIcon;
  final TextEditingController textController;
  final bool isPassword;
  final String hintText;

  const _CredentialTextField(
      {Key key,
      this.leadingIcon,
      this.textController,
      this.isPassword,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        maxLines: 1,
        autocorrect: false,
        obscureText: isPassword,
        controller: textController,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: leadingIcon,
            contentPadding: EdgeInsets.all(8.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}
