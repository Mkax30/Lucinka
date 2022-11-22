import 'package:flutter/cupertino.dart';

class DataObject {
  String item;
  String measurementUnit;
  int price;

  int initialAmount;
  int addedAmount;
  int totalInStock;
  int afterShift;
  int totalSold;
  int totalMarket;

  bool selected;

  DataObject({
    required this.item,
    required this.measurementUnit,
    required this.price,
    this.initialAmount = 0,
    this.addedAmount = 0,
    this.totalInStock = 0,
    this.afterShift = 0,
    this.totalSold = 0,
    this.totalMarket = 0,
    this.selected = false,
  });
}
