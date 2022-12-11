import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe363project/cloud_functions/auth_service.dart';
import 'package:swe363project/web_pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAj_p9FD8Q3Nb77d7rHkEkqcuTsdEzgRIs",
          projectId: "spc-watch-23a53",
          messagingSenderId: "682162694206",
          appId: "1:682162694206:web:edf2babef0e59fb66d896f"));
  runApp(StreamProvider.value(
      value: Auth().user,
      initialData: null,
      child: MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
          debugShowCheckedModeBanner: false,
          home: const HomePage())));
}
