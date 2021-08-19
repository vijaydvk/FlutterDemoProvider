import 'package:flutter/material.dart';
import 'package:flutter_demo_provider/manage.dart';
import 'package:flutter_demo_provider/homepage.dart';
import 'package:provider/provider.dart';
// This class is what Provider will work with.
// It will _provide_ an instance of the class to any widget
// in the tree that cares about it. 
class Person with ChangeNotifier {
  Person({this.name, this.age});

  final String name;
  int age;

  void increaseAge() {
    this.age++;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Person(name: "Yohan", age: 25),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Class'),
      ),
      body: Center(
        child: Text(
          '''
          Hi ${context.select((Person p) => p.name)}!
          You are ${Provider.of<Person>(context).age} years old''',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<Person>(context, listen: false).increaseAge(),
      ),
    );
  }
}
