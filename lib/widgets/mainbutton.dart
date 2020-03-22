import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {

  MainButton({this.onClick,this.title});
  final Function onClick;
  final String title;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onClick,
      color: Color(0xffFF6B76),
      child: Container(

        width: 250,
        height: 40,
        child: Center(child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
      ),

    );
  }
}
