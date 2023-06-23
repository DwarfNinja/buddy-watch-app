import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountField extends StatefulWidget {
  final TextEditingController? controller;
  final String text;
  final String hint;
  final bool private;
  final IconData? icon;
  final TextInputType? keyboardType;
  final ValidatorFunction? validatorFunction;

  const AccountField({Key? key,
    required this.text,
    required this.hint,
    this.controller,
    this.private = false,
    this.icon,
    this.keyboardType,
    this.validatorFunction,
  }) : super(key: key);

  @override
  State<AccountField> createState() => _AccountFieldState();
}

class _AccountFieldState extends State<AccountField> {
  bool textVisible = false;
  bool empty = true;

  Widget? getIcon() {
    if (widget.private) {
      return IconButton(
        icon: Icon(
          textVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            textVisible = !textVisible;
          });
        },
      );
    }
    else if (widget.icon != null) {
      return Icon(
          widget.icon,
          color: Colors.grey);
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                  widget.text,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            )
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          maxLines: 1,
          obscureText: !widget.private ? false : !textVisible,
          decoration: InputDecoration(
            errorStyle: const TextStyle(height: 0.75),
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(12),
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: !empty ? Colors.green : Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            errorMaxLines: 2,
            hintText: widget.hint,
            hintStyle: GoogleFonts.montserrat(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w400),
            suffixIcon: getIcon(),
          ),
          validator: (String? value) {

            if (value != null && widget.validatorFunction != null) {
              return widget.validatorFunction!.build(value);
            }
            return null;
          },
          onChanged: (String? value) => setState(() {
            empty = (value == null || value.isEmpty) ? true : false;
          }),
        ),
      ],
    );
  }
}

class ValidatorFunction {
  final RegExp? regex;
  final Function? function;
  final String message;

  const ValidatorFunction({this.regex, this.function, required this.message});

  String? build(String value) {
    if (function != null) {
      function!();
    }
    if (regex != null && !regex!.hasMatch(value)) {
      return message;
    }
    return null;
  }
}