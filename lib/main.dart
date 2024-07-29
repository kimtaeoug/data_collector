import 'package:data_collector/detect_page.dart';
import 'package:data_collector/utils/background_util.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DetectPage(),
      // home: Scaffold(
      //   body: Center(
      //     child: Text('HEY!'),
      //   ),
      // ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


