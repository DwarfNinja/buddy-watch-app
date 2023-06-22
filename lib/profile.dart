
import 'package:buddywatch_app/color_palette.dart';
import 'package:buddywatch_app/services/auth_service.dart';
import 'package:buddywatch_app/widgets/account_field.dart';
import 'package:buddywatch_app/widgets/date_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {

  const Profile({Key? key})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  final firstNameController = TextEditingController();
  final prepositionController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  bool submitted = false;

  Future<Profile>? profile;


  @override
  void initState() {
    authService.getProfile()
        .then((value) {
          firstNameController.text = value[0]["first_name"];
          prepositionController.text = value[0]["preposition"] != value[0]["preposition"] ? value[0]["preposition"]  : "";
          lastNameController.text = value[0]["last_name"];
          dateOfBirthController.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(value[0]["date_of_birth"]));
          weightController.text = value[0]["height"].toString();
          heightController.text = value[0]["weight"].toString();
    });
    super.initState();
  }


  void onPressedSubmitBasicsChange() {
    final format = DateFormat("dd-MM-yyyy");
    DateTime gettingDate = format.parse(dateOfBirthController.text);
    String formattedDate = DateFormat('yyyy-MM-dd').format(gettingDate);

    if (formKey.currentState!.validate()) {
      profile?.then((value) => {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.darkGrey,
      body: SafeArea(
        child: Form(
          key: formKey,
          autovalidateMode: submitted
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    "Profiel",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 10),
              Container (
                width: 375,
                height: 600,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      AccountField(
                        controller: firstNameController,
                        keyboardType: TextInputType.number,
                        text: "Voornaam",
                        hint: "Voer hier uw voornaam in",
                      ),
                      const Spacer(),
                      AccountField(
                        controller: prepositionController,
                        keyboardType: TextInputType.number,
                        text: "Tussenvoegsel",
                        hint: "Voer hier uw tussenvoegsel in",
                      ),
                      const Spacer(),
                      AccountField(
                        controller: lastNameController,
                        keyboardType: TextInputType.number,
                        text: "Achternaam",
                        hint: "Voer hier uw achternaam in",
                      ),
                      const Spacer(),
                      DateInput(
                        controller: dateOfBirthController,
                        hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                      const Spacer(),
                      AccountField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        text: "Lengte",
                        hint: "Voer hier uw lengte in",
                      ),
                      const Spacer(),
                      AccountField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        text: "Gewicht",
                        hint: "Voer hier uw gewicht in",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: GestureDetector(
                  child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const Icon(
                          Icons.save_rounded,
                          color: Colors.black,
                          size: 45,
                        ),
                      )),
                  onTap: () {
                    authService.updateProfile(
                        firstNameController.text,
                        prepositionController.text,
                        lastNameController.text,
                        dateOfBirthController.text,
                        int.parse(heightController.text),
                        int.parse(weightController.text),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}