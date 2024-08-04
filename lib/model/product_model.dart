class ProductModel {
  final String image;
  final String title;
  final double price;
  final double rate;

  ProductModel(
      {required this.image,
      required this.title,
      required this.price,
      required this.rate});
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
