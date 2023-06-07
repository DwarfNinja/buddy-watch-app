import 'package:buddywatch_app/color_palette.dart';
import 'package:flutter/material.dart';

enum Indication {
  low,
  elevated,
  high,
  critical,
}

enum SquareSize {
  large,
  medium,
  small,
}

class ThumbIndicator extends StatelessWidget {
  const ThumbIndicator({Key? key, required this.indication, this.size = 75, this.iconSize = 35, this.text}) : super(key: key);

  final Indication indication;
  final double size;
  final double iconSize;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              color: (() {
                switch(indication) {
                  case Indication.low:
                    return ColorPalette.green;
                  case Indication.elevated:
                    return ColorPalette.yellow;
                  case Indication.high:
                    return ColorPalette.darkOrange;
                  case Indication.critical:
                    return ColorPalette.darkRed;
                }
              }()),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Icon(
            indication == Indication.low || indication == Indication.elevated ? Icons.thumb_up_rounded : Icons.thumb_down_rounded,
            color: (() {
              switch(indication) {
                case Indication.low:
                  return ColorPalette.lightGreen;
                case Indication.elevated:
                  return ColorPalette.darkYellow;
                case Indication.high:
                  return ColorPalette.orange;
                case Indication.critical:
                  return ColorPalette.lightRed;
              }
            }()),
            size: iconSize,
          ),
        ),
        const SizedBox(height: 10),
        text != null ? Text(text!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)) : Container(),
      ],
    );
  }
}
