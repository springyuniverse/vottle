import 'package:flutter/material.dart';
import 'package:vottle/widgets/mainbutton.dart';
import 'package:vottle/services/auth.dart';
import 'package:vottle/widgets/formarea.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class RegistrationScreen extends StatefulWidget {

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  AuthService authService = AuthService();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final emailController = TextEditingController();

  Country _selected;

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
            FormArea(hintText: 'Username',icon: Icon(Icons.verified_user),myController: usernameController,),
            FormArea(hintText: 'Email',icon: Icon(Icons.verified_user),myController: emailController,),
            FormArea(hintText: 'Password',icon: Icon(Icons.verified_user),myController: passwordController,),
            FormArea(hintText: 'Confirm Password',icon: Icon(Icons.verified_user),myController: confirmPasswordController,),
            SizedBox(height: 20,),
            CountryPicker(
              nameTextStyle: TextStyle(color: Colors.white),
              onChanged: (Country country){

                setState(() {
                  _selected = country;

                });
              },
              selectedCountry: _selected,

            ),
            SizedBox(height: 20,),

            MainButton(title: "Register",onClick: () async {


              var user = authService.signUpWithEmail(emailController.text, passwordController.text,usernameController.text,_selected.name);

              if(user!=null) {
                Navigator.pushNamed(context, '/');
              } else {
                Navigator.pushNamed(context, '/register');

              }

            },),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Already have an account ',style: TextStyle(color: Colors.white),),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/');

                  },
                  child: Text('Sign in',style: TextStyle(color: Color(0xffFF6B76)),),
                )

              ],
            )








          ],
        ),
      ),

    );
  }
}

