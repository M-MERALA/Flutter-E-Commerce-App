import 'package:flutter/material.dart';
import 'favorite_page.dart';
import 'cart_page.dart';
import 'products.dart';
import 'category_button.dart';
import 'product_card.dart';
import 'profile_page.dart';
import 'product_detail_page.dart'; // Import the ProductDetailPage

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<String> categories = ['Sneakers', 'Jacket', 'Watch'];
  String selectedCategory = 'Sneakers';
  String searchQuery = '';

  List<Map<String, dynamic>> favoriteProducts = [];
  List<Map<String, dynamic>> cartItems = [];
  int currentIndex = 0;
  bool isDarkMode = false; // State variable for dark mode

  void toggleFavorite(Map<String, dynamic> product) {
    setState(() {
      if (favoriteProducts.contains(product)) {
        favoriteProducts.remove(product);
      } else {
        favoriteProducts.add(product);
      }
    });
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      final existingItem = cartItems.firstWhere(
        (item) =>
            item['title'] == product['title'], // Using title for simplicity
        orElse: () => {},
      );

      if (existingItem.isNotEmpty) {
        existingItem['selectedCount'] += product['selectedCount'];
      } else {
        cartItems.add(product);
      }
    });
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      final matchesCategory = product['category'] == selectedCategory;
      final matchesSearch =
          product['title'].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    final pages = [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Products',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categories.map((category) {
                return CategoryButton(
                  title: category,
                  isSelected: selectedCategory == category,
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: filteredProducts.map((product) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to ProductDetailPage when a product card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: product,
                            onAddToCart: addToCart,
                          ),
                        ),
                      );
                    },
                    child: ProductCard(
                      imageUrl: product['imageUrl'],
                      title: product['title'],
                      price: product['price'],
                      product: product,
                      isFavorite: favoriteProducts.contains(product),
                      onFavoriteToggle: toggleFavorite,
                      onAddToCart: addToCart,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      ProfilePage(),
      CartPage(cartItems: cartItems),
      FavoritePage(
        favoriteProducts: favoriteProducts,
        onRemoveFavorite: (product) {
          setState(() {
            favoriteProducts.remove(product);
          });
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        title: Text('Our Products'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'images/WhatsApp Image 2024-12-26 at 14.53.18_c4e4e0f5.jpg'),
            ),
          ),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
