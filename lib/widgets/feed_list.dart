import 'package:flutter/material.dart';
import 'package:politics/models/feed.dart';
import 'dart:math';
import 'package:politics/models/user.dart';
import 'package:politics/utils/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FeedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Expanded(
            flex: 2,
            child: PageViewWidget(),
          ),
        ],
      ),
    );
  }
}

class PageViewWidget extends StatefulWidget {
  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  List<Challenge> _list = Challenge.generateChallenge();

  PageController pageController;

  double viewportFraction = 0.8;

  double pageOffset = 0;
  User currentUser, user, followingUser;
  IconData icon;
  Color color;
  List<User> usersList = List<User>();
  List<String> followingUIDs = List<String>();

  @override
  void initState() {
    super.initState();
    pageController =
        PageController(initialPage: 0, viewportFraction: viewportFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController.page;
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      PageView.builder(
        controller: pageController,
        itemBuilder: (context, index) {
          double scale = max(viewportFraction,
              (1 - (pageOffset - index).abs()) + viewportFraction);

          double angle = (pageOffset - index).abs();

          if (angle > 0.5) {
            angle = 1 - angle;
          }
          var bean = _list[index];

          return GestureDetector(
            onTap: () {
            },
            child: Container(
              padding: EdgeInsets.only(
                right: 10,
                left: 20,
                top: 100 - scale * 25,
                bottom: 50,
              ),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(
                    3,
                    2,
                    0.001,
                  )
                  ..rotateY(angle),
                alignment: Alignment.center,
                child: Stack(
              children: <Widget>[
                Image.asset(
                  _list[index].url,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.none,
                  alignment: Alignment((pageOffset - index).abs() * 0.5, 0),
                ),
                Positioned(
                  bottom: 60,
                  left: 20,
                  child: AnimatedOpacity(
                    opacity: angle == 0 ? 1 : 0,
                    duration: Duration(
                      milliseconds: 200,
                    ),
                    child: Text(
                      _list[index].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                )
              ],
            ),
              ),
            ),
          );
        },
        itemCount: _list.length,
      ),
    ]);
  }
}