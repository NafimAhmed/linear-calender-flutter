



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linear_calender/linear_calender.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("linear Calender"),
      ),
      body: Column(
        children: [

          LinearCalendar(selectedColor: Colors.green, unselectedColor: Colors.amber, onChanged: (DateTime value) {
            debugPrint("*****************${value}***************************");
          }, height: 70, unselectedTextColor: Colors.black, selectedTextColor: Colors.white, backgroundColor: Colors.transparent,)

        ],
      ),
    );
  }

}