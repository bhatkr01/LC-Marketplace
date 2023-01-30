class Product {
    Product({
        required this.id,
        required this.productName,
        required this.productPicture,
        required this.productDescription,
        required this.productCondition,
        required this.productAction,
        required this.productPrice,
        required this.productDate,
        required this.productAuthor,
    });

    int id;
    String productName;
    String productPicture;
    String productDescription;
    String productCondition;
    String productAction;
    int productPrice;
    DateTime productDate;
    int productAuthor;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productName: json["product_name"],
        productPicture: json["product_picture"],
        productDescription: json["product_description"],
        productCondition: json["product_condition"],
        productAction: json["product_action"],
        productPrice: json["product_price"],
        productDate: DateTime.parse(json["product_date"]),
        productAuthor: json["product_author"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "product_picture": productPicture,
        "product_description": productDescription,
        "product_condition": productCondition,
        "product_action": productAction,
        "product_price": productPrice,
        "product_date": "${productDate.year.toString().padLeft(4, '0')}-${productDate.month.toString().padLeft(2, '0')}-${productDate.day.toString().padLeft(2, '0')}",
        "product_author": productAuthor,
    };
}
