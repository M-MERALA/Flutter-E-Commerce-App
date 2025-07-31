import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50], // Light orange background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar with a shadow effect
            const CircleAvatar(
              radius: 65,
              backgroundImage: AssetImage(
                  'images/WhatsApp Image 2024-12-26 at 14.53.18_c4e4e0f5.jpg'), // Replace with actual image URL
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
            // Welcome back message
            Text(
              'Welcome back, Mohammed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800], // Darker orange color for name
              ),
            ),
            const SizedBox(height: 20),
            // Email Text with styling
            Text(
              'Email: Mohammed123@aast.com',
              style: TextStyle(fontSize: 18, color: Colors.orange[600]),
            ),
            const SizedBox(height: 10),
            // Phone number with styling
            Text(
              'Phone: +201579579857',
              style: TextStyle(fontSize: 18, color: Colors.orange[600]),
            ),
            const SizedBox(height: 20),
            // Additional information section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // User's address (example)
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.orange[800]),
                      SizedBox(width: 10),
                      Text(
                        'Address: 123 Elslam street, Cairo, Egypt',
                        style:
                            TextStyle(fontSize: 16, color: Colors.orange[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // User's date of birth (example)
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.orange[800]),
                      SizedBox(width: 10),
                      Text(
                        'Date of Birth: 04/12/2003',
                        style:
                            TextStyle(fontSize: 16, color: Colors.orange[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
