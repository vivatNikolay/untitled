import 'package:flutter/material.dart';

import '../controllers/controller.dart';
import '../models/relaxer.dart';
import 'home.dart';

class ListRelaxers extends StatefulWidget {
  final String title = 'Аккаунты';

  ListRelaxers({Key? key}) : super(key: key);

  @override
  _ListRelaxersState createState() => _ListRelaxersState();
}

class _ListRelaxersState extends State<ListRelaxers> {
  late final HttpController _httpController;
  late List<Relaxer> relaxers;

  @override
  void initState() {
    super.initState();

    _httpController = HttpController.instance;
    relaxers = _httpController.getRelaxers();
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
                MaterialPageRoute(builder: (context) => const MyHomePage()));
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
                onTap: () {
                  if (relaxers[index].email != _httpController.getActiveRelaxer().email ||
                      relaxers[index].sanatorium != _httpController.getActiveRelaxer().sanatorium) {
                    _httpController.makeInActive();
                    _httpController.fetchData(
                        relaxers[index].sanatorium, relaxers[index].email);
                    wait();
                    _httpController.writeToDB();
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const MyHomePage()));
                },
              ),
            );
          });
    }
  }

  Future<void> wait() async {
    int chanceCount = 5;
    for (int i = 0; i < chanceCount; i++) {
      await Future.delayed(const Duration(seconds: 1));
      if (!_httpController.isProcessing()) {
        break;
      }
    }
  }
}
