import 'package:flutter/material.dart';

enum LinearStrokeCap { butt, round, roundAll }

// ignore: must_be_immutable
class ArrowIndicator extends StatefulWidget {
  ///Percent value between 0.0 and 1.0
  final double percent;
  final double? width;

  ///Height of the line
  final double lineHeight;

  ///Color of the background of the Line , default = transparent
  final Color fillColor;

  ///First color applied to the complete line
  Color get backgroundColor => _backgroundColor;
  late Color _backgroundColor;

  Color get progressColor => _progressColor;

  late Color _progressColor;

  ///true if you want the Line to have animation
  final bool animation;

  ///duration of the animation in milliseconds, It only applies if animation attribute is true
  final int animationDuration;

  ///alignment of the Row (leading-widget-center-trailing)
  final MainAxisAlignment alignment;

  ///padding to the LinearPercentIndicator
  final EdgeInsets padding;

  /// set false if you don't want to preserve the state of the widget
  final bool addAutomaticKeepAlive;

  /// set a linear curve animation type
  final Curve curve;

  /// set true when you want to restart the animation, it restarts only when reaches 1.0 as a value
  /// defaults to false
  final bool restartAnimation;

  /// Callback called when the animation ends (only if `animation` is true)
  final VoidCallback? onAnimationEnd;

  /// Display a widget indicator at the end of the progress. It only works when `animation` is true
  final Widget? widgetIndicator;

  ArrowIndicator({
    Key? key,
    this.fillColor = Colors.transparent,
    this.percent = 0.0,
    this.width,
    Color? backgroundColor,
    Color? progressColor,
    this.animation = false,
    this.animationDuration = 500,
    this.addAutomaticKeepAlive = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0),
    this.alignment = MainAxisAlignment.start,
    this.curve = Curves.linear,
    this.restartAnimation = false,
    this.onAnimationEnd,
    this.widgetIndicator,
    this.lineHeight = 5.0,
  }) : super(key: key) {
    _progressColor = progressColor ?? Colors.red;
    _backgroundColor = backgroundColor ?? Color(0xFFB8C7CB);

    if (percent < 0.0 || percent > 1.0) {
      throw new Exception("Percent value must be a double between 0.0 and 1.0");
    }
  }

  @override
  _ArrowIndicatorState createState() => _ArrowIndicatorState();
}

class _ArrowIndicatorState extends State<ArrowIndicator>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _animationController;
  Animation? _animation;
  double _percent = 0.0;
  final _containerKey = GlobalKey();
  final _keyIndicator = GlobalKey();
  double _containerWidth = 0.0;
  double _containerHeight = 0.0;
  double _indicatorWidth = 0.0;
  double _indicatorHeight = 0.0;

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _containerWidth = _containerKey.currentContext?.size?.width ?? 0.0;
          _containerHeight = _containerKey.currentContext?.size?.height ?? 0.0;
          if (_keyIndicator.currentContext != null) {
            _indicatorWidth = _keyIndicator.currentContext?.size?.width ?? 0.0;
            _indicatorHeight =
                _keyIndicator.currentContext?.size?.height ?? 0.0;
          }
        });
      }
    });
    if (widget.animation) {
      _animationController = AnimationController(
          vsync: this,
          duration: Duration(milliseconds: widget.animationDuration));
      _animation = Tween(begin: 0.0, end: widget.percent).animate(
        CurvedAnimation(parent: _animationController!, curve: widget.curve),
      )..addListener(() {
          setState(() {
            _percent = _animation!.value;
          });
          if (widget.restartAnimation && _percent == 1.0) {
            _animationController!.repeat(min: 0, max: 1.0);
          }
        });
      _animationController!.addStatusListener((status) {
        if (widget.onAnimationEnd != null &&
            status == AnimationStatus.completed) {
          widget.onAnimationEnd!();
        }
      });
      _animationController!.forward();
    } else {
      _updateProgress();
    }
    super.initState();
  }

  void _checkIfNeedCancelAnimation(ArrowIndicator oldWidget) {
    if (oldWidget.animation &&
        !widget.animation &&
        _animationController != null) {
      _animationController!.stop();
    }
  }

  @override
  void didUpdateWidget(ArrowIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percent != widget.percent) {
      if (_animationController != null) {
        _animationController!.duration =
            Duration(milliseconds: widget.animationDuration);
        _animation = Tween(begin: 0.0, end: widget.percent).animate(
          CurvedAnimation(parent: _animationController!, curve: widget.curve),
        );
        _animationController!.forward(from: 0.0);
      } else {
        _updateProgress();
      }
    }
    _checkIfNeedCancelAnimation(oldWidget);
  }

  _updateProgress() {
    setState(() {
      _percent = widget.percent;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var items = List<Widget>.empty(growable: true);
    final hasSetWidth = widget.width != null;
    final percentPositionedHorizontal =
        _containerWidth * _percent - _indicatorWidth / 3;
    var containerWidget = Container(
      width: hasSetWidth ? widget.width : double.infinity,
      height: widget.lineHeight,
      padding: widget.padding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            key: _containerKey,
            painter: LinearPainter(
              progress: _percent,
              progressColor: widget.progressColor,
              backgroundColor: widget.backgroundColor,
              lineWidth: widget.lineHeight,
            ),
            child: Container(),
          ),
          if (widget.widgetIndicator != null && _indicatorWidth == 0)
            Opacity(
              opacity: 0.0,
              key: _keyIndicator,
              child: widget.widgetIndicator,
            ),
          if (widget.widgetIndicator != null &&
              _containerWidth > 0 &&
              _indicatorWidth > 0)
            Positioned(
              right: percentPositionedHorizontal,
              left: null,
              top: _containerHeight / 2 - _indicatorHeight,
              child: widget.widgetIndicator!,
            ),
        ],
      ),
    );

    if (hasSetWidth) {
      items.add(containerWidget);
    } else {
      items.add(Expanded(
        child: containerWidget,
      ));
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        color: widget.fillColor,
        child: Row(
          mainAxisAlignment: widget.alignment,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.addAutomaticKeepAlive;
}

/*progress: _percent,
progressColor: widget.progressColor,
backgroundColor: widget.backgroundColor,
lineWidth: widget.lineHeight,*/
class LinearPainter extends CustomPainter {
  final Paint _paintBackground = new Paint();
  final Paint _paintLine = new Paint();
  final double lineWidth;
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final LinearStrokeCap? linearStrokeCap;
  final LinearGradient? linearGradient;
  final LinearGradient? linearGradientBackgroundColor;
  final MaskFilter? maskFilter;

  LinearPainter({
    required this.lineWidth,
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    this.linearStrokeCap = LinearStrokeCap.butt,
    this.linearGradient,
    this.maskFilter,
    this.linearGradientBackgroundColor,
  }) {
    _paintBackground.color = backgroundColor;
    _paintBackground.style = PaintingStyle.stroke;
    _paintBackground.strokeWidth = lineWidth;

    _paintLine.color = progress.toString() == "0.0"
        ? progressColor.withOpacity(0.0)
        : progressColor;
    _paintLine.style = PaintingStyle.stroke;
    _paintLine.strokeWidth = lineWidth;

    if (linearStrokeCap == LinearStrokeCap.round) {
      _paintLine.strokeCap = StrokeCap.round;
    } else if (linearStrokeCap == LinearStrokeCap.butt) {
      _paintLine.strokeCap = StrokeCap.butt;
    } else {
      _paintLine.strokeCap = StrokeCap.round;
      _paintBackground.strokeCap = StrokeCap.round;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(0.0, size.height / 2);
    final end = Offset(size.width, size.height / 2);
    canvas.drawLine(start, end, _paintBackground);

    if (maskFilter != null) {
      _paintLine.maskFilter = maskFilter;
    }
    if (linearGradientBackgroundColor != null) {
      Offset shaderEndPoint = Offset(size.width, size.height);
      _paintBackground.shader = linearGradientBackgroundColor
          ?.createShader(Rect.fromPoints(Offset.zero, shaderEndPoint));
    }

    final xProgress = size.width * progress;
    if (linearGradient != null) {
      _paintLine.shader = _createGradientShaderLeftToRight(size, xProgress);
    }
    canvas.drawLine(start, Offset(xProgress, size.height / 2), _paintLine);
  }

  Shader _createGradientShaderLeftToRight(Size size, double xProgress) {
    Offset shaderEndPoint = Offset(xProgress, size.height);
    return linearGradient!.createShader(
      Rect.fromPoints(
        Offset.zero,
        shaderEndPoint,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
