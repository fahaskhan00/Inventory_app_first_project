import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

import '../items_widgets.dart';

class SearchFilterSection
    extends StatelessWidget {
  final TextEditingController
  controller;

  final Function(String)
  onChanged;

  final VoidCallback
  onFilterTap;

  const SearchFilterSection({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        14,
      ),

      decoration: BoxDecoration(
        color: const Color.fromARGB(
          255,
          14,
          97,
          179,
        ),

        borderRadius:
            BorderRadius.circular(22),

        border: Border.all(
          color: AppColors.primary
              .withOpacity(0.08),
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.08,
            ),

            blurRadius: 12,

            offset: const Offset(
              0,
              9,
            ),
          ),
        ],
      ),

      child: Row(
        children: [
          Expanded(
            child: buildSearchBar(
              controller: controller,

              onChanged: onChanged,
            ),
          ),

          const SizedBox(width: 12),

          filterButton(onFilterTap),
        ],
      ),
    );
  }
}