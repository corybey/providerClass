import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: MyApp(),
    ),
  );
}

// Mood Model
class MoodModel with ChangeNotifier {
  String _currentMood = 'assets/regular.jpg'; // default mood image
  String get currentMood => _currentMood;

  Color _backgroundColor = Colors.orange; // default background
  Color get backgroundColor => _backgroundColor;

  // Mood counters
  Map<String, int> _moodCounts = {
    'Happy': 0,
    'Sad': 0,
    'Regular': 0,
  };
  Map<String, int> get moodCounts => _moodCounts;

  // Set Happy mood
  void setHappy() {
    _currentMood = 'assets/happy.jpg';
    _backgroundColor = Colors.yellow;
    _moodCounts['Happy'] = (_moodCounts['Happy'] ?? 0) + 1;
    notifyListeners();
  }

  // Set Sad mood
  void setSad() {
    _currentMood = 'assets/sad.jpg';
    _backgroundColor = Colors.red;
    _moodCounts['Sad'] = (_moodCounts['Sad'] ?? 0) + 1;
    notifyListeners();
  }

  // Set Regular mood
  void setRegular() {
    _currentMood = 'assets/neutral.jpg';
    _backgroundColor = Colors.orange;
    _moodCounts['Regular'] = (_moodCounts['Regular'] ?? 0) + 1;
    notifyListeners();
  }

  // Random Mood
  void setRandomMood() {
    int choice = Random().nextInt(3);
    switch (choice) {
      case 0:
        setHappy();
        break;
      case 1:
        setSad();
        break;
      case 2:
        setRegular();
        break;
    }
  }
}

// Main App Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Scaffold(
          backgroundColor: moodModel.backgroundColor,
          appBar: AppBar(title: Text('Mood Toggle Challenge')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('How are you feeling?', style: TextStyle(fontSize: 24)),
                SizedBox(height: 30),
                MoodDisplay(),
                SizedBox(height: 30),
                MoodButtons(),
                SizedBox(height: 30),
                MoodCounters(),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () => moodModel.setRandomMood(),
                  icon: Text('🤪', style: TextStyle(fontSize: 24)),
                  label: Text('Random Mood'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget that displays the current mood
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Image.asset(
          moodModel.currentMood,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

// Widget with buttons to change the mood
class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: moodModel.setHappy,
              child: Text('Happy😀'),
            ),
            ElevatedButton(
              onPressed: moodModel.setSad,
              child: Text('Sad🥺'),
            ),
            ElevatedButton(
              onPressed: moodModel.setRegular,
              child: Text('Regular👌'),
            ),
          ],
        );
      },
    );
  }
}

// Widget to display mood counters
class MoodCounters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('😀 Happy', style: TextStyle(fontSize: 18)),
                Text('${moodModel.moodCounts['Happy']}', style: TextStyle(fontSize: 18)),
              ],
            ),
            Column(
              children: [
                Text('🥺 Sad', style: TextStyle(fontSize: 18)),
                Text('${moodModel.moodCounts['Sad']}', style: TextStyle(fontSize: 18)),
              ],
            ),
            Column(
              children: [
                Text('👌 Regular', style: TextStyle(fontSize: 18)),
                Text('${moodModel.moodCounts['Regular']}', style: TextStyle(fontSize: 18)),
              ],
            ),
          ],
        );
      },
    );
  }
}
