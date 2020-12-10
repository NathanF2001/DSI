import 'package:dsi/DsiPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _taps = 0;

  @override
  Widget build(BuildContext context) {
    final mediaInfo = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Add to App"),
      ),
      body: Center(
        child: Container(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Window is ${mediaInfo.size.width.toStringAsFixed(1)} x '
                '${mediaInfo.size.height.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                "Taps: ${_taps}",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Container(
                  width: 120,
                  child: _ButtonHomePage("Tap me!", () {
                    setState(() {
                      _taps++;
                    });
                  })),
              Container(
                  child: _ButtonHomePage(
                    "Ir página DSI",
                        () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return DSIPage(title: 'My First App-DSI/BSI/UFRPE');
                        }),
                      );
                    },
                  )),
              Container(
                child: _ButtonHomePage("Exit this screen",
                        () => SystemNavigator.pop()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _ButtonHomePage(
    text,
    function_pressed,
  ) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.grey)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      onPressed: function_pressed,
    );
  }
}
