import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/vk_services/vk_services_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VkServices(),
    );
  }
}
