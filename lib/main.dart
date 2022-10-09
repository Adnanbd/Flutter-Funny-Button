import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Funny Button',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  bool isHover = false;
  bool isLeft = false;
  bool isRight = false;
  bool isCenter = true;
  double offset = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 43, 40, 40),
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 300,
                width: 500,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Email"),
                        controller: email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: pass,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: "Password"),
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password Should be minimum 6 character';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 5000),
                bottom: 10,
                left: isLeft && !isCenter ? 10 : null,
                right: isRight && !isCenter ? 10 : null,
                child: InkWell(
                  onTap: () {
                    print("Tapped");
                  },
                  onHover: (value) {
                    print("HOVERED");
                    setState(() {
                      //isHover = !isHover;
                      if (_formKey.currentState!.validate()) {
                      } else {
                        if (!isLeft && isCenter) {
                          isLeft = true;
                          isCenter = false;
                          isRight = false;
                        } else if (isLeft && !isCenter) {
                          isLeft = false;
                          isCenter = false;
                          isRight = true;
                        } else if (isRight && !isCenter) {
                          isLeft = false;
                          isCenter = true;
                          isRight = false;
                        }
                      }
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    decoration: BoxDecoration(
                        color: isHover ? Colors.red : Colors.indigo,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: const Text("Login"),
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
