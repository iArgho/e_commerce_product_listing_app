import 'package:e_commerce_product_listing_app/model/product_model.dart';
import 'package:e_commerce_product_listing_app/service/api_service.dart';
import 'package:e_commerce_product_listing_app/ui/widget/product_cart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  String _sortOption = 'None';

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts =
          _allProducts
              .where((product) => product.title.toLowerCase().contains(query))
              .toList();
      _applySorting();
    });
  }

  void _sortProducts(String option) {
    setState(() {
      _sortOption = option;
      _applySorting();
    });
  }

  void _applySorting() {
    if (_sortOption == 'Price: Low to High') {
      _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortOption == 'Price: High to Low') {
      _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    }
  }

  Future<void> _loadProducts() async {
    try {
      final products = await ApiService.fetchProducts();
      setState(() {
        _allProducts = products;
        _filteredProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search TextField
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search products...',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Sort Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton<String>(
                    value: _sortOption,
                    items: const [
                      DropdownMenuItem(value: 'None', child: Text('Sort')),
                      DropdownMenuItem(
                        value: 'Price: Low to High',
                        child: Text('Low to High'),
                      ),
                      DropdownMenuItem(
                        value: 'Price: High to Low',
                        child: Text('High to Low'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) _sortProducts(value);
                    },
                  ),
                ],
              ),
            ),

            // Product Grid
            Expanded(
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _filteredProducts.isEmpty
                      ? const Center(child: Text('No products found.'))
                      : GridView.count(
                        crossAxisCount: 2,
                        padding: const EdgeInsets.all(16.0),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.80,
                        children:
                            _filteredProducts
                                .map((product) => ProductCard(product: product))
                                .toList(),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
