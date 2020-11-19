/*
 * @Author: Allan 
 * @Date: 2020-11-18 14:46:06 
 * @explain: 日历时间列表
 * @Last Modified time: 2020-11-18 14:46:06 
 */

import 'package:flutter/widgets.dart';

class Times extends StatefulWidget {
  const Times({
    @required this.date,
    @required this.itemBuilder,
    this.itemHeight = 40,
  });

  // 当月时间
  final DateTime date;
  // 时间列表高度
  final double itemHeight;
  // 构建方法
  final Widget Function(BuildContext, DateTime, bool) itemBuilder;

  @override
  _TimesState createState() => _TimesState();
}

class _TimesState extends State<Times> {
  // 时间列表
  List<DateTime> times = [];

  @override
  void initState() {
    generateTimes();
    super.initState();
  }

  // 生成时间列表
  void generateTimes() {
    // 获取上个月时间列表
    final List<DateTime> lastMonthTimes = getLastMonthTimes(widget.date);
    // 当月时间
    final List<DateTime> currentTimes = getCurrentTimes(widget.date);
    // 获取下个月时间列表
    final List<DateTime> nextMonth = getNextMonthTimes(
      widget.date,
      42 - (lastMonthTimes.length + currentTimes.length),
    );

    setState(() {
      times = [
        ...lastMonthTimes,
        ...currentTimes,
        ...nextMonth,
      ];
    });
  }

  // 获取上个月需要显示的时间
  List<DateTime> getLastMonthTimes(DateTime date) {
    // 本月1号周几
    final int firstWeekday = DateTime(date.year, date.month, 1).weekday;

    // 1号如果是周日则不进行上个月的展示
    if (firstWeekday == 7) {
      return [];
    }

    // 递减获取上个月1号的时间
    // 年
    int year;
    // 月
    int month;

    if (date.month == 1) {
      year = date.year - 1;
      month = 12;
    } else {
      year = date.year;
      month = date.month - 1;
    }

    final int monthCount = getMonthDayCount(DateTime(year, month));
    final List<DateTime> times = [];

    while (times.length < firstWeekday) {
      times.add(DateTime(year, month, monthCount - times.length));
    }

    return times.reversed.toList();
  }

  // 获取当前月时间列表
  List<DateTime> getCurrentTimes(DateTime date) {
    // 天数
    final int count = getMonthDayCount(date);
    // 时间
    final List<DateTime> times = List<DateTime>.generate(
      count,
      (index) => DateTime(
        date.year,
        date.month,
        index + 1,
      ),
    );

    return times;
  }

  // 获取下个月需要显示的时间
  List<DateTime> getNextMonthTimes(DateTime date, int count) {
    // 年份
    int year;
    // 月分
    int month;

    if (date.month == 12) {
      year = date.year + 1;
      month = 1;
    } else {
      year = date.year;
      month = date.month + 1;
    }

    return List<DateTime>.generate(
      count,
      (index) => DateTime(year, month, index + 1),
    );
  }

  // 获取指定月分的天数
  int getMonthDayCount(DateTime date) {
    // 确保是第一天
    date = DateTime(date.year, date.month);
    // 下个月
    DateTime nextMonth;

    if (date.month == 12) {
      nextMonth = DateTime(date.year + 1, 1, 1);
    } else {
      nextMonth = DateTime(date.year, date.month + 1, 1);
    }

    return nextMonth.difference(date).inDays;
  }

  // 构建时间
  Widget buildItem(int index) {
    final DateTime time = times[index];

    return widget.itemBuilder(
      context,
      time,
      time.month == widget.date.month,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int row = 0; row < 6; row++)
          Container(
            height: widget.itemHeight,
            child: Row(
              children: [
                for (int col = 0; col < 7; col++)
                  Expanded(
                    flex: 1,
                    child: buildItem((row * 7) + col),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
