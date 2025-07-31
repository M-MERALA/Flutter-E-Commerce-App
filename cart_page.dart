import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  double getTotalPrice() {
    return widget.cartItems.fold(0, (total, item) {
      return total + (item['price'] * item['selectedCount']);
    });
  }

  void removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }

  void clearCart() {
    setState(() {
      widget.cartItems.clear();
    });
  }

  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter card number';
    }
    // Add more validation logic if needed
    return null;
  }

  String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter expiry date';
    }
    // Add more validation logic if needed
    return null;
  }

  String? validateCVC(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter CVC';
    }
    // Add more validation logic if needed
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name on card';
    }
    return null;
  }

  void _showCardDetailsForm() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Card Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                        hintText: '1234 5678 9012 3456',
                        border: OutlineInputBorder(),
                      ),
                      validator: validateCardNumber,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: expiryDateController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              labelText: 'Expiry Date',
                              hintText: 'MM/YY',
                              border: OutlineInputBorder(),
                            ),
                            validator: validateExpiryDate,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: cvcController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'CVC/CVV',
                              hintText: '123',
                              border: OutlineInputBorder(),
                            ),
                            validator: validateCVC,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name on Card',
                        hintText: 'John Doe',
                        border: OutlineInputBorder(),
                      ),
                      validator: validateName,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancel', style: TextStyle(color: Colors.orange)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Simulate successful payment processing
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Payment successful using card!'),
                                ),
                              );
                              clearCart(); // Clear the cart after payment
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.cartItems.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Image.network(
                      item['imageUrl'],
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: \$${item['price']}'),
                        Text('Quantity: ${item['selectedCount']}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removeItem(index),
                      tooltip: 'Remove Item',
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: widget.cartItems.isEmpty
          ? null
          : Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${getTotalPrice().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: _showCardDetailsForm,
                    child: Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}