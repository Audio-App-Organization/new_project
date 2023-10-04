import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Center(child: const Text("Login")),
    //   ),
    //   body: Center(
    //     child: Container(
    //       padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    //       child: Form(
    //         child: Column(
    //           children: <Widget>[
    //             TextField(
    //                 controller: emailController,
    //                 decoration: const InputDecoration(
    //                     border: OutlineInputBorder(),
    //                     labelText: "User Email"),
    //               ),
    //             SizedBox(height: 10.0),
    //             TextField(
    //               controller: passwordController,
    //               decoration: const InputDecoration(
    //                   border: OutlineInputBorder(),
    //                   labelText: "Password"),
    //               obscureText: true,
    //             ),
    //
    //             const SizedBox(height: 10.0),
    //             ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                   minimumSize: const Size(250, 50),
    //                   foregroundColor: Colors.deepPurple,
    //                   // Add transparent background
    //                   backgroundColor: Colors.white,
    //                   shape: RoundedRectangleBorder(
    //                       side: const BorderSide(color: Colors.deepPurple),
    //                       borderRadius: BorderRadius.circular(50))),
    //               child: const Text(
    //                 "Login",
    //                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    //               ),
    //               onPressed: signIn,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Login to your Account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: passwordController,
                          obscureText: passToggle,
                          decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    passToggle = !passToggle;
                                  });
                                },
                                child: Icon(passToggle
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Email";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: signIn,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(250, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't Have an Account ?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    /*Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )*/
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}
