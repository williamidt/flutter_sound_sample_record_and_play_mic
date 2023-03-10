import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  final bool? defaultColor;
  final Color? color;

  const MyIconButton({Key? key, required this.icon, required this.onTap,
    this.defaultColor, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width:  50,
        child: Icon(icon,
          size: 40,
          color: (defaultColor!=null &&
              defaultColor==true? Theme.of(context).primaryColor:
                color ?? Theme.of(context).disabledColor)
        ),
      ),
    );
  }


}

