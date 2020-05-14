import 'package:app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'widgets/credential_login_form.dart';
import 'widgets/header_logo_image.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Building: LoginPage");
    var localization = Provider.of<LocalizationService>(context, listen: false);
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                HeaderLogoImageWidget(logoWidthRatio: 0.4),
                SizedBox(height: 15),

                // Welcome/Error message formatting
                Column(children: <Widget>[
                  Consumer<AuthenticationService>(
                      builder: (context, value, child) {
                    return Text(
                        value.hasError
                            ? value.error.toString()
                            : localization["loginPageInviteToLogin"],
                        textAlign: TextAlign.center,
                        style: value.hasError
                            ? Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.redAccent)
                            : Theme.of(context).textTheme.bodyText1);
                  }),
                  SizedBox(height: 5),
                ]),

                CredentialLoginFormWidget(
                  usernameHintText: localization["placeholderEmailTextField"],
                  passwordHintText:
                      localization["placeholderPasswordTextField"],
                  submitButtonText:
                      localization["loginPageLoginWithCredentialsLabel"],
                  onSubmit: (u, p) => _onSubmitButtonPressed(context, u, p),
                ),
                SizedBox(height: 20),

                Text(localization["labelOr"],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),

                SignInButton(
                  Buttons.Google,
                  onPressed: () => _onGoogleButtonPressed(context),
                  text: localization["loginPageLoginWithGoogleLabel"],
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _onSubmitButtonPressed(
      BuildContext context, String username, String password) {
    setState(() {
      _isLoading = true;
    });
    Provider.of<AuthenticationService>(context, listen: false).login(username, password).whenComplete(() => setState(() {
      _isLoading = false;
    }));
  }

  void _onGoogleButtonPressed(BuildContext context) {
    // TODO: Attempt real authentication here
  }
}
