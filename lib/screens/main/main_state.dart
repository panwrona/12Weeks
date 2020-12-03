

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twelve_weeks/screens/create/ui/create_screen.dart';
import 'package:twelve_weeks/screens/home/ui/home.dart';

import 'main.dart';

class MainState extends State<Main> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text(
      'Index 1: Calendar',
      style: optionStyle,
    ),
    CreateScreen(),
    Text(
      'Index 3: Progress',
      style: optionStyle,
    ),
    Text(
      'Index 4: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: BottomNavigationBar(
                elevation: 0.0,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today),
                    label: 'Calendar',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add), label: 'Create'),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart),
                    label: 'Progress',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings'),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.blue[400],
                unselectedItemColor: Colors.white,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}