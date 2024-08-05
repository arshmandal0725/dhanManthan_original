import 'dart:async';
import 'package:dhanmanthan_original/screens/homescreen.dart';
import 'package:dhanmanthan_original/screens/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (FirebaseAuth.instance.currentUser != null) {
        User? user = FirebaseAuth.instance.currentUser;
        print('Current user: $user');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/images/Animation - 1720009363777.json'),
          const SpinKitCircle(
            color: Colors.blue,
            size: 70,
          )
        ],
      ),
    );
  }
}
