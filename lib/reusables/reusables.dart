import 'package:flutter/material.dart';


TextField reusableTextField(String text, IconData icon, bool isPasswordType, TextEditingController controller){
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: const TextStyle(
      color: Colors.white,
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white38,
      ),
      labelText: text,
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white54,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    keyboardType: isPasswordType
    ? TextInputType.visiblePassword
    :TextInputType.text,
  );
}
Container button(BuildContext context, ButtonType buttonType, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black38;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ))),
      child: Text(
        buttonType == ButtonType.SignUp ? 'Бүртгүүлэх' : 'Нэвтрэх',
        style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20,
        ),
      ),
    ),
  );
}

enum ButtonType { SignUp, Login }
