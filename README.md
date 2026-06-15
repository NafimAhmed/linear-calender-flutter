

# Linear Calender

A simple, lightweight, and highly customizable linear calendar/date picker package for Flutter.

`linear_calender` helps you display dates in a clean horizontal calendar view. Users can select a date, customize colors, styles, sizes, date formats, and even build their own custom date tile using `itemBuilder`.

![Linear Date Picker Demo](https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExMHI4b3F0bHkzYjN1eHdlN2J0dHA3dWJ2cGF3ZTg2cDVjYnRmMzRiMiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/laIrHICm4GUknbXndG/giphy.gif)

## Features

- Linear horizontal date picker
- Simple default design
- Fully customizable UI
- Custom selected, unselected, today, and disabled styles
- Custom date format support using `intl`
- Initial selected date support
- Date duration support
- Disable specific dates
- Custom date tile support using `itemBuilder`
- Smooth date selection callback
- Easy to integrate with any Flutter project

## Getting Started

Add the dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  linear_calender: ^0.0.8
```

Then run:

```bash
flutter pub get
```

## Import

```dart
import 'package:linear_calender/linear_calender.dart';
```

## Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:linear_calender/linear_calender.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linear Calender Demo',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linear Calender'),
      ),
      body: Column(
        children: [
          LinearCalendar(
            startDate: DateTime.now(),
            dateDuration: 30,
            onChanged: (DateTime value) {
              debugPrint('Selected date: $value');
            },
          ),
        ],
      ),
    );
  }
}
```

## Customized Usage

```dart
LinearCalendar(
  startDate: DateTime.now(),
  dateDuration: 60,
  height: 120,
  showMonth: true,
  showYear: false,
  style: const LinearCalendarStyle(
    selectedColor: Colors.blue,
    unselectedColor: Colors.transparent,
    todayColor: Color(0x1A2196F3),
    selectedBorderColor: Colors.blue,
    unselectedBorderColor: Colors.grey,
    todayBorderColor: Colors.orange,
    selectedTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    unselectedTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    todayTextStyle: TextStyle(
      color: Colors.orange,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    itemWidth: 80,
    itemHeight: 90,
    itemRadius: 14,
    borderWidth: 2,
  ),
  onChanged: (DateTime value) {
    debugPrint('Selected date: $value');
  },
)
```

## Disable Specific Dates

You can disable any date using `enabledDatePredicate`.

Example: Disable Friday.

```dart
LinearCalendar(
  startDate: DateTime.now(),
  dateDuration: 60,
  enabledDatePredicate: (DateTime date) {
    return date.weekday != DateTime.friday;
  },
  onChanged: (DateTime value) {
    debugPrint('Selected date: $value');
  },
)
```

## Initial Selected Date

```dart
LinearCalendar(
  startDate: DateTime.now(),
  dateDuration: 30,
  initialSelectedDate: DateTime.now().add(const Duration(days: 3)),
  onChanged: (DateTime value) {
    debugPrint('Selected date: $value');
  },
)
```

## Custom Date Format

This package uses the `intl` package for date formatting.

```dart
LinearCalendar(
  startDate: DateTime.now(),
  dateDuration: 30,
  dayFormat: 'EEE',
  dateFormat: 'dd',
  monthFormat: 'MMM',
  yearFormat: 'yyyy',
  showDayName: true,
  showDate: true,
  showMonth: true,
  showYear: false,
  onChanged: (DateTime value) {
    debugPrint('Selected date: $value');
  },
)
```

## Fully Custom Date Tile

If you want complete control over the UI, use `itemBuilder`.

```dart
LinearCalendar(
  startDate: DateTime.now(),
  dateDuration: 30,
  height: 100,
  onChanged: (DateTime value) {
    debugPrint('Selected date: $value');
  },
  itemBuilder: (
    BuildContext context,
    DateTime date,
    bool isSelected,
    bool isToday,
    bool isDisabled,
  ) {
    return Container(
      width: 75,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: isSelected ? Colors.deepPurple : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isToday ? Colors.orange : Colors.black12,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date.day.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isToday ? 'Today' : '',
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.orange,
            ),
          ),
        ],
      ),
    );
  },
)
```

## Example with GetX

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_calender/linear_calender.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Linear Calender Demo',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({super.key});

  final Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linear Calender'),
      ),
      body: Column(
        children: [
          LinearCalendar(
            startDate: DateTime.now(),
            dateDuration: 60,
            height: 120,
            showMonth: true,
            style: const LinearCalendarStyle(
              selectedColor: Colors.blue,
              selectedBorderColor: Colors.blue,
              borderWidth: 5,
              itemWidth: 80,
              itemHeight: 95,
              itemRadius: 12,
            ),
            onChanged: (DateTime value) {
              selectedDate.value = value;
            },
          ),
          const SizedBox(height: 20),
          Obx(
            () => Text(
              selectedDate.value.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

## Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `startDate` | `DateTime` | Required | Calendar start date |
| `dateDuration` | `int` | `30` | Number of dates to show |
| `initialSelectedDate` | `DateTime?` | `DateTime.now()` | Initially selected date |
| `onChanged` | `ValueChanged<DateTime>` | Required | Callback when date is selected |
| `height` | `double` | `85` | Calendar height |
| `showDayName` | `bool` | `true` | Show day name |
| `showDate` | `bool` | `true` | Show date number |
| `showMonth` | `bool` | `true` | Show month name |
| `showYear` | `bool` | `false` | Show year |
| `dayFormat` | `String` | `E` | Day format |
| `dateFormat` | `String` | `d` | Date format |
| `monthFormat` | `String` | `MMM` | Month format |
| `yearFormat` | `String` | `yyyy` | Year format |
| `enabledDatePredicate` | `bool Function(DateTime)?` | `null` | Enable or disable specific dates |
| `style` | `LinearCalendarStyle` | Default style | Customize colors, text styles, size, radius, and border |
| `itemBuilder` | `Widget Function(...) ?` | `null` | Build completely custom date tile |

## Style Properties

`LinearCalendarStyle` allows you to customize the default calendar design.

```dart
const LinearCalendarStyle(
  selectedColor: Colors.blue,
  unselectedColor: Colors.transparent,
  todayColor: Color(0x1A2196F3),
  disabledColor: Color(0x11000000),
  backgroundColor: Colors.transparent,
  selectedBorderColor: Colors.blueAccent,
  unselectedBorderColor: Colors.transparent,
  todayBorderColor: Colors.blueAccent,
  disabledBorderColor: Colors.transparent,
  selectedTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  unselectedTextStyle: TextStyle(
    color: Colors.black,
    fontSize: 16,
  ),
  todayTextStyle: TextStyle(
    color: Colors.blue,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  disabledTextStyle: TextStyle(
    color: Colors.grey,
    fontSize: 16,
  ),
  itemWidth: 75,
  itemHeight: 75,
  itemRadius: 10,
  borderWidth: 1,
)
```

## Additional Information

This package is designed to be simple by default and flexible when needed.

If the user does not provide custom values, the package will use standard default values. If the user wants a custom look, they can customize the design using `LinearCalendarStyle`. For complete UI control, they can use `itemBuilder`.

## Platform Support

| Platform | Support |
|---|---|
| Android | Yes |
| iOS | Yes |
| Web | Yes |
| Windows | Yes |
| macOS | Yes |
| Linux | Yes |

## License

This package is available under the MIT License.