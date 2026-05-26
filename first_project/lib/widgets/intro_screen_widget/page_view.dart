import 'package:flutter/material.dart';

import 'page_card.dart';

class IntroPageView
    extends StatelessWidget {
  final PageController
  controller;

  final List<
    Map<String, String>
  >
  pages;

  final Function(int)
  onPageChanged;

  const IntroPageView({
    super.key,
    required this.controller,
    required this.pages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,

      itemCount: pages.length,

      onPageChanged:
          onPageChanged,

      itemBuilder: (
        context,
        index,
      ) {
        return IntroPageCard(
          page: pages[index],
        );
      },
    );
  }
}