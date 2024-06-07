import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thoughtpad/providers/thought_provider.dart';
import 'package:thoughtpad/screens/home_screen.dart';

void main() {
  runApp(const ThoughtPad());
}

class ThoughtPad extends StatelessWidget {
  const ThoughtPad({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ThoughtProvider())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ThoughtPad',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
              useMaterial3: true),
          home: const HomeScreen(),
        ));
  }
}
