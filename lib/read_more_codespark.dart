library read_more_codespark;

import 'package:flutter/material.dart';

class ReadMoreCodeSpark extends StatelessWidget {
  const ReadMoreCodeSpark({
    super.key,
    this.textStyle,
    required this.text,
    this.minLines,
    this.locale,
    this.textOverflow,
  });

  final TextStyle? textStyle;
  final String text;
  final int? minLines;
  final Locale? locale;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    bool showMore = false;
    return StatefulBuilder(builder: (context, readMoreState) {
      return AnimatedSize(
        duration: const Duration(milliseconds: 500),
        child: GestureDetector(
          onTap: () {
            readMoreState(() {
              showMore = !showMore;
            });
          },
          child: Row(
            crossAxisAlignment:
                showMore ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: textStyle,
                  key: key,
                  locale: locale,
                  maxLines: showMore ? 50 : minLines ?? 2,
                  overflow: textOverflow,
                ),
              ),
              Icon(showMore
                  ? Icons.keyboard_arrow_up_outlined
                  : Icons.keyboard_arrow_down_outlined)
            ],
          ),
        ),
      );
    });
  }
}
