class ProductRepo {
  String? name;
  double? price;

  ProductRepo({this.name, this.price});

  factory ProductRepo.fromJson(Map<String, dynamic> json) => ProductRepo(
    name: json["name"],
    price: json["price"]
  );
}
