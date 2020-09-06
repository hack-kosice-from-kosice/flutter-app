import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'data/Skill.dart';
import 'data/data.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SkillPage extends StatefulWidget {
  SkillPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SkillPageState createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {

  final itemsList = skills.toList();

  Future<List<Skill>> getSkills() {
    /*return await http.get('http://ec2-3-122-178-28.eu-central-1.compute.amazonaws.com:8080/skills')
        .then((response) {
      return (json.decode(response.body) as List).map((i) => Skill.fromJson(i)).toList();
    });*/
    http.get('http://ec2-3-122-178-28.eu-central-1.compute.amazonaws.com:8080/skills')
      .then((response) {
        final skillsList = json.decode(response.body).cast<Map<String, dynamic>>()["skills"];
        return skillsList.map<Skill>((json) => Skill.fromJson(json)).toList();
      });
  }

  ListView generateItemsList() {

    //Future<List<Skill>> skills = getSkills();

    int index = 0;
    return ListView.builder(
      itemCount: itemsList.length,
      padding: const EdgeInsets.all(6),
      itemBuilder: (context, index) {
        return Container(
          key: Key(itemsList[index].name),
          padding: const EdgeInsets.all(5),
          child:   new InkWell(
            onTap: () {
              // TODO: Jump to skill
            },
            child: new Container(
            decoration: index % 2 == 0 ?
            new BoxDecoration(color: Colors.grey.shade300) :
            new BoxDecoration(color: Colors.grey.shade200),
              child: new Row(
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.all(10.0),
                    child: new CachedNetworkImage(
                      imageUrl: itemsList[index].imageURL,
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
                          itemsList[index].name,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.black
                          ),
                        ),
                      ),
                      new Container(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: new Text(
                          itemsList[index].description,
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 10.0,
                              color: Colors.black
                          ),
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: generateItemsList(),
    );
  }


}
