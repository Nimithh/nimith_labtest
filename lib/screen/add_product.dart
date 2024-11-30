import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nimith_labtest/appurl.dart';
import 'package:nimith_labtest/main.dart';
import 'package:nimith_labtest/screen/home_screen.dart';
import 'package:http/http.dart' as http;

class AddEditProduct extends StatefulWidget {
  const AddEditProduct({super.key});

  @override
  State<AddEditProduct> createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _expireddateController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _priceInController = TextEditingController();
  final TextEditingController _priceOutController = TextEditingController();

  int? selectedCategoryID;

  Future<void> insertProduct(
    String productName,
    String description,
    int categoryid,
    String barcode,
    String expireddate,
    int quantity,
    double priceIn,
    double priceOut,
  ) async {
    var uri = Uri.parse("${AppUrl.url}insert_product.php");
    EasyLoading.show(status: 'loading...');
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (categoryid == 0) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a valid category"),
        ),
      );
      return;
    }

    final response = await http.post(
      uri,
      body: {
        'ProductName': productName,
        'Description': description,
        'CategoryID': categoryid.toString(),
        'Barcode': barcode,
        'ExpiredDate': expireddate,
        'Qty': quantity.toString(),
        'UnitPriceIn': priceIn.toString(),
        'UnitPriceOut': priceOut.toString(),
      },
    );

    if (!mounted) return;
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      final data = jsonDecode(response.body);
      if (data['success'] == 1) {
        EasyLoading.showSuccess("${data['msg_success']}");
        Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        EasyLoading.showError("${data['msg_error']}");
      }
    } else {
      EasyLoading.showError("Failed to insert Product");
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
    _barcodeController.dispose();
    _expireddateController.dispose();
    _qtyController.dispose();
    _priceInController.dispose();
    _priceOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Product",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.greenAccent[700],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 10),
                TextFormField(
                  controller: _productNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product Name',
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a product name'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  value: selectedCategoryID,
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text("Drink"),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text("Clothes"),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text("Shoes"),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text("Jewelry"),
                    ),
                    DropdownMenuItem(
                      value: 5,
                      child: Text("Sports"),
                    ),
                  ],
                  onChanged: (value) =>
                      setState(() => selectedCategoryID = value),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category',
                  ),
                  validator: (value) =>
                      value == null ? 'Please select a category' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _barcodeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Barcode',
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a barcode'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _expireddateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expired Date',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an expired date';
                    }
                    try {
                      DateTime parsedDate = DateTime.parse(value);
                      if (parsedDate.isBefore(DateTime.now())) {
                        return 'Expired date cannot be in the past';
                      }
                    } catch (e) {
                      return 'Please enter a valid date (YYYY-MM-DD)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _qtyController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantity',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a quantity';
                    }
                    if (int.tryParse(value) == null || int.parse(value) < 0) {
                      return 'Please enter a valid non-negative quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _priceInController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price In',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price in';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) < 0) {
                      return 'Please enter a valid non-negative price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _priceOutController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price Out',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price out';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) < 0) {
                      return 'Please enter a valid non-negative price';
                    }
                    return null;
                  },
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        insertProduct(
                          _productNameController.text,
                          _descriptionController.text,
                          selectedCategoryID ?? 0,
                          _barcodeController.text,
                          _expireddateController.text,
                          int.tryParse(_qtyController.text) ?? 0,
                          double.tryParse(_priceInController.text) ?? 0.0,
                          double.tryParse(_priceOutController.text) ?? 0.0,
                        );
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
