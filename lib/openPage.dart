import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:medtrack/servies/database.dart';
import 'package:medtrack/worngDialgo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OpenPage extends StatefulWidget {
  @override
  State<OpenPage> createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool obscure = true;
  late String email;
  late String password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<UserCredential?> signIn(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  } catch (e) { 
    print(e);
  }
  return null;
}  
///////////////
  Future<void> saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  // Check if the user is already logged in
  // Future<bool> isLoggedIn() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('isLoggedIn') ?? false;
  // }
////////////////////////
  @override
  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    //  Check if the user is already logged in
  // isLoggedIn().then((loggedIn) {
  //   if (loggedIn) {
  //     Navigator.pushNamed(context, 'dashboard');
  //   }
  // });
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/openPage.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(color: Colors.blue[600], fontSize: 38, fontWeight: FontWeight.bold),
                ), 
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/openPage2.png'),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.62),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  email = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    return 'Please Enter your Email.';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 225, 239, 248),
                                  labelText: "Enter your Email",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 62, 37, 233)),

                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Color.fromARGB(255, 62, 37, 233),
                                  ),
                                  //hintText: 'Enter your email',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 62, 37, 233),
                                        width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 62, 37, 233),
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              TextFormField(
                                obscureText: obscure,
                                onChanged: (value) {
                                  password = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    return 'Please Enter your Password.';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 225, 239, 248),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obscure = !obscure;
                                      });
                                    },
                                    child: Icon(
                                        color: Color.fromARGB(255, 62, 37, 233),
                                        obscure
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                  ),
                                  labelText: "Enter your password.",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 62, 37, 233)),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color.fromARGB(255, 62, 37, 233),
                                  ),
                                  //hintText: 'Enter your password.',
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 62, 37, 233),
                                        width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 62, 37, 233),
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                ),
                              ),
                              SizedBox(
                               height: screenHeight * 0.04,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sign in',
                                    style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff4c505b),
                                    child: IconButton(
                                        color: Colors.white,
                                        onPressed: () async {
                                          final user = await signIn(email, password);
                                          // print(user);
                                          setState(() {
                                            showSpinner = true;
                                          });
                                          // if (!_formkey.currentState!
                                          //     .validate()) {
                                          //   return;
                                          // }
                                          // try {
                                          //   final user = await _auth
                                          //       .signInWithEmailAndPassword(
                                          //           email: email,
                                          //           password: password);
                                            final dataUser = await _firestore
                                                .collection('userData')
                                                .doc(email)
                                                .get();
                                            // setFCM(email);
                                             // print("hello world");
                                            // print(user.user!.displayName);
                                            if (user != null) {
                                              await saveLoginStatus();
                                              Navigator.pushNamed(
                                                context,
                                                'dashboard',
                                              );
                                            }
                                            
                                            else{
                                              setState(() {
                                              showSpinner = false;
                                            });
                                              showDialog(context: context, builder: (builder) {
                                                return AlertDialog(
                                                  title: Text("Error"),
                                                  content: Text("Email or password is incorrect"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text("Ok"),
                                                    ),
                                                  ],
                                                );
                                              });
                                            }
                                          },
                                          // } catch (e) {
                                          //   setState(() {
                                          //     showSpinner = false;
                                          //   });
                                          //   showDialog<String>(
                                          //       context: context,
                                          //       builder:
                                          //           (BuildContext context) =>
                                          //               worngDialgo(
                                          //                 text:
                                          //                     e.toString(),
                                          //                 type: "worng",
                                          //               ));
                                          //   print(e);
                                          // }
                                        // },
                                        icon: Icon(
                                          Icons.arrow_forward,
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'register');
                                    },
                                    child: Text(
                                      'Sign Up',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff4c505b),
                                          fontSize: 18),
                                    ),
                                    style: ButtonStyle(),
                                  ),
                                  // TextButton(
                                  //     onPressed: () {},
                                  //     child: Text(
                                  //       'Forgot Password',
                                  //       style: TextStyle(
                                  //         decoration: TextDecoration.underline,
                                  //         color: Color(0xff4c505b),
                                  //         fontSize: 18,
                                  //       ),
                                  //     )),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
