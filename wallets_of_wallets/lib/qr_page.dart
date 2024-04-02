import 'package:flutter/material.dart';

class QrPage extends StatelessWidget {

  final Color customColor = Color(0xFF0A5440);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: customColor),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'QR',
                      textAlign: TextAlign.left,
                    ),
                  ),
                    Icon(Icons.qr_code),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}