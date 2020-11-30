import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twelve_weeks/generated/l10n.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 3, child: homeHeader()),
            Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.red[300], Colors.red]),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(48.0),
                      topRight: const Radius.circular(48.0),
                    )),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, top: 18.0, bottom: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: taskHeader('Your daily goals'),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: ListView(
                          children: [
                            taskHeader('#1 Loose weight'),
                            taskCard(new List<String>.of([
                              'Go jogging',
                              'Eat under 2000 kcal',
                              'Piss a lot'
                            ])),
                            taskHeader('#1 Loose weight'),
                            taskCard(new List<String>.of([
                              'Go jogging',
                              'Eat under 2000 kcal',
                              'Piss a lot'
                            ])),
                            taskHeader('#1 Loose weight'),
                            taskCard(new List<String>.of([
                              'Go jogging',
                              'Eat under 2000 kcal',
                              'Piss a lot'
                            ])),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget homeHeader() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: S.of(context).week,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal),
                      children: <TextSpan>[
                    TextSpan(
                        text: ' 1/12',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold))
                  ])),
              RichText(
                  text: TextSpan(
                      text: S.of(context).daysLeft(1, 1.toStringAsFixed(1)),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal),
                      children: <TextSpan>[
                        TextSpan(
                            text: '98 ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'dni',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal))
                      ]))
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: CircularProgressIndicator(
                        strokeWidth: 8.0, value: 0.9)),
                Text('90%',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget taskHeader(String header) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        header,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget taskCard(List<String> texts) {
    return Card(
        margin: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var text in texts)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '$text',
                  ),
                ),
            ],
          ),
        ));
  }
}
