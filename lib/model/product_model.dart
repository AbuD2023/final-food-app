class ProductModel {
  int? id;
  var image;
  String? title;
  double? price;
  double? rate;

  ProductModel({
    this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.rate,
  });
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']) ?? 0;
    image = json['image'];
    title = json['title'] as String;
    price = double.tryParse(json['price'].toString()) ?? 0.0;
    rate = double.tryParse(json['rate'].toString()) ?? 0.0;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['price'] = price;
    data['rate'] = rate;
    return data;
  }
}

List<ProductModel> productData = [
  ProductModel(
    image: 'assets/images/spaghetti.png',
    title: 'Spicy Salmon',
    price: 199,
    rate: 4.4,
  ),
  ProductModel(
    image: 'assets/images/pro2.png',
    title: 'Rice Bowl',
    price: 198,
    rate: 4.4,
  ),
  ProductModel(
    image: 'assets/images/pro3.png',
    title: 'Spicy Salmon',
    price: 199,
    rate: 4.4,
  ),
  ProductModel(
    image: 'assets/images/pro4.png',
    title: 'Rice Bowl',
    price: 198,
    rate: 4.4,
  ),
  ProductModel(
    image: 'assets/images/pro5.png',
    title: 'Rice Bowl',
    price: 198,
    rate: 4.4,
  ),
];
