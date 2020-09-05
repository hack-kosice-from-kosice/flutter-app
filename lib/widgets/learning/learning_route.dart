import 'package:flutter/material.dart';
import 'package:swipeable_card/swipeable_card.dart';

import 'learning_card.dart';

class LearningRoute extends StatefulWidget {
  const LearningRoute({Key key}) : super(key: key);

  @override
  _LearningRouteState createState() => _LearningRouteState();
}

class _LearningRouteState extends State<LearningRoute> {
  final List<LearningCard> cards = [
    LearningCard(color: Colors.blue, text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
    LearningCard(color: Colors.blue, text: "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    LearningCard(color: Colors.blue, text: "This is the last card."),
  ];
  int currentCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    SwipeableWidgetController _cardController = SwipeableWidgetController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            if (currentCardIndex < cards.length)
              SwipeableWidget(
                cardController: _cardController,
                animationDuration: 500,
                horizontalThreshold: 0.85,
                child: cards[currentCardIndex],
                nextCards: <Widget>[
                  // show next card
                  // if there are no next cards, show nothing
                  if (!(currentCardIndex + 1 >= cards.length))
                    Align(
                      alignment: Alignment.center,
                      child: cards[currentCardIndex + 1],
                    ),
                ],
                onLeftSwipe: () => swipeLeft(),
                onRightSwipe: () => swipeRight(),
              )
            else
              // if the deck is complete, add a button to reset deck
              Center(
                child: FlatButton(
                  child: Text("Reset Cards"),
                  onPressed: () => setState(() => currentCardIndex = 0),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void swipeLeft() {
    print("left");
    setState(() {
      currentCardIndex++;
    });
  }

  void swipeRight() {
    print("right");
    setState(() {
      currentCardIndex++;
    });
  }

 /* Widget cardControllerRow(SwipeableWidgetController cardController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        FlatButton(
          child: Text("Left"),
          onPressed: () => cardController.triggerSwipeLeft(),
        ),
        FlatButton(
          child: Text("Right"),
          onPressed: () => cardController.triggerSwipeRight(),
        ),
      ],
    );
  } */
}
