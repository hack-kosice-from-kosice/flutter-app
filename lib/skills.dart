import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sleep_it_app/widgets/learning/learning_route.dart';

import 'data/Skill.dart';

class SkillPage extends StatefulWidget {
  SkillPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SkillPageState createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  Future<List<Skill>> getSkills() {
    return http
        .get(
            'http://ec2-3-122-178-28.eu-central-1.compute.amazonaws.com:8080/skills')
        .then((response) {
      return ((json.decode(response.body) as Map)['skills'] as List)
          .map((e) => Skill.fromJson(e))
          .toList();
    });
  }

  FutureBuilder generateItemsList() {
    Future<List<Skill>> skills = getSkills();

    int index = 0; // ignore: unused_local_variable
    return FutureBuilder<List<Skill>>(
      future: skills,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.length,
                padding: const EdgeInsets.all(6),
                itemBuilder: (context, index) {
                  return Container(
                    key: Key(snapshot.data[index].name),
                    padding: const EdgeInsets.all(5),
                    child: new InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LearningRoute(skillId: index + 1),
                          ),
                        );
                      },
                      child: new Container(
                        decoration: index % 2 == 0
                            ? new BoxDecoration(color: Colors.lightBlueAccent.shade50)
                            : new BoxDecoration(color: Colors.lightBlue.shade50),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.all(10.0),
                              child: new CachedNetworkImage(
                                imageUrl: snapshot.data[index].imageURL,
                                width: 70.0,
                                height: 70.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: new Text(
                                    snapshot.data[index].name,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        color: Colors.black),
                                  ),
                                ),
                                new Container(
                                  padding: const EdgeInsets.only(bottom: 10.0),
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

      body: generateItemsList(),
    );
  }
}
