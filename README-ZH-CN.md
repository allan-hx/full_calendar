# FullCalendar

[English](./README.md) | 简体中文

Flutter日历时间选择插件

<img src="./preview/preview-01.gif" width=250 height=480/>

## 安装
pubspec.yaml文件中的dependencies下添加
```
full_calendar: ^0.01
```

终端执行获取依赖命令
```
flutter packages get
```

## 示例
```dart
FullCalendar(
  min: DateTime(2018),
  max: DateTime(2021),
  onChange: (value) {
    print(value);
  },
),
```

## Api
- ```value```
  - ```DateTime```
  - 当前选择的时间
- ```min```
  - ```DateTime```
  - 最小时间
- ```max```
  - ```DateTime```
  - 最大时间
- ```onChange```
  - ```void Function(DateTime)```
  - 选择时间后的回调

## 代办列表
- [x] 单个时间选择
- [] 多个时间选择
- [] 时间段选择
- [] 自定义主题
