import 'package:flutter/material.dart';
import 'package:app/widgets/widgets.dart';

import 'credential_text_field.dart';

class CredentialLoginFormWidget extends StatefulWidget {
  final String usernameHintText;
  final String passwordHintText;
  final String submitButtonText;
  final Function(String, String) onSubmit;

  const CredentialLoginFormWidget(
      {Key key,
      this.onSubmit,
      this.usernameHintText,
      this.passwordHintText,
      this.submitButtonText})
      : super(key: key);

  @override
  _CredentialLoginFormWidgetState createState() =>
      _CredentialLoginFormWidgetState();
}

class _CredentialLoginFormWidgetState extends State<CredentialLoginFormWidget> {
  TextEditingController _usernameTextController;
  TextEditingController _passwordTextController;

  @override
  void initState() {
    _usernameTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CredentialTextField(
          leadingIcon: Icon(Icons.person),
          isPassword: false,
          hintText: widget.usernameHintText,
          textController: _usernameTextController,
        ),

        CredentialTextField(
          leadingIcon: Icon(Icons.vpn_key),
          isPassword: true,
          hintText: widget.passwordHintText,
          textController: _passwordTextController,
        ),
        SizedBox(height: 10),

        // Submit button
        BasicButton(
          onTap: () => widget.onSubmit(
              _usernameTextController.text, _passwordTextController.text),
          animationScale: -1.2,
          color: Theme.of(context).primaryColor,
          hasShadow: false,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          borderRadius: BorderRadius.circular(100),
          child: Text(widget.submitButtonText,
              textAlign: TextAlign.center, maxLines: 2),
        ),
      ],
    );
  }
}
