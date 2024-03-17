import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:practice_7/auth.dart';
import 'package:practice_7/shared_preferences.dart';
import 'package:practice_7/translations/codegen_loader.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await sharedPreference.init();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru'), Locale('kk')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Router example',
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LanguagesPick(),
          ],
        ),
      ),
    );
  }
}

class LanguagesPick extends StatelessWidget {
  const LanguagesPick({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (BuildContext context) => AuthPage(languageCode: 'ru'),
              ),
            );
          },
          child: Text('Русский'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (BuildContext context) => AuthPage(languageCode: 'kk'),
              ),
            );
          },
          child: Text('Казахский'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (BuildContext context) => AuthPage(languageCode: 'en'),
              ),
            );
          },
          child: Text('Английский'),
        )

      ],
    );
  }
}

