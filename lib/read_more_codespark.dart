import 'package:flutter/material.dart';

/// Defines the types of animations supported by [SimpleReadMoreText].
enum AnimationType { size, crossFade }

/// A widget that displays a truncated version of a long text and provides
/// an expandable/collapsible toggle for reading more or less.
class SimpleReadMoreText extends StatefulWidget {
  /// The text to display.
  final String text;

  /// Style of the main text.
  final TextStyle? style;

  /// Number of lines to show before truncation.
  final int trimLines;

  /// The label for expanding the text.
  final String readMoreText;

  /// The label for collapsing the text.
  final String readLessText;

  /// Style of the "read more" label.
  final TextStyle? readMoreStyle;

  /// Style of the "read less" label.
  final TextStyle? readLessStyle;

  /// Text alignment.
  final TextAlign textAlign;

  /// How overflowed text is handled.
  final TextOverflow textOverflow;

  /// Optional locale for text rendering.
  final Locale? locale;

  /// Whether to show a toggle icon (arrow).
  final bool iconToggle;

  /// Color of the toggle icon.
  final Color? iconColor;

  /// Enables/disables animation when expanding/collapsing.
  final bool animated;

  /// Duration of the animation.
  final Duration animationDuration;

  /// Type of animation to use.
  final AnimationType animationType;

  /// Callback when the expand/collapse state changes.
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
  /// Tracks whether the text is expanded or collapsed.
  bool _expanded = false;

  /// Tracks whether the text has overflowed beyond trimLines.
  bool _hasOverflow = false;

  /// Checks if the text exceeds the specified trimLines.
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

    // Only update if the overflow state changed
    if (didOverflow != _hasOverflow) {
      setState(() => _hasOverflow = didOverflow);
    }
  }

  /// Toggles the expanded/collapsed state.
  void _toggle() {
    setState(() => _expanded = !_expanded);
    widget.onToggle?.call(_expanded);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        // ✅ Check for text overflow only when collapsed
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

        // Wrap the text with animation if enabled
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
