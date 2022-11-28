class ProductModel {
  final dynamic id;
  final String productTitle;
  final String measureUnit;
  final int price;
  final int initialAmount;
  final int addedAmount;
  final int totalInStock;
  final int afterShift;
  final int totalSold;
  final int totalMarket;

  ProductModel(
      {this.id,
      required this.productTitle,
      required this.measureUnit,
      required this.price,
      required this.initialAmount,
      required this.addedAmount,
      required this.totalInStock,
      required this.afterShift,
      required this.totalSold,
      required this.totalMarket});

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      "id": id,
      "productTitle": productTitle,
      "measureUnit": measureUnit,
      "price": price,
      "initialAmount": initialAmount,
      "addedAmount": addedAmount,
      "totalInStock": totalInStock,
      "afterShift": afterShift,
      "totalSold": totalSold,
      "totalMarket": totalMarket,
    };
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, productTitle: $productTitle, measureUnit: $measureUnit, price: $price, initialAmount: $initialAmount, addedAmount: $addedAmount, totalInStock: $totalInStock, afterShift: $afterShift, totalSold: $totalSold, totalMarket: $totalMarket}';
  }
}
