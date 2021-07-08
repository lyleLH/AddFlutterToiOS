import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  //初始化
  BasicMessageChannel basicMessageChannel = BasicMessageChannel(
    "com.zsy/hybrid.messagechannelname",
    JSONMessageCodec(),
  );

  @override
  void initState() {
    super.initState();
    //设定回调
    basicMessageChannel.setMessageHandler((message) async {
      try {
        print("\nflutter side recieved :\n${message.toString()}");
      } catch (error) {
        print(error.toString());
      }
      return "Good";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    //call native 处理响应 如果有的话
    try {
      var response =
          await basicMessageChannel.send({"flutter1": "1", "flutter2": "2"});
      print("flutter call native callbacked\n :${response.toString()}");
    } catch (error) {
      print(error.toString());
    }
  }
}
