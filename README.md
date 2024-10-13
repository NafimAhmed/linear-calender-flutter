<!--
# A Flutter package for Linear Calender.
# Use intl class for date and time.
-->
# Linear Date Picker - Flutter Package

A simple and customizable linear date picker for Flutter, designed to offer a smooth and intuitive date selection experience. Perfect for apps that require a sleek, minimalistic, and horizontal date picker interface. With flexible styling options, you can easily integrate it into your app's design and enhance user interactions.


![Linear Date Picker Demo](https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExNTZ5dGxsMmluN2J5cXM1NGo3NGZha2hqbzRnMjBrcXh2MGZzcWRxbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ZKt2G4h20KcYe2QaMB/giphy.gif)


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
  linear_calendar_flutter: ^0.0.1
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


