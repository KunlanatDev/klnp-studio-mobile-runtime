import 'package:flutter/material.dart';

class KlnpStudioApp extends StatelessWidget {
  const KlnpStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLNP Studio Runtime',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3978F6)),
        useMaterial3: true,
      ),
      home: const RuntimeHomePage(),
    );
  }
}

class RuntimeHomePage extends StatelessWidget {
  const RuntimeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('KLNP Studio', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          const Text('Native Runtime · MVP 1'),
          const SizedBox(height: 16),
          const Text('Document renderer will be implemented in Sprint 6.'),
        ]),
      ),
    );
  }
}
