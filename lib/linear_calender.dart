library linear_calender;

/// A Calculator.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LinearCalendar extends StatefulWidget {
  final DateTime startDate;
  final Color? selectedColor;
  final Color? unselectedColor;
  final int dateDuration;


  final TextStyle? unselectedTextStyle;
  final TextStyle? selectedTextStyle;
  final Color? backgroundColor;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final double? itemWidth;

  final double? dayTileWidth;
  final double? dayTileHeight;

  final double? itemRadius;
  final double? borderwidth;
  final bool? monthVisibility;

  final double? height;

  final ValueChanged<DateTime> onChanged;

  const LinearCalendar(
      {super.key,
      this.selectedColor,
      this.unselectedColor,
      required this.onChanged,
      this.height,
      this.backgroundColor,
      this.unselectedTextStyle,
      this.selectedTextStyle,
      this.itemWidth,
      this.monthVisibility,
      this.itemRadius,
      this.borderwidth,
      this.selectedBorderColor,
      this.unselectedBorderColor,
      required this.startDate,
      this.dayTileWidth,
      this.dayTileHeight, this.dateDuration=30});

  @override
  _LinearCalendarState createState() => _LinearCalendarState();
}

class _LinearCalendarState extends State<LinearCalendar> {
  DateTime selectedDate = DateTime.now();

  List<String> month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  List<DateTime> generateCalendarDates(DateTime startDate, int daysCount) {
    return List.generate(daysCount, (index) {
      return startDate.add(Duration(days: index));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Generate the next 30 days for the calendar
    List<DateTime> dates = generateCalendarDates(widget.startDate, widget.dateDuration);

    return Container(
      height: widget.height ?? 70,
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
              width: widget.itemWidth ?? 80,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: isSelected
                    ? widget.selectedColor ?? Colors.blue
                    : widget.unselectedColor ?? Colors.transparent,
                borderRadius: BorderRadius.circular(widget.itemWidth ?? 8),
                border: Border.all(
                    color: isSelected
                        ? widget.selectedBorderColor ?? Colors.blueAccent
                        : widget.unselectedBorderColor ?? Colors.transparent,
                    width: widget.borderwidth ?? 1),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(DateFormat('E').format(date), // Day name (e.g. Mon)
                        style: isSelected
                            ? widget.selectedTextStyle ??
                                const TextStyle(
                                    color: Colors.white, fontSize: 18)
                            : widget.unselectedTextStyle ??
                                const TextStyle(
                                    color: Colors.black, fontSize: 18)

                        // TextStyle(
                        //   color: isSelected ? widget.selectedTextColor : widget.unselectedTextColor,
                        // ),
                        ),
                    const SizedBox(height: 4),



                    Text(
                      date.day.toString(), // Day number (e.g. 12)
                      style: isSelected
                          ? widget.selectedTextStyle ??
                              const TextStyle(color: Colors.white, fontSize: 18)
                          : widget.unselectedTextStyle ??
                              const TextStyle(
                                  color: Colors.black, fontSize: 18),
                    ),

                    //const SizedBox(height: 4),
                    Visibility(
                      child: Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          '${month[date.month - 1]}', // Day number (e.g. 12)
                          style: isSelected
                              ? widget.selectedTextStyle ??
                                  const TextStyle(
                                      color: Colors.white, fontSize: 18)
                              : widget.unselectedTextStyle ??
                                  const TextStyle(
                                      color: Colors.black, fontSize: 18),
                        ),
                      ),
                      visible: widget.monthVisibility ?? true,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
