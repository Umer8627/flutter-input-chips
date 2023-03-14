
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chips.dart';
import 'provider/chips_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChipsProvider(),
      child: MaterialApp(
        title: 'Input Chips',
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
           primarySwatch:  Colors.purple,
        ),
        home:const InputChips(),
      ),
    );
  }
}

