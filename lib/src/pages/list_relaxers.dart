import 'package:flutter/material.dart';

import '../controllers/controller.dart';
import '../models/relaxer.dart';
import 'home.dart';

class ListRelaxers extends StatefulWidget {
  final String title = 'Аккаунты';
  List<Relaxer> relaxers;

  ListRelaxers(this.relaxers, {Key? key}) : super(key: key);

  @override
  _ListRelaxersState createState() => _ListRelaxersState(relaxers);
}

class _ListRelaxersState extends State<ListRelaxers> {
  final HttpController _httpController = HttpController.instance;
  late List<Relaxer> relaxers;

  _ListRelaxersState(this.relaxers);

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
                onTap: () async {
                  _httpController.makeInActive();
                  _httpController.fetchData(
                      relaxers[index].sanatorium, relaxers[index].email);
                  wait();
                  _httpController.writeToDB();
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
      if (!_httpController.isProcessing()) {
        break;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
