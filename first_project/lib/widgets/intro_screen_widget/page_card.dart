import 'package:flutter/material.dart';

import 'package:flutter_application_1/colors/app_colors.dart';

class IntroPageCard
    extends StatelessWidget {
  final Map<String, String>
  page;

  const IntroPageCard({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          buildImageCard(),

          const SizedBox(height: 50),

          buildTitle(),

          const SizedBox(height: 16),

          buildDescription(),
        ],
      ),
    );
  }

  // IMAGE CARD
  Widget buildImageCard() {
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(
          35,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.orange
                .withOpacity(0.15),

            blurRadius: 30,

            offset: const Offset(
              0,
              10,
            ),
          ),
        ],
      ),

      child: Image.asset(
        page["image"]!,

        height: 260,
      ),
    );
  }

  // TITLE
  Widget buildTitle() {
    return Text(
      page["title"]!,

      textAlign:
          TextAlign.center,

      style: const TextStyle(
        fontSize: 30,

        fontWeight:
            FontWeight.bold,

        color: AppColors.text,
      ),
    );
  }

  // DESCRIPTION
  Widget buildDescription() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
      ),

      child: Text(
        page["desc"]!,

        textAlign:
            TextAlign.center,

        style: TextStyle(
          fontSize: 16,

          height: 1.6,

          color:
              Colors.grey.shade600,
        ),
      ),
    );
  }
}