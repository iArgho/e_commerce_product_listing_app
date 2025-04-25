import 'package:e_commerce_product_listing_app/ui/presentation/home_page.dart';
import 'package:flutter/material.dart';

class ProductListing extends StatelessWidget {
  const ProductListing({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const HomePage(),
    );
  }
}
