/*
 * @Author: Allan 
 * @Date: 2020-11-13 17:58:54 
 * @explain: 日历
 * @Last Modified time: 2020-11-13 17:58:54 
 */

import 'package:flutter/material.dart';
import 'times.dart';
import 'header.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    @required this.min,
    @required this.max,
    this.value,
    this.itemBuilder,
    this.onChange,
  });

  // 当前时间
  final DateTime value;
  // 最小时间
  final DateTime min;
  // 最大时间
  final DateTime max;
  // 自定义构建方法
  final Widget Function(BuildContext context, DateTime date) itemBuilder;
  // 时间改变
  final void Function(DateTime) onChange;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  // 时间高度
  final double itemHeight = 40;
  // 时间上下间距
  final double verticalSpacing = 8;
  // pageView控制器
  PageController pageController;
  // 当前选中的时间
  DateTime value;
  // 日历页数
  List<DateTime> months;
  // 当前页面下标
  int pageViewIndex;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Calendar oldWidget) {
    if (oldWidget.value != widget.value) {
      setState(() {
        final DateTime date = DateTime(
          widget.value.year,
          widget.value.month,
          widget.value.day,
        );
        value = date;
        pageViewIndex = getMonthIndex(date);
        pageController.jumpToPage(pageViewIndex);
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  // 初始化
  void init() {
    final DateTime currentDate = DateTime.now();
    // 当前时间整点
    final DateTime date = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );
    // 默认值
    value = widget.value ?? date;
    // 获取相差月数
    months = getMonths(widget.min, widget.max);
    // 查找当前时间所在位置
    pageViewIndex = getMonthIndex(value);

    if (pageViewIndex == -1) {
      pageViewIndex = 0;
    }

    // 默认值设置
    pageController = PageController(
      initialPage: pageViewIndex,
    );
  }

  // 搜索时间所在的下标
  int getMonthIndex(DateTime date) {
    return months.indexWhere(
      (item) => item.year == date.year && item.month == date.month,
    );
  }

  // 切换时间
  void pageViewChange(int index) {
    setState(() {
      pageViewIndex = index;
    });
  }

  // 选择时间
  void chooseDate(DateTime date) {
    // 判断是否受控
    if (widget.value == null) {
      setState(() {
        value = date;
      });
    }

    if (widget.onChange is Function) {
      widget.onChange(date);
    }
  }

  // 获取两个时间之间的月分时间列表
  List<DateTime> getMonths(DateTime min, DateTime max) {
    // 最大时间
    final DateTime maximumTime = DateTime(max.year, max.month);
    // 相差月数时间
    final List<DateTime> list = [];
    // 当前
    DateTime time = DateTime(min.year, min.month);

    while (maximumTime.microsecondsSinceEpoch >= time.microsecondsSinceEpoch) {
      list.add(DateTime(time.year, time.month));
      // 年
      int year;
      // 月
      int month;

      if (time.month + 1 == 13) {
        year = time.year + 1;
        month = 1;
      } else {
        year = time.year;
        month = time.month + 1;
      }

      time = DateTime(year, month);
    }

    return list;
  }

  // 构建时间
  Widget itemBuilder(BuildContext context, DateTime date, bool isCurrentMonth) {
    // 字体颜色
    Color fontColor = Color(0xff323233);

    if (!isCurrentMonth) {
      fontColor = Color(0xffc0c4cc);
    }

    Widget child = Text(
      date.day.toString(),
      style: TextStyle(
        fontSize: 14,
      ),
    );

    // 选中
    if (value.isAtSameMomentAs(date)) {
      fontColor = Colors.white;
      child = Container(
        width: 35,
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xff409eff),
          borderRadius: BorderRadius.circular(35),
        ),
        child: child,
      );
    }

    return GestureDetector(
      onTap: () {
        chooseDate(date);
      },
      child: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Container(
          width: 35,
          height: 35,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: DefaultTextStyle(
            style: TextStyle(
              color: fontColor,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // 周期
          Header(months[pageViewIndex]),
          // 时间
          Container(
            height: itemHeight * 6 + (verticalSpacing * 2),
            child: PageView.builder(
              controller: pageController,
              onPageChanged: pageViewChange,
              itemCount: months.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: verticalSpacing,
                  ),
                  child: Times(
                    date: months[index],
                    itemHeight: itemHeight,
                    itemBuilder: widget.itemBuilder ?? itemBuilder,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
