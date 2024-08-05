import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhanmanthan_original/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dhanmanthan_original/api/api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dhanmanthan_original/screens/loginscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.currentUser});
  final TheUser currentUser;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final GoogleSignIn _googleSignIn = GoogleSignIn();
final _formkey = GlobalKey<FormState>();
String? _image;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    void updateImage() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  'Pick a Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20)),
                      onPressed: () {},
                      child: const Icon(
                        Icons.photo,
                        size: 50,
                        color: Color.fromARGB(255, 45, 123, 47),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20)),
                      onPressed: () async {},
                      child: const Icon(
                        Icons.camera,
                        size: 50,
                        color: Color.fromARGB(255, 45, 123, 47),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    void handleSignOut() async {
      try {
        await FirebaseAuth.instance.signOut();
        await _googleSignIn.signOut();
        if (!context.mounted) return;
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Sign-in failed. Please try again.'),
            duration: Duration(seconds: 3)));
      }
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: _image == null
                              ? CachedNetworkImage(
                                  imageUrl: widget.currentUser.image,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(_image!),
                                  fit: BoxFit.cover,
                                ),
                        )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: MaterialButton(
                        elevation: 1,
                        shape: const CircleBorder(),
                        color: const Color.fromARGB(255, 207, 250, 229),
                        onPressed: () {
                          updateImage();
                        },
                        child: const Icon(Icons.edit),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.currentUser.email,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          onSaved: (value) {
                            widget.currentUser.name = value!;
                          },
                          validator: (value) {
                            if (value != Null && value!.isNotEmpty) {
                              return null;
                            } else {
                              return 'Field Required';
                            }
                          },
                          initialValue: widget.currentUser.name,
                          decoration: const InputDecoration(
                              label: Text('Name'),
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                              hintText: 'eg. Honey Singh'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onSaved: (value) {
                            widget.currentUser.about = value!;
                          },
                          validator: (value) {
                            if (value != Null && value!.isNotEmpty) {
                              return null;
                            } else {
                              return 'Field Required';
                            }
                          },
                          initialValue: widget.currentUser.about,
                          decoration: const InputDecoration(
                              label: Text('About'),
                              prefixIcon: Icon(Icons.error_outline_rounded),
                              border: OutlineInputBorder(),
                              hintText: 'eg. Feeling Happy'),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 207, 250, 229)),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                  API().updateUserData(widget.currentUser);
                                }
                              },
                              label: const Text(
                                'UPDATE',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 50,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 207, 250, 229)),
                                  onPressed: () {
                                    handleSignOut();
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.black,
                                  ),
                                  label: const Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.black),
                                  )),
                            )
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
