import 'package:flutter/material.dart';
import 'package:wm_library/common/global_variable.dart';

/// 可以无限滚动的背景图
class ScrollBg extends StatefulWidget {
  final Widget childWidget;
  final String type;

  ScrollBg(this.childWidget, this.type);

  @override
  _ScrollBgState createState() => _ScrollBgState();
}

/// 功能包装部分
class _ScrollBgState extends State<ScrollBg>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();

    double w = screen.setWidth(375);

    controller = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animation = new Tween(begin: 0.0, end: w).animate(controller);

    // 控制动画运动, 平时开发可以注释掉, 防止模拟器压力太大
//    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new AnimatedBg(animation: animation),
        new Container(
          width: screen.setWidth(375),
          height: double.infinity,
          decoration: new BoxDecoration(
            color: widget.type == 'opacity' ? const Color.fromRGBO(0, 0, 0, 0.93) : null,
              gradient: widget.type == 'gradient' ? new LinearGradient(colors: [
            Color.fromRGBO(0, 0, 0, 0.75),
            Color.fromRGBO(0, 0, 0, 1)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter) : null),
          child: widget.childWidget,
        )
      ],
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

/// 滚动图部分
class AnimatedBg extends AnimatedWidget {
  AnimatedBg({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Stack(
      children: <Widget>[
        new Container(
            transform: Matrix4.translationValues(-animation.value, 0, 0),
            child: new BgImage()),
        new Container(
            transform: Matrix4.translationValues(
                -animation.value + screen.setWidth(375), 0, 0),
            child: new BgImage())
      ],
    );
  }
}

/// 图片展示部分
class BgImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Image.asset(
      'images/scroll_bg.png',
//      width: screen.setWidth(882),
      height: screen.setWidth(434),
      fit: BoxFit.fitHeight,
      alignment: Alignment.topLeft,
    );
  }
}
