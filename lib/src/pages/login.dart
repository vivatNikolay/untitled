import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/src/models/sanatorium.dart';
import 'package:untitled/src/pages/home.dart';
import '../controllers/controller.dart';
import 'list_relaxers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late final HttpController _httpController;
  late TextEditingController inputController;
  var _sanatoriumName;
  bool _textFieldEmpty = false;
  bool _dropDownFieldEmpty = false;
  bool _isButtonActive = true;

  @override
  void initState() {
    super.initState();

    _httpController = HttpController.instance;
    inputController = TextEditingController();
    inputController.addListener(() {
      if (inputController.text.isNotEmpty) {
        setState(() {
          _isButtonActive = true;
        });
      }
    });
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
              image: AssetImage("assets/images/medicine.png"),
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
                    _buildTextContainer(text: 'Санаторий'),
                    _buildDropDownField(
                      hintText: 'Выберите санаторий',
                      prefixedIcon: const Icon(Icons.home_work_outlined,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildTextContainer(text: 'Email'),
                    _buildTextField(
                      hintText: 'Введите email',
                      prefixedIcon:
                          const Icon(Icons.email_outlined, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildLoginButton()
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
      child: IconButton(
        icon: const Icon(
          Icons.group,
          size: 28,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ListRelaxers(backToLogin: true)));
        },
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
        dropdownColor: const Color(0xFF75A79E),
        decoration: InputDecoration(
          border: _dropDownFieldEmpty ?
            const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFBA1818), width: 1),
            )
            : InputBorder.none,
          filled: true,
          fillColor: const Color(0xFF72A39A).withOpacity(0.95),
          prefixIcon: prefixedIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontFamily: 'PTSans',
          ),
          errorText: _dropDownFieldEmpty ? 'Это поле не может быть пустым' : null,
          errorStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFBA1818),
          ),
        ),
          onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _sanatoriumName = newValue;
              _isButtonActive = true;
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
          border: _textFieldEmpty ?
            const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFBA1818), width: 1),
            )
            : InputBorder.none,
          filled: true,
          fillColor: const Color(0xFF72A39A).withOpacity(0.9),
          prefixIcon: prefixedIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontFamily: 'PTSans',
          ),
          errorText: _textFieldEmpty ? 'Это поле не может быть пустым' : null,
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
        style: OutlinedButton.styleFrom(
          backgroundColor: Color(0xFFA4C1BD).withOpacity(0.7),
          side: const BorderSide (color: Colors.white, width: 2),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
        ),
        child: const Text(
          'Войти',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: _isButtonActive ? () async {
          setState(() {
            inputController.text.trim().isEmpty ? _textFieldEmpty = true : _textFieldEmpty = false;
            _sanatoriumName == null ? _dropDownFieldEmpty = true : _dropDownFieldEmpty = false;
            _isButtonActive = false;
          });
          if (_sanatoriumName != null && inputController.text.isNotEmpty) {
            _checkLogin();
          }
        }
        : null,
      ),
    );
  }

  Future<void> _checkLogin() async {
    _httpController.fetchData(_sanatoriumName, inputController.text.trim());
    await wait();
    if (_httpController.isSuccess()) {
      _httpController.writeToDB();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyHomePage()));
    } else {
      Fluttertoast.showToast(
          msg: "Отдыхающий не найден",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 17.0);
    }
    setState(() {
      _isButtonActive = true;
    });
  }

  Future<void> wait() async {
    int chanceCount = 5;
    for (int i = 0; i < chanceCount; i++) {
      if (!_httpController.isProcessing()) {
        break;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}