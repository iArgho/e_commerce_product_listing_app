import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Navigate or show product details
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.flutter_dash,
                  size: 48,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Product Name',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 4),

            // Price, Rating, Favorite
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text(
                    '\$99',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.star, size: 12, color: Colors.amber),
                  SizedBox(width: 2),
                  Text('4.8', style: TextStyle(fontSize: 10)),
                  Spacer(),
                  Icon(
                    Icons.favorite_border,
                    size: 14,
                    color: Colors.deepOrangeAccent,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
