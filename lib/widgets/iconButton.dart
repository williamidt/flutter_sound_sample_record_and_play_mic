import 'package:flutter/material.dart';
import 'package:flutter_sound_sample_record_and_play_mic/constants/constants.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  final double buttonSize;
  final bool? defaultColor;
  final Color? color;

  const MyIconButton({Key? key, required this.icon, required this.onTap,
     required this.buttonSize, this.defaultColor, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: (buttonSize==1?kSmallButton:
                 buttonSize==2?kMediumButton:
                 buttonSize==3?kLargerButton:
                 buttonSize==4?kBiggerButton:
                 kSmallButton),
        width:  (buttonSize==1?kSmallButton:
                 buttonSize==2?kMediumButton:
                 buttonSize==3?kLargerButton:
                 buttonSize==4?kBiggerButton:
                 kSmallButton),
        child: Icon(icon,
          size: (buttonSize==1?kSmallIcon:
                 buttonSize==2?kMediumIcon:
                 buttonSize==3?kLargerIcon:
                 buttonSize==4?kBiggerIcon:
                 kSmallIcon),
          color: (defaultColor!=null &&
              defaultColor==true? Theme.of(context).primaryColor:
                color ?? Theme.of(context).disabledColor)
        ),
      ),
    );
  }


}

