<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/read_more_codespark/main/assets/banner.png" alt="Banner"/>


# 📖 read\_more\_codespark

[![Pub Version](https://img.shields.io/pub/v/read_more_codespark)](https://pub.dev/packages/read_more_codespark)
[![GitHub](https://img.shields.io/badge/GitHub-Katayath--Sai--Kiran%2Fread__more__codespark-blue?logo=github)](https://github.com/Katayath-Sai-Kiran/read_more_codespark)

A lightweight and customizable Flutter widget for displaying expandable and collapsible text. Ideal for handling lengthy content in a clean and user-friendly manner.

---

## ✨ Features

* **Expandable Text:** Truncate text after a specified number of lines with an option to expand/collapse.
* **Customization:** Adjust text style, alignment, overflow behavior, and locale settings.
* **Animations:** Choose between size or cross-fade animations for transitions.
* **Icons:** Optional toggle icons with customizable colors.
* **Callbacks:** Receive updates on toggle state changes.

---

## 🚀 Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  read_more_codespark: ^0.0.5
```



Then, run:

```bash
flutter pub get
```



---

## 🧪 Usage

```dart
import 'package:flutter/material.dart';
import 'package:read_more_codespark/read_more_codespark.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Read More Example')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: ReadMoreCodeSpark(
            text:
                "This is a long text that will be truncated and shown with a 'show more' indicator. Tapping the indicator will reveal the full content. You can customize the text style, minimum lines displayed, and overflow behavior.",
            textStyle: TextStyle(fontSize: 16.0),
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}
```




## 📷 Screenshots
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/read_more_codespark/main/assets/300x650-01.png" alt="Read More" width="150"/>
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/read_more_codespark/main/assets/300x650-02.png" alt="Read Less" width="150"/>

---

## 🛠️ Parameters

| Parameter           | Description                                   | Default                       |                                                                                            
| ------------------- | --------------------------------------------- | ----------------------------- | ------------------------------------------------------------------------------------------ |
| `text`              | The text content to display.                  | —                             |                                                                                            
| `textStyle`         | Style for the main text.                      | `null`                        |                                                                                            
| `maxLines`          | Number of lines to display before truncation. | `2`                           |                                                                                            
| `readMoreText`      | Text for the "Read more" link.                | `'Read more'`                 |                                                                                            |
| `readLessText`      | Text for the "Read less" link.                | `'Read less'`                 |                                                                                            |
| `readMoreStyle`     | Style for the "Read more" text.               | `null`                        |                                                                                            
| `readLessStyle`     | Style for the "Read less" text.               | `null`                        |                                                                                            
| `textAlign`         | Alignment of the text.                        | `TextAlign.start`             |                                                                                            |
| `textOverflow`      | Overflow behavior of the text.                | `TextOverflow.ellipsis`       |                                                                                            |
| `locale`            | Locale for the text.                          | `null`                        |                                                                                           
| `iconToggle`        | Whether to show toggle icons.                 | `true`                        |                                                                                            
| `iconColor`         | Color of the toggle icons.                    | `null`                        |                                                                                            
| `animated`          | Whether to animate the expansion/collapse.    | `true`                        |                                                                                            
| `animationDuration` | Duration of the animation.                    | `Duration(milliseconds: 100)` |                                                                                            |
| `animationType`     | Type of animation (`size` or `crossFade`).    | `AnimationType.size`          |                                                                                            |
| `onToggle`          | Callback when the toggle state changes.       | `null`                        | 

---

## 🧩 Example

An example project is available in the `example/` directory. To run it:

```bash
git clone https://github.com/Katayath-Sai-Kiran/read_more_codespark.git
cd read_more_codespark/example
flutter run
```



## 📝 Changelog

All notable changes to this project will be documented in the [CHANGELOG.md](https://github.com/Katayath-Sai-Kiran/read_more_codespark/main/CHANGELOG.md) file.


## 🐛 Issues & Feedback

If you encounter any issues or have suggestions for improvements, please [create an issue](https://github.com/Katayath-Sai-Kiran/read_more_codespark/issues) on GitHub. Contributions are welcome!


## 👨‍💻 Maintainer

Developed with ❤️ by [Katayath Sai Kiran](https://github.com/Katayath-Sai-Kiran). Feel free to reach out or contribute to the project.





