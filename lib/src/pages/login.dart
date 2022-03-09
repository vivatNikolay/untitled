import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/src/models/sanatorium.dart';
import 'package:untitled/src/pages/home.dart';
import '../controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final HttpController _httpController = HttpController.instance;
  TextEditingController inputController = TextEditingController();
  var _sanatoriumName;
  bool _textFieldEmpty = false;
  bool _dropDownFieldEmpty = false;


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
                    hintText: 'Выберите санаторий',
                    prefixedIcon: const Icon(Icons.home_work_outlined, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildTextContainer(
                    text: 'Email'
                  ),
                  _buildTextField(
                    hintText: 'Введите email',
                    prefixedIcon: const Icon(Icons.email_outlined, color: Colors.white),
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
        value: _sanatoriumName,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.white70,
        dropdownColor: const Color(0xFF803DBB),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF803DBB),
          prefixIcon: prefixedIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontFamily: 'PTSans',
          ),
          errorText: _dropDownFieldEmpty ? 'Это поле не может быть пустым' : null,
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBA1818), width: 1),
          ),
          errorStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFBA1818),
          ),
        ),
          onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _sanatoriumName = newValue;
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
          errorText: _textFieldEmpty ? 'Это поле не может быть пустым' : null,
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBA1818), width: 1),
          ),
          errorStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFBA1818),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
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
          setState(() {
            inputController.text.isEmpty ? _textFieldEmpty = true : _textFieldEmpty = false;
            _sanatoriumName == null ? _dropDownFieldEmpty = true : _dropDownFieldEmpty = false;
          });
          if (_sanatoriumName != null && inputController.text.isNotEmpty) {
            _checkLogin();
          }
        },
      ),
    );
  }

  Future<void> _checkLogin() async {
    _httpController.init(_sanatoriumName, inputController.text);
      await Future.delayed(const Duration(seconds: 1));
      if (_httpController.isSuccess()) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyHomePage()));
      } else {
        Fluttertoast.showToast(
            msg: "Отдыхающий не найден",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 17.0
        );
      }
  }
}