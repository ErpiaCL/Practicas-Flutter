import 'package:firebase_auth/firebase_auth.dart'hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart' ;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AuthGate extends StatelessWidget {
 const AuthGate({super.key});

 @override
 Widget build(BuildContext context) {
   return StreamBuilder<User?>(
     stream: FirebaseAuth.instance.authStateChanges(),
     builder: (context, snapshot) {
       if (!snapshot.hasData) {
         return SignInScreen(

                  providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD),
            ],

           headerBuilder: (context, constraints, shrinkOffset) {
             return Padding(
               padding: const EdgeInsets.all(20),
               child: AspectRatio(
                 aspectRatio: 1,
                 child: Image.asset('erpia.png'),
               ),
             );
           },
           subtitleBuilder: (context, action) {
             return Padding(
               padding: const EdgeInsets.symmetric(vertical: 8.0),
               child: action == AuthAction.signIn
                   ? const Text('Bienvenido a ERP.IA, Inicia Sesión!')
                   : const Text('Bienvenido a ERP.IA, Registrate!'),
             );
           },
           footerBuilder: (context, action) {
             return const Padding(
               padding: EdgeInsets.only(top: 16),
               child: Text(
                 'Al iniciar sesión, estas aceptando nuestros terminos y condiciones',
                 style: TextStyle(color: Colors.grey),
               ),
             );
           },
           sideBuilder: (context, shrinkOffset) {
             return Padding(
               padding: const EdgeInsets.all(20),
               child: AspectRatio(
                 aspectRatio: 1,
                 child: Image.asset('erpia.png'),
               ),
             );
           },
         );
       }

       return const HomeScreen();
     },
   );
 }
}