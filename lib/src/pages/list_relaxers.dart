import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/src/pages/login/login.dart';
import '../controllers/controller.dart';
import '../controllers/response_state.dart';
import '../models/relaxer.dart';
import 'home.dart';

class ListRelaxers extends StatefulWidget {
  final String title = 'Аккаунты';
  bool backToLogin;

  ListRelaxers({Key? key, required this.backToLogin}) : super(key: key);

  @override
  _ListRelaxersState createState() => _ListRelaxersState(backToLogin);
}

class _ListRelaxersState extends State<ListRelaxers> {
  late final HttpController _httpController;
  late List<Relaxer> relaxers;
  bool backToLogin;
  bool _isTapActive = false;

  _ListRelaxersState(this.backToLogin);

  @override
  void initState() {
    super.initState();

    _httpController = HttpController.instance;
    relaxers = _httpController.getRelaxers();
    _isTapActive = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF81B7AE),
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) =>
                backToLogin == true
                    ? const LoginScreen()
                    : const MyHomePage()
                ));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (relaxers.isEmpty) {
      return const Center(
          child: Text(
        "Аккаунтов нет",
        style: TextStyle(
            color: Color(0xFF7B7B7B),
            fontSize: 19.0,
            fontFamily: 'TimesNewRoman'),
      ));
    } else {
      return ListView.builder(
          itemCount: relaxers.length,
          itemBuilder: (_, index) {
            return Card(
              shadowColor: const Color(0xFF75AAA1),
              elevation: 4.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40.0,
                  child: Image.asset(relaxers[index].sex
                      ? "assets/images/man.png"
                      : "assets/images/woman.png"),
                ),
                title:
                    Text("${relaxers[index].name} ${relaxers[index].surname}"),
                subtitle: Text(relaxers[index].email),
                onTap: _isTapActive ? () async {
                  setState(() => _isTapActive = false);
                  await selectAction(index);
                }
                : null,
              ),
            );
          });
    }
  }

  Future<void> selectAction(int index) async {
    if (relaxers[index] != _httpController.getActiveRelaxer()) {
      _httpController.fetchAssignments(
          relaxers[index].sanatorium, relaxers[index].email);
      await wait();

      if (_httpController.getStateUpdate() == ResponseState.success) {
        _httpController.makeInActive();
        _httpController.makeActive(relaxers[index]);
        _httpController.updateAssignments();

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const MyHomePage()));
      } else if (_httpController.getStateUpdate() == ResponseState.no_connection) {
        Fluttertoast.showToast(msg: "Проверьте интернет соединение");
      } else {
        Fluttertoast.showToast(msg: "Ошибка");
      }
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MyHomePage()));
    }
  }

  Future<void> wait() async {
    int chanceCount = 5;
    for (int i = 0; i < chanceCount; i++) {
      if (_httpController.getStateUpdate() != ResponseState.processing) {
        break;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
