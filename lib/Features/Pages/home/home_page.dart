import 'package:flutter/material.dart';
import 'package:foodie_app/Commons/Theme/App_Colors.dart';
import 'package:foodie_app/Features/Pages/home/index.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeBloc = HomeBloc(UnHomeState());
  AppColors _appColors = AppColors();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Center(
            child: Text(
              'Foodie',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _appColors.orangeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          leading: Image.asset(
            "assets/images/menu.png",
            scale: 3.0,
          ),
          actions: [
            Image.asset(
              "assets/images/panda.jpg",
              scale: 2.0,
            )
          ],
        ),
        body:
            _currentIndex == 0 ? HomeScreen(homeBloc: _homeBloc) : Container(),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
