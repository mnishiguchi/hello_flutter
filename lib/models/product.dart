import 'package:flutter/material.dart';

class Product {
  final String title;
  final String description;
  final String price;
  final String image;
  final String userId;
  final String userEmail;
  final bool isFavorite;

  Product({
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.image,
    @required this.userId,
    @required this.userEmail,
    this.isFavorite = false,
  });
}
