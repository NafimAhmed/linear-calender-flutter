

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
      title: 'Linear Calendar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({super.key});

  final Rx<DateTime> dateTime = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Linear Calendar"),
      ),
      body: Column(
        children: [
          LinearCalendar(
            startDate: DateTime.now(),
            dateDuration: 60,
            height: 120,

            /// monthVisibility er bodole showMonth
            showMonth: true,

            /// selectedColor, selectedBorderColor, borderwidth
            /// ekhon style er moddhe dite hobe
            style: const LinearCalendarStyle(
              selectedColor: Colors.blue,
              selectedBorderColor: Colors.blue,
              borderWidth: 5,
              itemWidth: 80,
              itemHeight: 95,
              itemRadius: 12,
            ),

            onChanged: (DateTime value) {
              debugPrint("Selected date: $value");
              dateTime.value = value;
            },
          ),

          const SizedBox(height: 20),

          Center(
            child: Obx(
                  () => Text(
                '${dateTime.value}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}