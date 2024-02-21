
import 'package:flutter/material.dart';

class FlutterFlowIconButton extends StatelessWidget {
   FlutterFlowIconButton(
      {Key? key,
      this.borderColor,
      this.borderRadius,
      this.borderWidth,
      this.buttonSize,
      this.fillColor,
      this.icon,
      required this.onPressed})
      : super(key: key);

   double? borderRadius;
   double? buttonSize;
   Color? fillColor;
   Color? borderColor;
   double? borderWidth;
   Widget? icon;
   void Function() onPressed;

  @override
  Widget build(BuildContext context) => Material(
        borderRadius: BorderRadius.circular(borderRadius!),
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: Ink(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 0,
            ),
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          child: IconButton(
            icon: icon!,
            onPressed: onPressed,
            splashRadius: buttonSize,
          ),
        ),
      );
}
