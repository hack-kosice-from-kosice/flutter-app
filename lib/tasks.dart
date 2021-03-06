import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sleep_it_app/widgets/learning/learning_route.dart';

import 'data/DailyTask.dart';
import 'data/data.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _random = new Random();

  Future<List<DailyTask>> getDailyTasks() {
    return http
        .get(
            'http://ec2-3-122-178-28.eu-central-1.compute.amazonaws.com:8080/users/123/daily-tasks')
        .then((response) {
      return ((json.decode(response.body) as Map)['dailyTasks'] as List)
          .map((e) => DailyTask.fromJson(e))
          .where((element) => (element.status == 'ACTIVE'))
          .toList();
    });
  }

  FutureBuilder generateItemsList() {
    Future<List<DailyTask>> dailyTasks = getDailyTasks();
    int index = 0; // ignore: unused_local_variable
    return FutureBuilder<List<DailyTask>>(
      future: dailyTasks,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? snapshot.data.length == 0 ?
        Text(
          'All Challenges Completed!',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w200,
          ),
        ):
        ListView.builder(
                itemCount: snapshot.data.length,
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(snapshot.data[index].name),
                    background: slideRightBackground(),
                    secondaryBackground: slideLeftBackground(),
                    child: new Tooltip(
                      message: 'Swipe right to complete the task',
                      child: new Container(
                        padding: const EdgeInsets.all(5),
                        decoration: index % 2 == 0
                            ? new BoxDecoration(color: Colors.lightBlueAccent.shade50)
                            : new BoxDecoration(color: Colors.lightBlue.shade50),
                        child: new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LearningRoute(
                                    skillId: snapshot.data[index].skillId),
                              ),
                            );
                          },
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                margin: new EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 2),
                                child: new CachedNetworkImage(
                                  imageUrl: snapshot.data[index].imageURL,
                                  height: 150.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: new Text(
                                      snapshot.data[index].name,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.black),
                                    ),
                                  ),
                                  new Container(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: new Text(
                                      snapshot.data[index].description,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10.0,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Sure you won't do \"${snapshot.data[index].name}\" today?"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      sendTaskRequest(1, index, false);
                                      setState(() {
                                        snapshot.data.removeAt(index);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      } else {
                        sendTaskRequest(123, snapshot.data[index].id, true);
                        snapshot.data.removeAt(index);
                        return true;
                      }
                    },
                  );
                },
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incr ementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //appBar: AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      //title: Text(widget.title),
      //),
      body: generateItemsList(),
      /*Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),*/
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.star_border,
              color: Colors.white,
            ),
            Text(
              awesomeQuotes[0 + _random.nextInt(8 - 0)],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Maybe tomorrow...",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}

Future<http.Response> sendTaskRequest(int userId, int taskId, bool done) {
  String returnCode;
  if (done) {
    returnCode = 'MARK_AS_ACHIEVED';
  } else {
    returnCode = 'MARK_AS_REJECTED';
  }
  return http.post(
    'http://ec2-3-122-178-28.eu-central-1.compute.amazonaws.com:8080/users/' +
        userId.toString() +
        '/daily-tasks/' +
        taskId.toString(),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'action': returnCode,
    }),
  );
}
