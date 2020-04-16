import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text string state 
  String email = '';
  String password = '';
  String error = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.brown[100],
       appBar: AppBar(
         backgroundColor: Colors.brown[400],
         elevation: 0,
         title: Text("Signup to Brew Crew"),
         actions: <Widget>[
           FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              }, 
              icon: Icon(Icons.person), 
              label: Text('Sign In')
            )
         ],
       ),
       body: Container(
         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
         child: Form(
           key: _formKey,
           child: Column(
             children: <Widget>[
               SizedBox(height: 20,),
               TextFormField(
                 decoration: textInputDecoration.copyWith(hintText: 'Email'),
                 validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                 onChanged: (val) {
                   setState(() => email = val);
                 },
               ),
               SizedBox(height: 20,),
               TextFormField(
                 obscureText: true,
                 decoration: textInputDecoration.copyWith(hintText: 'Password'),
                 validator: (val) => val.length < 6 ? 'Enter a password with 6+ characters' : null,
                 onChanged: (val) {
                   setState(() => password = val);
                 },
               ),
               SizedBox(height: 20,),
               RaisedButton(
                 color: Colors.pink[400],
                 child: Text(
                   "Register",
                   style: TextStyle(color: Colors.white),
                 ),
                 onPressed: () async {
                   if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() => error = 'Please type in a valid Email');
                      }
                   }
                 },
               ),
               SizedBox(height: 12,),
               Text(
                 error,
                 style: TextStyle(
                   color: Colors.red,
                   fontSize: 14
                   ),
              ),
             ],
           ),
         ),
       ),
    );
  }
}