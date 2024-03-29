
import 'package:flutter/material.dart';

class FlutterFlowDropDown extends StatefulWidget {
   FlutterFlowDropDown({
    required this.options,
    required this.onChanged,
    this.icon,
    this.width,
    this.height,
    this.fillColor,
    this.textStyle,
    this.elevation,
    this.borderWidth,
    this.borderRadius,
    this.borderColor,
    this.margin,
  });

   List<String> options;
   Function(String) onChanged;
   Widget? icon;
   double? width;
   double? height;
   Color? fillColor;
   TextStyle? textStyle;
   double? elevation;
   double? borderWidth;
  double? borderRadius;
  Color? borderColor;
   EdgeInsetsGeometry? margin;

  @override
  State<FlutterFlowDropDown> createState() => _FlutterFlowDropDownState();
}

class _FlutterFlowDropDownState extends State<FlutterFlowDropDown> {
  String? dropDownValue;
  List<String>? effectiveOptions;

  @override
  void initState() {
    effectiveOptions = widget.options.isEmpty ? ['[Option]'] : widget.options;
    dropDownValue = effectiveOptions!.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final childWidget = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 28),
        border: Border.all(
          color: widget.borderColor!,
          width: widget.borderWidth!,
        ),
        color: widget.fillColor,
      ),
      child: Padding(
        padding: widget.margin!,
        child: DropdownButton<String>(
          value: dropDownValue,
          items: effectiveOptions
              !.map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: widget.textStyle,
                    ),
                  ))
              .toList(),
          elevation: widget.elevation!.toInt(),
          onChanged: (value) {
            dropDownValue = value;
            widget.onChanged(value!);
          },
          icon: widget.icon,
          isExpanded: true,
          dropdownColor: widget.fillColor,
        ),
      ),
    );
    if (widget.height != null || widget.width != null) {
      return Container(
          width: widget.width, height: widget.height, child: childWidget);
    }
    return childWidget;
  }
}
