import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dhanmanthan_original/api/api.dart';
import 'package:dhanmanthan_original/models/user_model.dart';
import 'package:dhanmanthan_original/screens/loginscreen.dart';
import 'package:dhanmanthan_original/tabs/homepage_tab.dart';
import 'package:dhanmanthan_original/tabs/profilepage_tab.dart';
import 'package:dhanmanthan_original/widgets/my_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;
  List<TheUser> users = [];
  TheUser? currentUser;
  late List<Widget> tabs;

  void _handleSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    tabs = [
      const HomepageTab(),
      Container(),
      Container(),
      const SizedBox() // Placeholder for ProfileScreen
    ];
  }

  @override
  Widget build(BuildContext context) {
    final iconList = [
      Icons.home,
      Icons.people,
      Icons.newspaper,
      Icons.account_circle,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 160, 203, 255),
        title: Text(
          'DhanManthan',
          style: GoogleFonts.abel(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _handleSignOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          )
        ],
      ),
      drawer: const Drawer(
          backgroundColor: Color.fromARGB(255, 227, 240, 254),
          elevation: 1,
          child: MyDrawer()),
      body: StreamBuilder(
        stream: API().firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const SizedBox(
              child: Center(
                child: Text(
                  "Unable to fetch USER data",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          } else {
            final data = snapshot.data!.docs;
            users = data.map((doc) {
              final userData = doc.data();
              return TheUser.fromJson(userData);
            }).toList();
            for (TheUser cuser in users) {
              if (API().firebaseAuth.currentUser!.uid == cuser.id) {
                currentUser = cuser;
              }
            }

            if (currentUser != null) {
              tabs[3] = ProfileScreen(currentUser: currentUser!);
            }

            return tabs[_bottomNavIndex];
          }
        },
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 160, 203, 255),
          onPressed: () {},
          child: const Icon(
            Icons.chat_bubble,
            size: 27,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: 30,
        backgroundColor: const Color.fromARGB(255, 160, 203, 255),
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        activeColor: Colors.white,
        icons: iconList,
        inactiveColor: Colors.black,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        onTap: (index) => setState(() {
          _bottomNavIndex = index;
        }),
      ),
    );
  }
}
