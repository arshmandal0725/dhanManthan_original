import 'package:dhanmanthan_original/api/api.dart';
import 'package:dhanmanthan_original/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool _islogin = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Future<void> signInWithGoogle() async {
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          await FirebaseAuth.instance.signInWithCredential(credential);

          if (await API().userExists()) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (ctx) => HomeScreen()),
            );
          } else {
            await API().createUser().then((value) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (ctx) => HomeScreen()),
                ));
          }
        } else {
          _islogin = false;
          setState(() {});
          // Handle sign-in failure
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Sign-in failed. Please try again.'),
            duration: Duration(seconds: 3),
          ));
        }
      } catch (e) {
        // Handle exceptions
        print('Error signing in with Google: $e');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('An error occurred. Please try again.'),
          duration: Duration(seconds: 3),
        ));
      }
    }

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 193, 221, 255),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(62),
                        bottomRight: Radius.circular(62))),
              )),
              Expanded(child: Container())
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100, top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  'Welcome !',
                  style: GoogleFonts.abel(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 13, 126, 219)),
                ),
                Text(
                  'To DhanManthan',
                  style: GoogleFonts.lato(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'All finances problems | One solution | Free Articles',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Positioned(
                      right: 0,
                      left: 0,
                      child: Opacity(
                        opacity: 0.85,
                        child: SizedBox(
                          height: height * 0.42,
                          child: Image.asset(
                            'assets/images/8ea9a817-1988-4568-95e0-b8009315b583.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.65,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/f1d09dbe-058d-4133-bb00-be8afacd4a0c.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: width * 0.85,
                  height: height * 0.060,
                  child: ElevatedButton(
                    onPressed: () {
                      signInWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 193, 221, 255),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: height * 0.04,
                          child: Image.asset('assets/images/google.png'),
                        ),
                        const Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
