import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sleep_it_app/data/LearnCard.dart';
import 'package:swipeable_card/swipeable_card.dart';

import 'learning_card.dart';

class LearningRoute extends StatefulWidget {
  final int skillId;
  const LearningRoute({Key key, @required this.skillId}) : super(key: key);

  @override
  _LearningRouteState createState() => _LearningRouteState();
}

class _LearningRouteState extends State<LearningRoute> {
  Future<List<LearnCard>> getLearnCardsForSkill(int skillId) {
    return http
        .get(
            'http://ec2-3-122-178-28.eu-central-1.compute.amazonaws.com:8080/skills/$skillId')
        .then((response) {
      return ((json.decode(response.body) as Map)['descriptions'] as List)
          .map((e) => LearnCard.fromJson(e))
          .toList();
    });
  }

  int currentCardIndex = 0;

  @override
  FutureBuilder build(BuildContext context) {
    Future<List<LearnCard>> cards = getLearnCardsForSkill(this.widget.skillId);
    SwipeableWidgetController _cardController = SwipeableWidgetController();

    return FutureBuilder<List<LearnCard>>(
      future: cards,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Scaffold(
                body: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      if (currentCardIndex < snapshot.data.length)
                        SwipeableWidget(
                          cardController: _cardController,
                          animationDuration: 500,
                          horizontalThreshold: 0.85,
                          child: LearningCard(
                              color: snapshot.data
                                  .elementAt(currentCardIndex)
                                  .color,
                              text: snapshot.data
                                  .elementAt(currentCardIndex)
                                  .description),
                          nextCards: <Widget>[
                            // show next card
                            // if there are no next cards, show nothing
                            if (!(currentCardIndex + 1 >= snapshot.data.length))
                              Align(
                                alignment: Alignment.center,
                                child: LearningCard(
                                    color: snapshot.data
                                        .elementAt(currentCardIndex)
                                        .color,
                                    text: snapshot.data
                                        .elementAt(currentCardIndex + 1)
                                        .description),
                              ),
                          ],
                          onLeftSwipe: () => swipe(snapshot.data.length),
                          onRightSwipe: () => swipe(snapshot.data.length),
                        )
                      else
                        // if the deck is complete, add a button to reset deck
                        Center(
                          child: FlatButton(
                            child: Text("Reset Cards"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  void swipe(int length) {
    if (currentCardIndex < length - 1) {
      setState(() {
        currentCardIndex++;
      });
    } else {
      setState(() {
        Navigator.pop(context);
      });
    }
  }
}
