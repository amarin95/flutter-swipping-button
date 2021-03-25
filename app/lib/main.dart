import 'package:flutter/material.dart';
import 'package:flutter_swipping_button/flutter_swipping_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Swipping Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Swipping Button Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _swipeButtonBackgroundWidget;

  _onSwipeCallback() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("SWIPPED")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4.0)),
                  child: _swipeButtonBackgroundWidget,
                ),
                SwipableButton(
                  height: 80.0,
                  delay: Duration(seconds: 3),
                  returnToInitialPosition: true,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Swipe to Open",
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035),
                              ),
                              Container(
                                  child: Icon(Icons.navigate_next,
                                      color: Colors.white)),
                            ]),
                      ),
                    ),
                    height: 80.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                  onSwipeCallback: _onSwipeCallback,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
