import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nimith_labtest/main.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nimith_labtest/screen/add_product.dart';
import 'package:nimith_labtest/appurl.dart';
import 'package:http/http.dart' as http;
import 'package:nimith_labtest/screen/home_screen.dart';
import 'package:nimith_labtest/screen/product_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> products = [];
  bool isLoading = false;

  Future<void> getProduct() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse("${AppUrl.url}get_products.php"),
      );
      EasyLoading.show(status: 'loading...');
      await Future.delayed(
        const Duration(seconds: 1),
      );
      if (!mounted) return;
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final data = jsonDecode(response.body);
        if (data['success'] == 1) {
          setState(() {
            products = data['products'];
          });
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(data['msg_error'] ?? "Error fetching products"),
          //   ),
          // );
          EasyLoading.showError("${data['msg_error']}");
        }
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //       content: Text("Failed to fetch products. Try again later.")),
        // );
        EasyLoading.showError("Failed to fetch products. Try again later.");
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Error: $e")),
      // );
      EasyLoading.showError("Error: $e");
    } finally {
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.greenAccent[700],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : products.isEmpty
              ? const Center(child: Text("No products found"))
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(product['ProductName']),
                        subtitle: Text(
                            "Qty: ${product['Qty']} | Price: ${product['UnitPriceOut']}"),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductDetails(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () async {
          EasyLoading.show(status: 'loading...');
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditProduct(),
            ),
          );
          EasyLoading.dismiss();
          getProduct();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
