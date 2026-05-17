import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'sales_summary_screen.dart';
import 'package:flutter/services.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final List<ItemModel> selectedItems;

  const CustomerDetailsScreen({super.key, required this.selectedItems});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController salePriceController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    salePriceController.dispose();
    super.dispose();
  }

  void continueToSummary() {
    if (formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => SalesSummaryScreen(
                selectedItems: widget.selectedItems,

                customerName: nameController.text.trim(),

                customerPhone: phoneController.text.trim(),

                customerAddress: addressController.text.trim(),

                customerSalePrice: salePriceController.text.trim(),
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        centerTitle: true,

        iconTheme: const IconThemeData(color: Colors.black),

        title: const Text(
          "Customer Details",

          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 20),

              const Text(
                "Add Customer",

                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF8C42),
                ),
              ),

              const SizedBox(height: 10),

              buildTextField(
                controller: nameController,

                hint: "Customer Name",

                icon: Icons.person_outline,
              ),

              const SizedBox(height: 20),
TextFormField(
  controller: phoneController,

  keyboardType: TextInputType.number,

  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
  ],

  validator: (value) {

    if (value == null ||
        value.isEmpty) {

      return "Required field";
    }

    if (value.length < 10) {
      return "Enter 10 digit number";
    }

    return null;
  },

  decoration: InputDecoration(
    labelText: "Phone Number",

    hintText: "Phone Number",

    labelStyle: const TextStyle(
      color: Color(0xFFFF8C42),
      fontWeight: FontWeight.w600,
    ),

    prefixIcon: const Icon(
      Icons.phone_outlined,
      color: Color(0xFFFF8C42),
    ),

    filled: true,
    fillColor: Colors.white,

    border: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(18),
  borderSide: BorderSide.none
     
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(18),

      borderSide: BorderSide.none
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(18),

      borderSide: const BorderSide(
        color: Color(0xFFFF8C42),
        width: 1.5,
      ),
    ),
  ),
),

              const SizedBox(height: 20),

              buildTextField(
                controller: addressController,
                hint: "Customer Address",
                icon: Icons.location_on_outlined,
                maxLines: 4,
              ),

              const SizedBox(height: 20),

             TextFormField(
  controller: salePriceController,

  keyboardType: TextInputType.number,

  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],

  decoration: InputDecoration(
    labelText: "Customer Sale Price",

    hintText: "Customer Sales Price  (optional)", hintStyle: TextStyle(color: const Color.fromARGB(255, 145, 152, 158)),

    labelStyle: const TextStyle(
      color: Color(0xFFFF8C42),
      fontWeight: FontWeight.w600,
    ),

    prefixIcon: const Icon(
      Icons.currency_rupee,
      color: Color(0xFFFF8C42),
    ),

    filled: true,
    fillColor: Colors.white,

    border: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(18),

      borderSide: BorderSide.none,
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(18),

      borderSide: BorderSide.none,
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(18),

      borderSide: const BorderSide(
        color: Color(0xFFFF8C42),
        width: 1.5,
      ),
    ),
  ),
),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8C42),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  onPressed: continueToSummary,

                  child: const Text(
                    "Continue",

                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,

      validator: (value) {
        if (hint != "Customer Sale Price") {
          if (value == null || value.isEmpty) {
            return "Required field";
          }
        }

        return null;
      },

      decoration: InputDecoration(
        labelText: hint,

        hintText: hint,

        labelStyle: const TextStyle(
          color: Color(0xFFFF8C42),
          fontWeight: FontWeight.w600,
        ),

        prefixIcon: Icon(icon, color: const Color(0xFFFF8C42)),

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),

          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),

          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),

          borderSide: const BorderSide(color: Color(0xFFFF8C42), width: 1.5),
        ),
      ),
    );
  }
}
