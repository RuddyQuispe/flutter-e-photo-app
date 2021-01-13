import 'package:flutter/material.dart';
import 'package:flutter_e_photograph_app/src/libs/http.dart';
import 'package:flutter_e_photograph_app/src/pages/home_page.dart';
import 'package:flutter_e_photograph_app/src/pages/register_guest.dart';
import 'package:flutter_e_photograph_app/src/providers/UserGuest.dart';
import 'package:flutter_e_photograph_app/src/widgets/FadeAnimations.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  static final String routeName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password = "";
  @override
  Widget build(BuildContext context) {
    final userGuest = Provider.of<UserGuest>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/img/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: [
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('asset/img/light-1.png'))),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('asset/img/light-2.png'))),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('asset/img/clock.png'))),
                        ),
                      ),
                    ),
                    Positioned(
                      child: FadeAnimation(
                        1.6,
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text("Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    FadeAnimation(
                      1.8,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 254, 1),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]))),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                                onChanged: (value) {
                                  setState(() {
                                    this.email = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                                onChanged: (value) {
                                  setState(() {
                                    this.password = value;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                      child: FadeAnimation(
                        2,
                        Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      color: Color.fromRGBO(143, 148, 254, 1),
                      onPressed: () async {
                        bool a = await signIn(userGuest);
                        print("result $a");
                        if (await signIn(userGuest)) {
                          Navigator.pushNamed(context, HomePage.routeName);
                        }
                      },
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    FadeAnimation(
                        1.5,
                        InkWell(
                          child: Text(
                            "Don't have an account?",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () => Navigator.pushNamed(
                              context, RegisterGuest.routeName),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> signIn(UserGuest userGuest) async {
    try {
      HTTP http = new HTTP();
      var response = await http.post('/api/auth/signin_guest',
          {"email": this.email, "password": this.password});
      if (response["token"] != null) {
        Toast.show("${response["message"]}  ${response["name"]}!", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        print("aqui 1");
        userGuest.email = this.email;
        print("aqui 2");
        // userGuest.password = this.password;
        print("aqui 3");
        userGuest.name = response["name"];
        print("aqui 4");
        userGuest.token = response["token"];
        print("aqui 5");
        print("user name: " + response["name"]);
        print("aqui 6");
        setState(() {});
        return true;
      } else {
        Toast.show(response["message"], context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        return false;
      }
    } catch (e) {
      print("Error in signIn method: $e");
      return false;
    }
  }
}
