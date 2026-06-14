library linear_calender;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef DatePredicate = bool Function(DateTime date);

typedef LinearCalendarItemBuilder = Widget Function(
    BuildContext context,
    DateTime date,
    bool isSelected,
    bool isToday,
    bool isDisabled,
    );

class LinearCalendarStyle {
  final Color selectedColor;
  final Color unselectedColor;
  final Color todayColor;
  final Color disabledColor;
  final Color backgroundColor;

  final Color selectedBorderColor;
  final Color unselectedBorderColor;
  final Color todayBorderColor;
  final Color disabledBorderColor;

  final TextStyle selectedTextStyle;
  final TextStyle unselectedTextStyle;
  final TextStyle todayTextStyle;
  final TextStyle disabledTextStyle;

  final double itemWidth;
  final double itemHeight;
  final double itemRadius;
  final double borderWidth;
  final EdgeInsets itemPadding;
  final EdgeInsets itemMargin;

  const LinearCalendarStyle({
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.transparent,
    this.todayColor = const Color(0x1A2196F3),
    this.disabledColor = const Color(0x11000000),
    this.backgroundColor = Colors.transparent,

    this.selectedBorderColor = Colors.blueAccent,
    this.unselectedBorderColor = Colors.transparent,
    this.todayBorderColor = Colors.blueAccent,
    this.disabledBorderColor = Colors.transparent,

    this.selectedTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    this.unselectedTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    this.todayTextStyle = const TextStyle(
      color: Colors.blue,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    this.disabledTextStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 16,
    ),

    this.itemWidth = 75,
    this.itemHeight = 75,
    this.itemRadius = 10,
    this.borderWidth = 1,
    this.itemPadding = const EdgeInsets.all(8),
    this.itemMargin = const EdgeInsets.symmetric(horizontal: 4),
  });

  LinearCalendarStyle copyWith({
    Color? selectedColor,
    Color? unselectedColor,
    Color? todayColor,
    Color? disabledColor,
    Color? backgroundColor,
    Color? selectedBorderColor,
    Color? unselectedBorderColor,
    Color? todayBorderColor,
    Color? disabledBorderColor,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
    TextStyle? todayTextStyle,
    TextStyle? disabledTextStyle,
    double? itemWidth,
    double? itemHeight,
    double? itemRadius,
    double? borderWidth,
    EdgeInsets? itemPadding,
    EdgeInsets? itemMargin,
  }) {
    return LinearCalendarStyle(
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      todayColor: todayColor ?? this.todayColor,
      disabledColor: disabledColor ?? this.disabledColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      unselectedBorderColor:
      unselectedBorderColor ?? this.unselectedBorderColor,
      todayBorderColor: todayBorderColor ?? this.todayBorderColor,
      disabledBorderColor:
      disabledBorderColor ?? this.disabledBorderColor,
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      unselectedTextStyle: unselectedTextStyle ?? this.unselectedTextStyle,
      todayTextStyle: todayTextStyle ?? this.todayTextStyle,
      disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
      itemWidth: itemWidth ?? this.itemWidth,
      itemHeight: itemHeight ?? this.itemHeight,
      itemRadius: itemRadius ?? this.itemRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      itemPadding: itemPadding ?? this.itemPadding,
      itemMargin: itemMargin ?? this.itemMargin,
    );
  }
}

class LinearCalendar extends StatefulWidget {
  final DateTime startDate;
  final int dateDuration;
  final DateTime? initialSelectedDate;

  final ValueChanged<DateTime> onChanged;

  final LinearCalendarStyle style;

  final double height;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final ScrollController? controller;

  final bool showDayName;
  final bool showDate;
  final bool showMonth;
  final bool showYear;

  final String dayFormat;
  final String dateFormat;
  final String monthFormat;
  final String yearFormat;
  final String? locale;

  final DateTime? minDate;
  final DateTime? maxDate;
  final DatePredicate? enabledDatePredicate;

  final bool autoScrollToSelectedDate;

  final LinearCalendarItemBuilder? itemBuilder;

  const LinearCalendar({
    super.key,
    required this.startDate,
    required this.onChanged,

    this.dateDuration = 30,
    this.initialSelectedDate,

    this.style = const LinearCalendarStyle(),

    this.height = 85,
    this.scrollDirection = Axis.horizontal,
    this.physics,
    this.controller,

    this.showDayName = true,
    this.showDate = true,
    this.showMonth = true,
    this.showYear = false,

    this.dayFormat = 'E',
    this.dateFormat = 'd',
    this.monthFormat = 'MMM',
    this.yearFormat = 'yyyy',
    this.locale,

    this.minDate,
    this.maxDate,
    this.enabledDatePredicate,

    this.autoScrollToSelectedDate = true,

    this.itemBuilder,
  });

  @override
  State<LinearCalendar> createState() => _LinearCalendarState();
}

class _LinearCalendarState extends State<LinearCalendar> {
  late DateTime? selectedDate;
  late final ScrollController _internalController;

  ScrollController get _scrollController =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();

    _internalController = ScrollController();

    selectedDate = widget.initialSelectedDate ?? DateTime.now();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  List<DateTime> _generateDates() {
    if (widget.dateDuration <= 0) return [];

    return List.generate(widget.dateDuration, (index) {
      final date = widget.startDate.add(Duration(days: index));
      return DateTime(date.year, date.month, date.day);
    });
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isToday(DateTime date) {
    return _isSameDate(date, DateTime.now());
  }

  bool _isSelected(DateTime date) {
    if (selectedDate == null) return false;
    return _isSameDate(date, selectedDate!);
  }

  bool _isDisabled(DateTime date) {
    final currentDate = DateTime(date.year, date.month, date.day);

    if (widget.minDate != null) {
      final min = DateTime(
        widget.minDate!.year,
        widget.minDate!.month,
        widget.minDate!.day,
      );

      if (currentDate.isBefore(min)) return true;
    }

    if (widget.maxDate != null) {
      final max = DateTime(
        widget.maxDate!.year,
        widget.maxDate!.month,
        widget.maxDate!.day,
      );

      if (currentDate.isAfter(max)) return true;
    }

    if (widget.enabledDatePredicate != null) {
      return !widget.enabledDatePredicate!(date);
    }

    return false;
  }

  void _onDateTap(DateTime date) {
    if (_isDisabled(date)) return;

    setState(() {
      selectedDate = date;
    });

    widget.onChanged(date);
    _scrollToSelectedDate();
  }

  void _scrollToSelectedDate() {
    if (!widget.autoScrollToSelectedDate || selectedDate == null) return;
    if (!_scrollController.hasClients) return;

    final dates = _generateDates();

    final index = dates.indexWhere(
          (date) => _isSameDate(date, selectedDate!),
    );

    if (index == -1) return;

    final itemWidth = widget.style.itemWidth + widget.style.itemMargin.horizontal;

    final offset = index * itemWidth;

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  TextStyle _getTextStyle({
    required bool isSelected,
    required bool isToday,
    required bool isDisabled,
  }) {
    if (isDisabled) return widget.style.disabledTextStyle;
    if (isSelected) return widget.style.selectedTextStyle;
    if (isToday) return widget.style.todayTextStyle;
    return widget.style.unselectedTextStyle;
  }

  Color _getBackgroundColor({
    required bool isSelected,
    required bool isToday,
    required bool isDisabled,
  }) {
    if (isDisabled) return widget.style.disabledColor;
    if (isSelected) return widget.style.selectedColor;
    if (isToday) return widget.style.todayColor;
    return widget.style.unselectedColor;
  }

  Color _getBorderColor({
    required bool isSelected,
    required bool isToday,
    required bool isDisabled,
  }) {
    if (isDisabled) return widget.style.disabledBorderColor;
    if (isSelected) return widget.style.selectedBorderColor;
    if (isToday) return widget.style.todayBorderColor;
    return widget.style.unselectedBorderColor;
  }

  String _format(DateTime date, String pattern) {
    return DateFormat(pattern, widget.locale).format(date);
  }

  Widget _defaultItemBuilder(
      BuildContext context,
      DateTime date,
      bool isSelected,
      bool isToday,
      bool isDisabled,
      ) {
    final textStyle = _getTextStyle(
      isSelected: isSelected,
      isToday: isToday,
      isDisabled: isDisabled,
    );

    return Container(
      width: widget.style.itemWidth,
      height: widget.style.itemHeight,
      padding: widget.style.itemPadding,
      margin: widget.style.itemMargin,
      decoration: BoxDecoration(
        color: _getBackgroundColor(
          isSelected: isSelected,
          isToday: isToday,
          isDisabled: isDisabled,
        ),
        borderRadius: BorderRadius.circular(widget.style.itemRadius),
        border: Border.all(
          color: _getBorderColor(
            isSelected: isSelected,
            isToday: isToday,
            isDisabled: isDisabled,
          ),
          width: widget.style.borderWidth,
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.showDayName)
              Text(
                _format(date, widget.dayFormat),
                style: textStyle,
              ),

            if (widget.showDayName && widget.showDate)
              const SizedBox(height: 4),

            if (widget.showDate)
              Text(
                _format(date, widget.dateFormat),
                style: textStyle,
              ),

            if (widget.showMonth) const SizedBox(height: 4),

            if (widget.showMonth)
              Text(
                _format(date, widget.monthFormat),
                style: textStyle,
              ),

            if (widget.showYear) const SizedBox(height: 4),

            if (widget.showYear)
              Text(
                _format(date, widget.yearFormat),
                style: textStyle,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dates = _generateDates();

    return Container(
      height: widget.height,
      color: widget.style.backgroundColor,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: widget.scrollDirection,
        physics: widget.physics,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];

          final isSelected = _isSelected(date);
          final isToday = _isToday(date);
          final isDisabled = _isDisabled(date);

          return GestureDetector(
            onTap: isDisabled ? null : () => _onDateTap(date),
            child: Opacity(
              opacity: isDisabled ? 0.5 : 1,
              child: widget.itemBuilder?.call(
                context,
                date,
                isSelected,
                isToday,
                isDisabled,
              ) ??
                  _defaultItemBuilder(
                    context,
                    date,
                    isSelected,
                    isToday,
                    isDisabled,
                  ),
            ),
          );
        },
      ),
    );
  }
}