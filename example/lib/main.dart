import 'package:flutter/material.dart';
import 'package:flutter_swipping_button/flutter_swipping_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Swipping Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Swipping Button Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget? _swipeButtonBackgroundWidget;

  void _onSwipeCallback() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("SWIPED")));
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
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                  delay: const Duration(seconds: 3),
                  returnToInitialPosition: true,
                  child: Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Swipe to Open",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                              ),
                            ),
                          ),
                          const Icon(Icons.navigate_next, color: Colors.white),
                        ],
                      ),
                    ),
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
