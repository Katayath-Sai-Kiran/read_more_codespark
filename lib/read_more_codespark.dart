import 'package:flutter/material.dart';

enum AnimationType { size, crossFade }

class SimpleReadMoreText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int trimLines;
  final String readMoreText;
  final String readLessText;
  final TextStyle? readMoreStyle;
  final TextStyle? readLessStyle;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final Locale? locale;
  final bool iconToggle;
  final Color? iconColor;
  final bool animated;
  final Duration animationDuration;
  final AnimationType animationType;
  final ValueChanged<bool>? onToggle;

  const SimpleReadMoreText({
    super.key,
    required this.text,
    this.style,
    this.trimLines = 2,
    this.readMoreText = 'Read more',
    this.readLessText = 'Read less',
    this.readMoreStyle,
    this.readLessStyle,
    this.textAlign = TextAlign.start,
    this.textOverflow = TextOverflow.ellipsis,
    this.locale,
    this.iconToggle = true,
    this.iconColor,
    this.animated = true,
    this.animationDuration = const Duration(milliseconds: 100),
    this.animationType = AnimationType.size,
    this.onToggle,
  });

  @override
  State<SimpleReadMoreText> createState() => _SimpleReadMoreTextState();
}

class _SimpleReadMoreTextState extends State<SimpleReadMoreText> {
  bool _expanded = false;
  bool _hasOverflow = false;

  void _checkOverflow(double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      maxLines: _expanded ? null : widget.trimLines,
      textDirection: Directionality.of(context),
      textAlign: widget.textAlign,
      locale: widget.locale,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
    )..layout(maxWidth: maxWidth);

    final didOverflow = textPainter.didExceedMaxLines;

    if (didOverflow != _hasOverflow) {
      setState(() => _hasOverflow = didOverflow);
    }
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    widget.onToggle?.call(_expanded);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        // ✅ Only check for overflow when collapsed
        if (!_expanded && mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _checkOverflow(constraints.maxWidth);
          });
        }

        final textWidget = Text(
          widget.text,
          style: widget.style,
          maxLines: _expanded ? null : widget.trimLines,
          overflow: _expanded ? null : widget.textOverflow,
          textAlign: widget.textAlign,
          locale: widget.locale,
        );

        Widget animatedText;
        if (widget.animated) {
          switch (widget.animationType) {
            case AnimationType.crossFade:
              animatedText = AnimatedCrossFade(
                firstChild: textWidget,
                secondChild: textWidget,
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: widget.animationDuration,
                firstCurve: Curves.easeInOut,
                secondCurve: Curves.easeInOut,
                sizeCurve: Curves.easeInOut,
              );
              break;
            case AnimationType.size:
              animatedText = AnimatedSize(
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
                alignment: Alignment.topLeft,
                child: textWidget,
              );
              break;
          }
        } else {
          animatedText = textWidget;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            animatedText,
            if (_hasOverflow) const SizedBox(height: 4),
            if (_hasOverflow)
              InkWell(
                onTap: _toggle,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _expanded ? widget.readLessText : widget.readMoreText,
                      style: _expanded
                          ? widget.readLessStyle
                          : widget.readMoreStyle,
                    ),
                    if (widget.iconToggle)
                      Icon(
                        _expanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: widget.iconColor ??
                            Theme.of(context).iconTheme.color,
                        size: 20,
                      ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
