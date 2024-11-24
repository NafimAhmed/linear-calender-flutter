import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:linear_calender/linear_calender.dart';

// import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Rx<DateTime> dateTime = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("linear Calender"),
      ),
      body: Column(
        children: [



          LinearCalendar(



            roundedDateStyle: true,
            dateDuration: 60,
             selectedBorderColor: Colors.grey,
            // unselectedBorderColor: Colors.grey,
            height: 120,
            monthVisibility: false,
            selectedColor: Colors.grey,
            borderwidth: 5,
            onChanged: (DateTime value) {
              debugPrint(
                  "*****************${value}***************************");

              dateTime.value = value;
            }, startDate: DateTime.now(),

          ),
          Center(
              child: Obx(() => Text(
                    '${dateTime.value}',
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                  )))
        ],
      ),
    );
  }
}
