import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/widgets/custom_snackbar.dart';
import 'package:flutter_application_1/services/database_hive.dart';
import '../widgets/catagories_dart/catagories_header.dart';
import '../widgets/catagories_dart/catagories_textfield.dart';
import '../widgets/catagories_dart/catagories_button.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController controller = TextEditingController();

  void addCategory() {
    String categoryName = controller.text.trim();

    if (categoryName.isEmpty) {
      CustomSnackBar.show(context, 'enter category name');

      return;
    }

    final categories = DatabaseApp.instance.getCategories();

    final alreadyExists = categories.any(
      (e) => e.toLowerCase() == categoryName.toLowerCase(),
    );

    if (alreadyExists) {
      CustomSnackBar.show(context, 'Category already exists');

      return;
    }

    Navigator.pop(context, categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          "Add Category",

          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),

        centerTitle: true,

        backgroundColor: AppColors.transparent,

        elevation: 0,

        iconTheme: const IconThemeData(color: AppColors.black),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Container(
            padding: const EdgeInsets.all(24),

            decoration: BoxDecoration(
              color: AppColors.white,

              borderRadius: BorderRadius.circular(28),

              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.08),

                  blurRadius: 16,

                  offset: const Offset(0, 6),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                const CategoryHeader(),

                const SizedBox(height: 28),

                CategoryTextField(
                  controller: controller,
                  onSubmit: addCategory,
                ),

                const SizedBox(height: 30),

                AddCategoryButton(onTap: addCategory),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
