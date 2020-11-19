/*
 * @Author: Allan 
 * @Date: 2020-11-18 14:16:49 
 * @explain: 日历头部
 * @Last Modified time: 2020-11-18 14:16:49 
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Header extends StatelessWidget {
  Header(this.date);

  // 当前时间
  final DateTime date;
  // 周
  final List<String> weeks = ['日', '一', '二', '三', '四', '五', '六'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 13,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(125, 126, 128, 0.16),
            offset: Offset(0, 8),
            blurRadius: 10,
            spreadRadius: -7,
          ),
        ],
      ),
      child: Column(
        children: [
          // 当前时间显示
          Container(
            margin: EdgeInsets.only(
              bottom: 7,
            ),
            child: Text(
              '${date.year}年${date.month}月',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff323233),
              ),
            ),
          ),
          // 周期
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff323233),
            ),
            child: Row(
              children: weeks
                  .map(
                    (item) => Expanded(
                      child: Center(
                        child: Text(item),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
