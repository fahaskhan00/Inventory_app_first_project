import 'package:flutter/material.dart';

import 'package:flutter_application_1/widgets/filter_widget.dart';

class FilterChipWrap
    extends StatelessWidget {
  final List<String> list;

  final int selectedIndex;

  final Function(int) onTap;

  const FilterChipWrap({
    super.key,
    required this.list,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return chipWrap(
      list: list,

      selectedIndex:
          selectedIndex,

      onTap: onTap,
    );
  }
}