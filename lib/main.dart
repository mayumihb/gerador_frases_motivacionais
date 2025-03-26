import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'motivational_quotes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBhn8pkcFXAMCtZMB__xxkeZOAp_-T8tLk",
      appId: "1:1060102115295:android:137551424de7e856e6fe6a",
      messagingSenderId: "1060102115295",
      projectId: "gerador-frases-motivacionais",
      databaseURL: "https://gerador-frases-motivacionais-default-rtdb.firebaseio.com/",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MotivationalQuotesPage(),
    );
  }
}
