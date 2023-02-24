import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappclone/common/routers/routes.dart';
import 'package:whatsappclone/common/theme/dark_theme.dart';
import 'package:whatsappclone/common/theme/light_theme.dart';
import 'package:whatsappclone/feature/auth/controller/auth_controller.dart';
import 'package:whatsappclone/feature/home/pages/home_page.dart';
import 'package:whatsappclone/feature/welcome/pages/welcome_page.dart';
import 'package:whatsappclone/firebase_options.dart';


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
 Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Me',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: ref.watch(userInfoAuthProvider).when(
            data: (user) {
              FlutterNativeSplash.remove();
              if (user == null) return const WelcomePage();
              return const HomePage();
            },
            error: (error, trace) {
              return const Scaffold(
                body: Center(
                  child: Text('Something wrong happened'),
                ),
              );
            },
            loading: () => const SizedBox(),
          ),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
