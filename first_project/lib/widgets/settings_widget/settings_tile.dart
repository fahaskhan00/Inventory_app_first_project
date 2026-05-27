//==================== settings_tile.dart ====================//

import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {

  final String title;

  final IconData icon;

  final VoidCallback onTap;

  final Color? iconColor;

  const SettingsTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.circular(22),

          boxShadow: [

            BoxShadow(
              color: Colors.orange.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),

          ],
        ),

        child: Row(

          children: [

            //==================== ICON ====================//

            Container(

              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(

                color: const Color(0xFFFFF3E8),

                borderRadius: BorderRadius.circular(14),

              ),

              child: Icon(
                icon,
                color: iconColor ?? const Color(0xFFFF8C42),
              ),

            ),

            const SizedBox(width: 14),

            //==================== TITLE ====================//

            Expanded(

              child: Text(

                title,

                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),

            //==================== ARROW ====================//

            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey.shade500,
              size: 18,
            ),

          ],
        ),
      ),
    );
  }
}