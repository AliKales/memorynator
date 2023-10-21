import 'package:flutter/material.dart';
import 'package:memorynator/core/sql.dart';
import 'package:memorynator/theme.dart';

import 'pages/persons_page/persons_page_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Sql.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memorynator',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme(true).theme(context),
      home: const PersonsPageView(),
    );
  }
}
