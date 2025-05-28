import 'package:flutter/material.dart';
import 'package:read_more_codespark/read_more_codespark.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple ReadMoreText Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('ReadMoreText Example')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SimpleReadMoreText(
            text:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. '
                'Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet.',
            trimLines: 2,
            style: TextStyle(fontSize: 16),
            readMoreStyle: TextStyle(color: Colors.blue),
            readLessStyle: TextStyle(color: Colors.red),
            iconToggle: true,
            iconColor: Colors.grey,
            animationType: AnimationType.size,
          ),
        ),
      ),
    );
  }
}
