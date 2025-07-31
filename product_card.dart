import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final Map<String, dynamic> product;
  final bool isFavorite;
  final Function(Map<String, dynamic>) onFavoriteToggle;
  final Function(Map<String, dynamic>) onAddToCart;

  const ProductCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            height: 230,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis, // Handle overflow
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '\$$price',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () => onFavoriteToggle(product),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
