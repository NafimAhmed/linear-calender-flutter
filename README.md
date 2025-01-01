<!--
# A Flutter package for Linear Calender.
# Use intl class for date and time.
-->
# Linear Date Picker - Flutter Package

A simple and customizable linear date picker for Flutter, designed to offer a smooth and intuitive date selection experience. Perfect for apps that require a sleek, minimalistic, and horizontal date picker interface. With flexible styling options, you can easily integrate it into your app's design and enhance user interactions.


![Linear Date Picker Demo](https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExMHI4b3F0bHkzYjN1eHdlN2J0dHA3dWJ2cGF3ZTg2cDVjYnRmMzRiMiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/laIrHICm4GUknbXndG/giphy.gif)


## Features
1. Linear, horizontal date selection
2. Customizable appearance (colors, text style, etc.)
3. Supports multiple date formats
4. Easy to integrate and use
5. Realtime date change.

## Getting Started
At first Add dependency

To use `Linear_Calendar_Flutter`, add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  linear_calendar_flutter: ^0.0.6
  ```



## Usage

Then import

```dart
import 'package:linear_calendar_flutter/linear_calendar_flutter.dart';
```

Then use this code


```dart


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Linear Calendar Example")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearCalendar(
            selectedColor: Colors.green,
            unselectedColor: Colors.amber,
            onChanged: (DateTime value) {
              debugPrint(
                  "*****************${value}***************************");
            },
            height: 70,
            unselectedTextColor: Colors.black,
            selectedTextColor: Colors.white,
            backgroundColor: Colors.transparent,
          )
        ),
      ),
    );
  }
}

```

## Additional information

### Customization
The `Linear Date Picker` package is designed to be highly customizable. You can easily adjust the colors, text styles, and formatting options to match your app’s design theme. Additionally, the picker can be tailored for different locales, ensuring your app delivers a consistent experience for users in various regions.

### Compatibility
This package is compatible with Flutter apps targeting both Android and iOS platforms. It has been tested on multiple devices and screen sizes to ensure a smooth user experience. The package is also optimized for performance, making it suitable for apps with large date ranges.

### Installation
To use the `Linear Date Picker`, add the following to your `pubspec.yaml`:

```yaml
dependencies:
  linear_date_picker: ^0.0.6
```
