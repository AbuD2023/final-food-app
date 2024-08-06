class ProductModel {
  int? id;
  String? image;
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
    id = json['id'];
    image = json['image'];
    title = json['title'];
    price = double.parse(json['price'].toString());
    rate = double.parse(json['rate'].toString());
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Image'] = image;
    data['Title'] = title;
    data['Price'] = price;
    data['Rate'] = rate;
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
