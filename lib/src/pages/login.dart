import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/models/sanatorium.dart';
import 'package:untitled/src/pages/tabs.dart';
import '../http_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final HttpController _httpController = HttpController.instance;
  TextEditingController inputController = TextEditingController();
  var frequencySanatoriumName;

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6033B1),
                Color(0xFF8439BF),
                Color(0xFF9E41D0),
                Color(0xFF8E3DC7),
                Color(0xFF6F3BC2),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 108),
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
                  _buildTextContainer(
                      text: 'Санаторий'
                  ),
                  _buildDropDownField(
                    hintText: 'Введите ваш санаторий',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildTextContainer(
                    text: 'Телефон'
                  ),
                  _buildTextField(
                    hintText: 'Введите номер телефона',
                    prefixedIcon: const Icon(Icons.phone_iphone, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildLoginButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextContainer({
  required String text,
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'PT-Sans',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDropDownField({
    required String hintText,
  }) {
    return Material(
      color: const Color(0xFF803DBB),
      elevation: 2,
      child: DropdownButton<String>(
        isExpanded: true,
        items: Sanatorium.sanatoriumMap.map((name, code) {
          return MapEntry(
              code,
          DropdownMenuItem<String>(
            child: Text(
                "    $name",
                style: const TextStyle(color: Colors.white),
            ),
            value: code,
          ));
        }).values.toList(),
        value: frequencySanatoriumName,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.white70,
        dropdownColor: const Color(0xFF803DBB),
        underline: const SizedBox(),
        hint: Text(
            "    $hintText",
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontFamily: 'PTSans',
            ),
          ),
          onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              frequencySanatoriumName = newValue;
            });
          }
        },
      )
    );
  }

  Widget _buildTextField({
    Widget? prefixedIcon,
    required String hintText,
  }) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      child: TextField(
        controller: inputController,
        cursorColor: Colors.white,
        cursorWidth: 2,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: const Color(0xFF803DBB),
          prefixIcon: prefixedIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontFamily: 'PTSans',
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          elevation: MaterialStateProperty.all(6),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        child: const Text(
          'Войти',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onPressed: () async {
          if (_checkPhone()) {
            await Future.delayed(const Duration(seconds: 2));
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const MyHomePage()
                ));
          }
        },
      ),
    );
  }

  bool _checkPhone() {
    _httpController.init(frequencySanatoriumName, inputController.text);
    return true;
  }
}