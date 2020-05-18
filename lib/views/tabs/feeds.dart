import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:politics/models/feed.dart';
import 'package:politics/ui/homepage/home_page.dart';
import 'package:politics/utils/colors.dart';
import 'package:politics/views/detail_page.dart';

Color mainColor = Color(0xff774a63);
Color secondColor = Color(0xffd6a5c0);
Color backgroundColor = Color(0xfffcf1f2);

List<ImageProvider> images = [
  AssetImage('assets/image2.png'),
  AssetImage('assets/image1.png'),
  AssetImage('assets/image3.png'),
  AssetImage('assets/image1.png'),
  AssetImage('assets/image2.png'),
];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(FeedsPage());
}

class FeedsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageView(
        children: <Widget>[
          SocialScreen(),
          FeedScreen(),
        ],
      ),
    );
  }
}

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          CustomFeedHeader(),
          Storys(),
          Expanded(
            flex: 2,
            child: PostFeed(),
          ),
        ],
      ),
    );
  }
}

class PostFeed extends StatefulWidget {
  @override
  _PostFeedState createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  List<Question> _list = Question.generateQuestion();
  
  PageController pageController;

  double viewportFraction = 0.8;

  double pageOffset = 0;

  IconData icon;

  Color color;
  

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
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
          },
            child: Container(
              padding: EdgeInsets.only(
                right: 10,
                left: 20,
                top: 20,
                bottom: 20,
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        _list[index].url,
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        fit: BoxFit.none,
                        alignment:
                            Alignment((pageOffset - index).abs() * 0.5, 0),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.grey.withOpacity(0.0),
                                Colors.black,
                              ],
                            )),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _list[index].name,
                          textAlign: TextAlign.center,
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

class Storys extends StatelessWidget {
  List<Avatars> _category = Avatars.generateAvatars().toList();
  final String category;
  final VoidCallback onSelected;

  Storys([@required this.category, this.onSelected]);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _category.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {

          var category = _category[index];

          return index == 0
              ? Container()
              : Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
            onSelected();
          },
                                          child: Container(
                        height: 70,
                        width: 70,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 30.0,
                              offset: Offset(
                                0.0, // horizontal, move right 10
                                10.0, // vertical, move down 10
                              ),
                            )
                          ],
                        ),
                        child: Image.asset(
                          _category[index].iconPath,
                        ),
                      ),
                    ),
                    Text(_category[index].name)
                  ],
                );
        },
      ),
    );
  }
}

class CustomFeedHeader extends StatelessWidget {
  const CustomFeedHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 35, 50, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Nathan Darlow',
                style: TextStyle(color: mainColor, fontSize: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SocialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: backgroundColor,
      body: ListView(
        children: <Widget>[
          CustomSocialHeader(),
          SocialInfo(),
          SocialFeed(),
        ],
      ),
    );
  }
}

class SocialFeed extends StatelessWidget {
  const SocialFeed({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(75),
        ),
      ),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              child: Image(image: images[index], fit: BoxFit.cover),
            ),
          );
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index.isEven ? 2 : 1);
        },
      ),
    );
  }
}

class SocialInfo extends StatelessWidget {
  const SocialInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(height: 100, color: Colors.white),
        Container(
          padding: EdgeInsets.only(top: 25),
          height: 100,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(75),
              bottomRight: Radius.circular(75),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Photos',
                    style: TextStyle(color: secondColor, fontSize: 16),
                  ),
                  Text(
                    '567',
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Followers',
                    style: TextStyle(color: secondColor, fontSize: 16),
                  ),
                  Text(
                    '12.457',
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Follows',
                    style: TextStyle(color: secondColor, fontSize: 16),
                  ),
                  Text(
                    '123',
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomSocialHeader extends StatelessWidget {
  const CustomSocialHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(75))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Icons.arrow_back, color: mainColor),
              Icon(Icons.more_vert, color: mainColor),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              'My Profile',
              style: TextStyle(fontSize: 30, color: mainColor),
            ),
          ),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/avatar1.png'),
              ),
              boxShadow: [
                BoxShadow(
                  color: secondColor,
                  blurRadius: 40,
                  offset: Offset(0, 10),
                ),
              ],
            ),
          ),
          Container(),
          Text(
            'Anastasia Mari',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.w700, color: mainColor),
          ),
          Text(
            '@ui.sia',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: secondColor),
          ),
        ],
      ),
    );
  }
}
