import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color buttoncolor;
  final Color textcolor;
  const RoundButton({super.key, required this.title, required this.onPressed, required this.buttoncolor, required this.textcolor});

  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    return MaterialButton(onPressed: onPressed,height: media.height*0.055,
    color: buttoncolor
    ,
    minWidth: double.maxFinite,
    shape: RoundedRectangleBorder(
      
      borderRadius: BorderRadius.circular(25),
      
    ),
    child: Text(title,style: TextStyle(color:textcolor,fontSize: 16),),
    
    );
  }
}