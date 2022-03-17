import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, }) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  double boxHeight = 100;
  double boxWidth = 100;
  Color boxColor = Colors.deepPurple;
  double boxX = 0;
  double boxY = 500;
  // Curve boxTransform = Curves.linear;
  Matrix4 boxTransform = Matrix4.translationValues(0, 0, 0.0,);
  late AnimationController _controller;
  final Tween<double> _tween = Tween(begin: .5, end: 1);
  double bottomBox = 0;

  late Animation<Offset> animation = Tween(
    begin: Offset.zero,
    end: Offset(0, .28)
  ).animate(_controller);

  void _expandBox() {
    setState(() {
      boxHeight = 300;
      boxWidth = 300;
    });
  }

  void _moveBox() {
    setState(() {
      // boxX = 500;
      boxY = 0;
    });

    Future.delayed(
      const Duration(seconds: 4),
      (){
        setState(() {
          boxY = 500;
        });
      }
    );
  }

  void _changeBoxColor() {
    setState(() {
      boxColor = Colors.pink;
    });
  }

  void _changeBoxMargin() {
    setState(() {
      bottomBox = 200;
    });

    Future.delayed(
      const Duration(seconds: 4),
          (){
            setState(() {
              bottomBox = 0;
            });
      }
    );

  }

  void _changeBoxTransform() {
    Future.delayed(
      const Duration(seconds: 4),
      (){
        setState(() {
          boxTransform = Matrix4.translationValues(0, 0, 0.0,);
        });
        Future.delayed(const Duration(seconds: 1));
        setState(() {
          boxTransform = Matrix4.translationValues(1, 1, 0.0,);
        });

      }
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        _moveBox();
        // _changeBoxTransform();
      },
      child: Scaffold(
        backgroundColor: Colors.deepPurple[200],
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          padding: EdgeInsets.only(bottom: 40),
          children: <Widget>[
            const SizedBox(height: 40,),
            Center(
              child: ScaleTransition(
                scale: _tween.animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Curves.ease
                  )
                ),
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.pink[800],
                ),
              ),
            ),
            const SizedBox(height: 40,),
            Center(
              child: InkWell(
                onTap: _changeBoxMargin,
                child: AnimatedContainer(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(bottom: bottomBox),
                  curve: Curves.ease,
                  color: Colors.deepPurple,
                  duration: const Duration(seconds: 2),
                  // transform: Matrix4.translationValues(
                  //   boxX,
                  //   boxY,
                  //   0.0,
                  // ),
                ),
              ),
            ),
            const SizedBox(height: 40,),
            SlideTransition(
              position: animation,
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,

                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 40,),
            Center(
              child: InkWell(
                onTap: _expandBox,
                // child: Container(
                child: AnimatedContainer(
                  width: boxWidth,
                  height: boxHeight,
                  color: Colors.deepPurple,
                  duration: const Duration(seconds: 2),
                ),
              ),
            ),
            const SizedBox(height: 40,),
            Center(
              child: InkWell(
                onTap: _changeBoxColor,
                // child: Container(
                child: AnimatedContainer(
                  width: 100,
                  height: 100,
                  color: boxColor,
                  duration: const Duration(seconds: 2),
                ),
              ),
            ),
            const SizedBox(height: 40,),
            Center(
              child: InkWell(
                onTap: _moveBox,
                // child: Container(
                child: AnimatedContainer(
                  // alignment: const Alignment(-1, -1),
                  width: 100,
                  height: 100,
                  color: Colors.deepPurple,
                  duration: const Duration(seconds: 2),
                  curve: Curves.bounceOut,
                  transform: Matrix4.translationValues(
                    boxX,
                    boxY,
                    0.0,
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

}
