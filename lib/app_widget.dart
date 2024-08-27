import 'package:flutter/material.dart';

import 'package:tractian_test/app/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TRACTIAN',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
