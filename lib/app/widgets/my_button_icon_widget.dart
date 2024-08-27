import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class MyButtonIconWidget extends StatelessWidget {
  final bool active;
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const MyButtonIconWidget(
      {super.key,
      required this.active,
      required this.title,
      required this.iconPath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF2188FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: active ? const Color(0xFF2188FF) : const Color(0xFFD8DFE6),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              height: 16,
              colorFilter: ColorFilter.mode(
                active ? Colors.white : const Color(0xFF77818C),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: active ? Colors.white : const Color(0xFF77818C),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
