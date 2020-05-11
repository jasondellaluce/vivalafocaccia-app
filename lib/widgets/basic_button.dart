import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final bool hasShadow;
  final Widget child;
  final Function onTap;
  final Color color;
  final Color shadowColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final double animationScale;

  const BasicButton(
      {Key key,
      this.child,
      this.onTap,
      this.color,
      this.shadowColor,
      this.borderRadius,
      this.padding,
      this.hasShadow = true,
      this.animationScale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      scaleFactor: animationScale ?? -1.3,
      duration: Duration(milliseconds: 100),
      onPressed: onTap ?? () {},
      child: Container(
        decoration: !hasShadow
            ? BoxDecoration(
                borderRadius:
                    borderRadius ?? BorderRadius.all(Radius.circular(20)),
                color: color ?? Theme.of(context).accentColor,
              )
            : BoxDecoration(
                borderRadius:
                    borderRadius ?? BorderRadius.all(Radius.circular(20)),
                color: color ?? Theme.of(context).accentColor,
                boxShadow: [
                    BoxShadow(
                      color: (shadowColor ?? Theme.of(context).backgroundColor)
                          .withAlpha(50),
                      blurRadius:
                          10.0, // has the effect of softening the shadow
                      spreadRadius:
                          5.0, // has the effect of extending the shadow
                      offset: Offset(0.0, 5.0),
                    )
                  ]),
        padding: padding ?? EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: child,
      ),
    );
  }
}
