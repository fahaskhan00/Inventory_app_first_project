import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/models/item_model.dart';
import 'bill_preview_screen.dart';
import 'package:flutter_application_1/widgets/customer_details_widget/appbar.dart';
import 'package:flutter_application_1/widgets/customer_details_widget/header.dart';
import 'package:flutter_application_1/widgets/customer_details_widget/textfield.dart';
import 'package:flutter_application_1/widgets/customer_details_widget/continue_button.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final List<ItemModel> selectedItems;

  final List updatedItems;

  final double total;

  const CustomerDetailsScreen({
    super.key,
    required this.selectedItems,
    required this.updatedItems,
    required this.total,
  });

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  // NAME CONTROLLER
  final TextEditingController nameController = TextEditingController();

  // PHONE CONTROLLER
  final TextEditingController phoneController = TextEditingController();

  // FORM KEY
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();

    phoneController.dispose();

    super.dispose();
  }

  // CONTINUE TO BILL PREVIEW
  void continueToBillPreview() {
    if (formKey.currentState!.validate()) {
      Navigator.push(
        context,

        MaterialPageRoute(
          builder:
              (context) => BillPreviewScreen(
                items: widget.updatedItems,

                total: widget.total,

                customerName: nameController.text.trim(),

                customerPhone: phoneController.text.trim(),
              ),
        ),
      );
    }
  }

  // APP BAR
  PreferredSizeWidget buildAppBar() {
    return const CustomerDetailsAppBar();
  }

  // HEADER
  Widget buildHeader() {
    return const CustomerHeader();
  }

  // NAME FIELD
  Widget buildNameField() {
    return CustomerTextField(
      controller: nameController,

      hint: "Customer Name",

      icon: Icons.person_outline,
    );
  }

  // PHONE FIELD
  Widget buildPhoneField() {
    return CustomerTextField(
      controller: phoneController,

      hint: "Phone Number",

      icon: Icons.phone_outlined,

      keyboardType: TextInputType.number,

      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,

        LengthLimitingTextInputFormatter(10),
      ],

      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Required field";
        }

        if (value.length < 10) {
          return "Enter 10 digit number";
        }

        return null;
      },
    );
  }

  // CONTINUE BUTTON
  Widget buildContinueButton() {
    return ContinueButton(onTap: continueToBillPreview);
  }

  // BODY
  Widget buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Form(
        key: formKey,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 20),

            buildHeader(),

            const SizedBox(height: 10),

            buildNameField(),

            const SizedBox(height: 20),

            buildPhoneField(),

            const SizedBox(height: 40),

            buildContinueButton(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: buildAppBar(),

      body: buildBody(),
    );
  }
}
