import 'package:flutter/material.dart';

class CredentialTextField extends StatelessWidget {
  final Icon leadingIcon;
  final TextEditingController textController;
  final bool isPassword;
  final String hintText;

  const CredentialTextField(
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
