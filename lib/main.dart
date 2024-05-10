import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'logiin.dart';
import 'sign_up.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' as root;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCHboAOLMyuQu08Fk6EyjaLo4xaUV36O14",
      appId: "1:440400631632:android:f72a9c192a33a44cc5be55",
      messagingSenderId: "440400631632",
      projectId: "auth-bff0c",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the user's authentication state to be determined
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.hasData) {
              User? user = snapshot.data;
              return HomeScreen(displayName: user?.displayName);
            } else {
              return const signinscreen();
            }
          }
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.displayName}) : super(key: key);

  final String? displayName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              child: Image(image: AssetImage('images/welcome.png')),
              height: 200.0,
            ),
            Text(
              "Welcome ${displayName ?? 'User'}",
              style: const TextStyle(fontSize: 35.0),

            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
