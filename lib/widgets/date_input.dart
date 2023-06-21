import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {
  final TextEditingController controller;
  final TextStyle? headerStyle;
  final TextStyle? hintStyle;

  const DateInput({
    Key? key,
    required this.controller,
    this.headerStyle,
    this.hintStyle
  }) : super(key: key);

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {

  bool empty = true;
  DateTime? pickedDate;

  @override
  void initState() {
    super.initState();
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
                  "Geboortedatum",
                  style: widget.headerStyle ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
            )
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          maxLines: 1,
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
              borderSide: BorderSide(width: 2, color: empty ? Colors.black : Colors.green),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            hintText: "xx-xx-xxxx",
            hintStyle: widget.hintStyle ?? GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w300),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                builder: (context, child) => Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      onSurface: Colors.black,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                    ),
                  ),
                  child: child!,
                ),
                context: context, initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                initialDatePickerMode: DatePickerMode.year,
                locale: const Locale("nl"),
            );
            if(pickedDate != null ){
              this.pickedDate = pickedDate;

              String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
              setState(() {
                widget.controller.text = formattedDate;
              });
              empty = widget.controller.text.isEmpty ? true : false;
            }
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          },
          validator: (String? value) {
            if (widget.controller.text.isEmpty) {
              return "De geboortedatum mag niet leeg zijn";
            }

            if (DateTime.now().year - DateFormat("dd-MM-yyyy").parse(widget.controller.text).year < 18) {
              return "De gebruiker moet 18 jaar of ouder zijn";
            }

            return null;
          },
        ),
      ],
    );
  }
}