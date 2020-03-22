
import 'package:flutter/material.dart';

class FormArea extends StatelessWidget {

  FormArea({this.hintText,this.icon,this.myController});
  final String hintText;
  final Icon icon;
  final   TextEditingController  myController;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 40,
      width: 280,
      color: Colors.white,
      child: TextField(
        controller:myController ,
        decoration: InputDecoration(
            prefixIcon: icon,
            hintText: hintText
        ),

      ),

    );
  }
}
