import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteProducts;
  final Function(Map<String, dynamic>) onRemoveFavorite;

  const FavoritePage({
    required this.favoriteProducts,
    required this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: favoriteProducts.isEmpty
            ? Center(
                child: Text(
                  'No favorite products yet!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              )
            : GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: favoriteProducts.map((product) {
                  return GestureDetector(
                    onTap: () {}, // Optional: handle card tap if needed
                    child: Container(
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26.0),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  product['imageUrl'],
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  product['title'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '\$${product['price']}',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            // Cancel icon
                            Positioned(
                              top: 145,
                              right: 8,
                              child: IconButton(
                                icon: Icon(Icons.cancel, color: Colors.red),
                                onPressed: () => onRemoveFavorite(product), // Remove product
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
