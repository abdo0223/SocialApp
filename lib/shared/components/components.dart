import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/loginscreen.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/social_app/settings.dart/settings_screen.dart';

void navigateAndEnd(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      result: (Route<dynamic> route) => false,
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  double height = 5.0,
  Color color = Colors.purple,
  @required String string,
  @required Function function,
  String text,
}) =>
    Container(
      width: width,
      height: height,
      color: color,
      child: Center(
        child: MaterialButton(
            minWidth: width,
            textColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(string.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            onPressed: function),
      ),
    );

Widget defaultFormFeild({
  @required String validatorText,
  @required var controller,
  @required var inputType,
  IconData suffixIcon,
  Function suffixPressed,
  @required Icon prefixIcon,
  @required String labelText,
  bool isObsecured = false,
  Function onTap,
}) =>
    TextFormField(
      onChanged: onTap,
      validator: (value) {
        if (value.isEmpty) {
          return validatorText;
        }
        return null;
      },
      controller: controller,
      keyboardType: inputType,
      obscureText: isObsecured,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffixIcon,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) =>
    AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(title),
      actions: actions,
    );

Widget signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateTo(context, SettingScreen());
    }
  });
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
