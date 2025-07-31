import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onAddToCart;

  ProductDetailPage({
    required this.product,
    required this.onAddToCart,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  double selectedCount = 1;
  late double maxCount;

  @override
  void initState() {
    super.initState();
    maxCount = widget.product['count_of_product'].toDouble();
  }

  void addToCart() {
    if (selectedCount <= maxCount) {
      Map<String, dynamic> cartItem = {
        'title': widget.product['title'],
        'imageUrl': widget.product['imageUrl'],
        'price': widget.product['price'],
        'description': widget.product['description'],
        'rating': widget.product['rating'], // Fixed this line
        'selectedCount': selectedCount.toInt(),
      };

      widget.onAddToCart(cartItem);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success', style: TextStyle(color: Colors.green)),
          content: Text(
              'You have successfully added ${selectedCount.toInt()} of ${widget.product['title']} to the cart.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sorry'),
          content: Text('The quantity selected exceeds available stock.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['title']),
        backgroundColor: Colors.orange,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.product['imageUrl'],
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.product['description'],
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 13),
              Text(
                'Price: \$${widget.product['price']}',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 13),
              Text(
                'Available: ${widget.product['count_of_product']}',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 13),
              Text(
                ' ⭐ ${widget.product['rating']}', // Fixed this line
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 16),
              Text(
                'Select Quantity: ${selectedCount.toInt()}',
                style: TextStyle(fontSize: 16),
              ),
              Slider(
                activeColor: Colors.orange,
                thumbColor: Colors.orange,
                value: selectedCount,
                min: 1,
                max: maxCount,
                divisions: maxCount.toInt(),
                label: selectedCount.toInt().toString(),
                onChanged: (value) {
                  setState(() {
                    selectedCount = value;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: addToCart,
                child: Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.orange),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.orange),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
