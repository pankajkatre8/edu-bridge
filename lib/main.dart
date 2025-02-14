import 'package:flutter/material.dart';
import 'features/home/home_screen.dart';
import 'features/home/all_topics_screen.dart';
import 'features/home/ImpactHubScreen.dart';
import 'features/Profile/ProfilePage.dart';
import 'features/home/EdutokScreen.dart';
import 'features/home/SkillSwapPage.dart';
import 'features/splash/screens/Splashscreen.dart';
import 'features/home/LaunchPadScreen.dart';
import 'features/auth/presentation/screen/LoginPage.dart';
import 'features/auth/presentation/screen/RegistrationPage.dart';

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
      initialRoute: '/splash',
      onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            switch (settings.name) {
              case '/splash':
                return const SplashScreen();
              case '/login':
                return const LoginPage();
              case '/register':
                return const RegistrationPage();
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
              case '/launchpad':
                return const LaunchPadScreen();
              default:
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found!'),
                  ),
                );
            }
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);

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