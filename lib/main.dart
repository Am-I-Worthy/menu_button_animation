import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Button Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuButton(),
    );
  }
}

class MenuButton extends StatefulWidget {
  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation1;
  late Animation<double> animation2;
  int currentState = 0;
  bool animate = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    animation1 = Tween<double>(begin: 0, end: 0.75)
      .animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    animation2 =
        Tween<double>(begin: 0, end: -0.75).animate(animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: GestureDetector(
        onTap: () {
          animate
              ? animationController.reverse()
              : animationController.forward();
          setState(() {
            animate ? animate = false : animate = true;
            print(animate);
          });
        },

        child: Container(
          margin: EdgeInsets.all(15.0),
          width: 90,
          height: 50,
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                left: 15,
                top: 0,
                child: Transform.rotate(
                  alignment: Alignment.centerLeft,
                  angle: animation1.value.toDouble(),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: !animate ? 58 : 65,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 22.0,
                left: -(animation1.value * 100 - 15),
                child: AnimatedOpacity(
                  opacity: animate ? 0 : 1,
                  duration: Duration(milliseconds: 600),
                  child: Container(
                    width: 58,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              
              Positioned(
                left: 15,
                bottom: 0,
                child: Transform.rotate(
                  alignment: Alignment.centerLeft,
                  angle: animation2.value.toDouble(),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: !animate ? 58 : 65,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
