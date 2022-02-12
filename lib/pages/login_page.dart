import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import 'package:servicios/helpers/mostrar_alerta.dart';

import 'package:servicios/providers/form_provider.dart';
import 'package:servicios/providers/auth_provider.dart';
import 'package:servicios/providers/socket_service.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _FondoColor(),
          _Logo(),
          ChangeNotifierProvider(create: (_) => LoginFormProvider(), 
            child: _Formulario()
          ),
        ],
      ),
    );
  }
}

class _Formulario extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final loginForm = Provider.of<LoginFormProvider>(context);
    final authProvier = Provider.of<AuthProvider>(context);
    final socketService = Provider.of<SocketService>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.39),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              key: loginForm.loginFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [

                  FadeIn(
                    duration: Duration(seconds: 1),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 4, bottom: 3, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow> [
                          BoxShadow(spreadRadius: 3, color: Colors.black12, blurRadius: 10)
                        ]
                      ),
                      child: TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          hintText: '   Numero',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (value) => loginForm.usuario = value,
                        validator: (value) {
                          return value!.trim().length >  3 ? null : 'Debe de ser mayor a 3 letras';
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  FadeIn(
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3, bottom: 3, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow> [
                          BoxShadow(spreadRadius: 3, color: Colors.black12, blurRadius: 10)
                        ]
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          hintText: '   Contraseña',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (value) => loginForm.password = value,
                        validator: (value) {
                          if(value != null && value.length >= 6) return null;
                          return 'Debe de ser mayor o igual a 6 caracteres';
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 35),

                  GestureDetector(
                    onTap: authProvier.autenticando ? null : () async {
                      
                      if(loginForm.isValidForm()) {
                        FocusScope.of(context).unfocus();
                        final loginOk = await authProvier.login(loginForm.usuario.trim(), loginForm.password.toString().trim());
                        if(loginOk) {
                          // Conectar a socket server
                          socketService.connect();
                          // Navegar a otra pantalla home
                          Navigator.pushReplacementNamed(context, 'home');

                        } else {
                          // mostrar Alerta
                          mostrarAlerta(context, 'Login Incorrecto', 'El numero o contraseña son incorrectos');
                        }
                  
                      }
                    },
                    child: FadeInUp(
                      delay: Duration(milliseconds: 600),
                      child: Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 0, 0, 1),
                              Color.fromRGBO(68, 68, 68, 1)
                            ]
                          )
                        ),
                                      
                        child: Icon(Icons.arrow_forward, color: Colors.white, size: 40),
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.04),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('¿No tienes una cuenta?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'registro');
                        }, 
                        child: Text('Registrate', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      )
                      
                    ],
                  ),

                  SizedBox(height: 40),

                ],
              )
            )
          )
        ],
      )
    );
  }
}

class _Logo extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Column(

      children: [
        SizedBox(height: size.height * 0.13),
        
        Center(
          child: FadeInDown(
            delay: Duration(seconds: 1),
            child: Image(
              image: AssetImage('assets/logo.png'),
              height: size.height * 0.15,
            ),
          ),
        ),

        SizedBox(height: 5),

        FadeInRight(
          duration: Duration(milliseconds: 500),
          child: Text('Login', style: TextStyle(fontSize: 23, fontFamily: 'Pacifico'))
        )
      ],
    );
  }
}

class _FondoColor extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container( 
      width: double.infinity,
      height: double.infinity,  
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            // Colors.red,
            Color.fromRGBO(205, 205, 205, 1),
            Color.fromRGBO(254, 254, 254, 1)
          ],
        )
        
      ),

      child: Stack(
        children: [
          Positioned(child: _Circulo(), top: -50, left: -140,),
          Positioned(child: _Circulo(), top: -100, right: -190,),
          
        ],
      ),
    );
  }
}

class _Circulo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(300),
        color: Colors.white54,
      ),
    );
  }
}
