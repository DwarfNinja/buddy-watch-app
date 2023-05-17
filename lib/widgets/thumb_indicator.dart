import 'package:buddywatch_app/color_palette.dart';
import 'package:flutter/material.dart';

enum Indication {
  positive,
  warning,
  negative,
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
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              color: (() {
                switch(indication) {
                  case Indication.positive:
                    return ColorPalette.midGreen;
                  case Indication.warning:
                    return ColorPalette.midYellow;
                  case Indication.negative:
                    return ColorPalette.darkRed;
                }
              }()),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Icon(
            indication == Indication.positive ? Icons.thumb_up_rounded : Icons.thumb_down_rounded,
            color: (() {
              switch(indication) {
                case Indication.positive:
                  return ColorPalette.lightGreen;
                case Indication.warning:
                  return ColorPalette.orange;
                case Indication.negative:
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
