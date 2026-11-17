import 'package:flutter/material.dart';

import '../features/preview/presentation/pages/preview_page.dart';
import 'theme/app_theme.dart';

class KLNPStudioApp extends StatelessWidget {
  const KLNPStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLNP Studio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const PreviewPage(),
    );
  }
}
