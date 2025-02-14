import 'package:flutter/material.dart';
import 'features/home/home_screen.dart';
import 'features/home/all_topics_screen.dart';
import 'features/home/ImpactHubScreen.dart';
import 'features/Profile/ProfilePage.dart';
import 'features/home/EdutokScreen.dart';
import 'features/home/SkillSwapPage.dart';
import 'features/splash/screens/Splashscreen.dart'; // Add SplashScreen import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edu Bridge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ),
      initialRoute: '/splash', // Changed initial route
      routes: {
        '/splash': (context) => const SplashScreen(), // Added splash route
        '/': (context) => const HomeScreen(),
        '/all-topics': (context) => const AllTopicsScreen(),
        '/impact-hub': (context) => const ImpactHubScreen(),
        '/profile': (context) => const ProfilePage(),
        '/edutok': (context) => const EdutokScreen(),
        '/skill-swap': (context) => const SkillSwapPage(),
      },
      onGenerateRoute: (settings) {
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            switch (settings.name) {
              case '/splash':
                return const SplashScreen(); // Added splash case
              case '/':
                return const HomeScreen();
              case '/all-topics':
                return const AllTopicsScreen();
              case '/impact-hub':
                return const ImpactHubScreen();
              case '/profile':
                return const ProfilePage();
              case '/edutok':
                return const EdutokScreen();
              case '/skill-swap':
                return const SkillSwapPage();
              default:
                return const SplashScreen(); // Default to splash
            }
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}