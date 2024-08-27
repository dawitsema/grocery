import '../../domain/entity/grocery_entity.dart';

class FoodEntityModel extends FoodEntity {
  FoodEntityModel({
    required String id,
    required String title,
    required String imageUrl,
    required double rating,
    required double price,
    required double discount,
    required String description,
    required List<OptionModel> options,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          rating: rating,
          price: price,
          discount: discount,
          description: description,
          options: options,
        );

  factory FoodEntityModel.fromJson(Map<String, dynamic> json) {
    return FoodEntityModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      price: json['price'].toDouble(),
      discount: json['discount'].toDouble(),
      description: json['description'],
      options: json['options'] != null
          ? (json['options'] as List<dynamic>)
              .map((optionJson) => OptionModel.fromJson(optionJson))
              .toList()
          : [], // Provide a default empty list if options are null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'rating': rating,
      'price': price,
      'discount': discount,
      'description': description,
      'options':
          options.map((option) => (option as OptionModel).toJson()).toList(),
    };
  }
}

class OptionModel extends Option {
  OptionModel({
    required String id,
    required String name,
    required double price,
  }) : super(
          id: id,
          name: name,
          price: price,
        );

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}













// import '../../domain/entity/grocery_entity.dart';

// class FoodEntityModel extends FoodEntity {
//   FoodEntityModel({
//     required String id,
//     required String title,
//     required String imageUrl,
//     required double rating,
//     required double price,
//     required double discount,
//     required String description,
//     required List<OptionModel> options,
//   }) : super(
//           id: id,
//           title: title,
//           imageUrl: imageUrl,
//           rating: rating,
//           price: price,
//           discount: discount,
//           description: description,
//           options: options,
//         );

//   factory FoodEntityModel.fromJson(Map<String, dynamic> json) {
//     return FoodEntityModel(
//       id: json['id'],
//       title: json['title'],
//       imageUrl: json['imageUrl'],
//       rating: json['rating'].toDouble(),
//       price: json['price'].toDouble(),
//       discount: json['discount'].toDouble(),
//       description: json['description'],
//       options: (json['options'] as List)
//           .map((optionJson) => OptionModel.fromJson(optionJson))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'imageUrl': imageUrl,
//       'rating': rating,
//       'price': price,
//       'discount': discount,
//       'description': description,
//       'options':
//           options.map((option) => (option as OptionModel).toJson()).toList(),
//     };
//   }
// }

// class OptionModel extends Option {
//   OptionModel({
//     required String id,
//     required String name,
//     required double price,
//   }) : super(
//           id: id,
//           name: name,
//           price: price,
//         );

//   factory OptionModel.fromJson(Map<String, dynamic> json) {
//     return OptionModel(
//       id: json['id'],
//       name: json['name'],
//       price: json['price'].toDouble(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'price': price,
//     };
//   }
// }
