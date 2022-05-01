import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/sanatorium.dart';
import '../../helpers/constants.dart';
import '../../helpers/enums.dart';
import '../../controllers/controller.dart';
import '../home.dart';
import '../list_relaxers.dart';
import 'widgets/field_name.dart';
import 'widgets/icon_button.dart';
import 'widgets/text_field.dart';
import 'widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late final Controller _httpController;
  late TextEditingController inputController;
  String? sanatoriumName;
  late ValueNotifier<ValidationState> textFieldValidation;
  bool dropDownEmpty = false;
  late ValueNotifier<bool> isButtonActive;
  final RegExp _regExpEmail = RegExp(
      r"^[\w.%+-]+@[A-z0-9.-]+\.[A-z]{2,}$",
      multiLine: false
  );

  @override
  void initState() {
    super.initState();

    _httpController = Controller.instance;
    inputController = TextEditingController();
    inputController.addListener(_controllerListener);
    textFieldValidation = ValueNotifier(ValidationState.valid);
    isButtonActive = ValueNotifier(true);
  }

  void _controllerListener() {
    if (inputController.text.isNotEmpty) {
      setState(() {
        isButtonActive.value = true;
      });
    }
  }

  @override
  void dispose() {
    inputController.removeListener(_controllerListener);
    textFieldValidation.dispose();
    isButtonActive.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/medicine.png'),
              alignment: Alignment.bottomRight,
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
          child: Column(children: [
            _buildIconButton(context),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ).copyWith(top: 30),
                child: Column(
                  children: [
                    const Text(
                      'Добро пожаловать',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PT-Sans',
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const FieldName(text: 'Санаторий'),
                    _buildDropDownField(
                      hintText: 'Выберите санаторий',
                      prefixedIcon: const Icon(Icons.home_work_outlined,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const FieldName(text: 'Email'),
                    MyTextField(
                      controller: inputController,
                      prefixedIcon:
                          const Icon(Icons.email_outlined, color: Colors.white),
                      hintText: 'Введите email',
                      invalidText: 'Неверный email',
                      textFieldValidation: textFieldValidation,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LoginButton(
                      isButtonActive : isButtonActive,
                      onPressed: isButtonActive.value
                          ? () async {
                              setState(() {
                                validateEmail();
                                sanatoriumName == null
                                    ? dropDownEmpty = true
                                    : dropDownEmpty = false;
                                isButtonActive.value = false;
                              });
                              if (sanatoriumName != null &&
                                  textFieldValidation.value ==
                                      ValidationState.valid) {
                                _checkLogin();
                              }
                            }
                          : null,
                    ),
                  ],
                ),
              ),
          ]),
        ),
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      alignment: Alignment.topRight,
      child: MyIconButton(
        icon: Icons.group,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ListRelaxers()))
      )
    );
  }

  Widget _buildDropDownField({
    Widget? prefixedIcon,
    required String hintText,
  }) {
    return Material(
      color: Colors.transparent,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        items: Sanatorium.sanatoriumMap.map((name, code) {
          return MapEntry(
              code,
          DropdownMenuItem<String>(
            child: Text(
                name,
                style: const TextStyle(color: Colors.white),
            ),
            value: code,
          ));
        }).values.toList(),
        value: sanatoriumName,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.white70,
        dropdownColor: dropdownColor,
        decoration: InputDecoration(
          border: dropDownEmpty ?
            const UnderlineInputBorder(
              borderSide: BorderSide(color: redColor, width: 1),
            )
            : InputBorder.none,
          filled: true,
          fillColor: fieldColor.withOpacity(0.95),
          prefixIcon: prefixedIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontFamily: 'PTSans',
          ),
          errorText: dropDownEmpty ? 'Это поле не может быть пустым' : null,
          errorStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: redColor,
          ),
        ),
          onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              sanatoriumName = newValue;
              isButtonActive.value = true;
            });
          }
        },
      )
    );
  }

  Future<void> _checkLogin() async {
    _httpController.fetchData(sanatoriumName!, inputController.text.trim());
    await wait();
    if (_httpController.getStateLogin() == ResponseState.success) {
      _httpController.writeToDB();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyHomePage()));
    } else if (_httpController.getStateLogin() == ResponseState.no_connection) {
      Fluttertoast.showToast(msg: "Проверьте интернет соединение");
    } else {
      Fluttertoast.showToast(msg: "Отдыхающий не найден");
    }
    setState(() {
      isButtonActive.value = true;
    });
  }

  Future<void> wait() async {
    int chanceCount = 5;
    for (int i = 0; i < chanceCount; i++) {
      if (_httpController.getStateLogin() != ResponseState.processing) {
        break;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void validateEmail() {
    if(inputController.text.trim().isEmpty) {
      textFieldValidation.value = ValidationState.empty;
      return;
    }
    if (_regExpEmail.hasMatch(inputController.text.trim())) {
      textFieldValidation.value = ValidationState.valid;
    } else {
      textFieldValidation.value = ValidationState.invalid;
    }
  }
}