library linear_calender;

/// A Calculator.





import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




class LinearCalendar extends StatefulWidget {

  final Color selectedColor;
  final Color unselectedColor;
  final Color unselectedTextColor;
  final Color selectedTextColor;
  final Color backgroundColor;

  final double height;

  final ValueChanged<DateTime> onChanged;

  const LinearCalendar({super.key, required this.selectedColor, required this.unselectedColor, required this.onChanged, required this.height, required this.unselectedTextColor, required this.selectedTextColor, required this.backgroundColor});

  @override
  _LinearCalendarState createState() => _LinearCalendarState();
}

class _LinearCalendarState extends State<LinearCalendar> {
  DateTime selectedDate = DateTime.now();

  List<DateTime> generateCalendarDates(DateTime startDate, int daysCount) {
    return List.generate(daysCount, (index) {
      return startDate.add(Duration(days: index));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Generate the next 30 days for the calendar
    List<DateTime> dates = generateCalendarDates(DateTime.now(), 30);

    return Container(
      height: widget.height,
      color: widget.backgroundColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          DateTime date = dates[index];
          bool isSelected = date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
                widget.onChanged(selectedDate);
              });
            },
            child: Container(
              // height: 50,
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: isSelected ? widget.selectedColor : widget.unselectedColor,
                // borderRadius: BorderRadius.circular(8),
                // border: Border.all(
                //   color: isSelected ? Colors.blueAccent : Colors.transparent,
                // ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date), // Day name (e.g. Mon)
                    style: TextStyle(
                      color: isSelected ? widget.selectedTextColor : widget.unselectedTextColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    date.day.toString(), // Day number (e.g. 12)
                    style: TextStyle(
                      fontSize: 18,
                      color: isSelected ? widget.selectedTextColor : widget.unselectedTextColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}