class ProductModel {
  final int id;
  final String title;
  final String mj;
  final String price;

  ProductModel(
      {required this.id,
      required this.title,
      required this.mj,
      required this.price});

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      "id": id,
      "title": title,
      "mj": mj,
      "price": price,
    };
  }
}
