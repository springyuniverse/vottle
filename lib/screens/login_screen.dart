import 'package:flutter/material.dart';
import 'package:vottle/widgets/mainbutton.dart';
import 'package:vottle/services/auth.dart';
import 'package:vottle/widgets/formarea.dart';


class LoginScreen extends StatelessWidget {

  AuthService authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(

    backgroundColor: Color(0xff240043),
      body: Center(
        child: Column(

          children: <Widget>[
//            Image.asset('img.png'),
            SizedBox(height: 100,),
//            Image.asset('logo.png'),
            Text('Vottle',style: TextStyle(color:Colors.white,fontSize: 30),),
            SizedBox(height: 40,),
            FormArea(hintText: 'Email',icon: Icon(Icons.verified_user),myController: emailController,),
            FormArea(hintText: 'Password',icon: Icon(Icons.lock),myController: passwordController,),

            MainButton(title: "Login",onClick: () async {

//              var user = authService.signInAnon();
            print(emailController.text +' ' + passwordController.text);
              var user = await authService.signInWithEmail(emailController.text, passwordController.text);
              print(user.uid);
              if(user!=null) {
                Navigator.pushNamed(context, '/topics');
              } else if(user == null) {
                Navigator.pushNamed(context, '/register');
              }
            },),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('You have no account yet? ',style: TextStyle(color: Colors.white),),
                GestureDetector(
                  onTap: (){

                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text('Sign up',style: TextStyle(color: Color(0xffFF6B76)),),
                )

              ],
            )





          ],
        ),
      ),

    );
  }
}

