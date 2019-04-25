import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new CanvasTest(),
    );
  }
}

class CanvasTest extends StatefulWidget {
  @override
  _CanvasTestState createState() => _CanvasTestState();
}

class _CanvasTestState extends State<CanvasTest> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CustomPaint(
        painter: MyPainter(),
        child: Center(
          child: Text(
            'Once upon a time...',
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Paint _paint = Paint();

//    ..color = Colors.amber //画笔颜色
//    ..strokeCap = StrokeCap.round //画笔笔触类型
//    ..isAntiAlias = true //是否启动抗锯齿
//    ..strokeWidth = 15.0; //画笔的宽度

  @override
  void paint(Canvas canvas, Size size) {
    // 画个实心圆
    canvas.drawCircle(new Offset(100, 100), 50, _paint);
//    canvas.drawLine(Offset(20.0, 20.0), Offset(100.0, 100.0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
