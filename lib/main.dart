import 'package:cajero_automatico/interface/pages/home_page.dart';
import 'package:cajero_automatico/interface/pages/withdraw_money_page.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/retiro': (context) => const WithdrawMoneyPage(),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const WithdrawMoneyPage(),
          settings: const RouteSettings(name: '/retiro'),
          maintainState: false,
          fullscreenDialog: true,
        );
      },
    );
  }
}
