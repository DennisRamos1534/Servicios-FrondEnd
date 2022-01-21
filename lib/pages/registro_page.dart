import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import 'package:servicios/helpers/mostrar_alerta.dart';

import 'package:servicios/providers/form_provider.dart';
import 'package:servicios/providers/auth_provider.dart';
import 'package:servicios/providers/socket_service.dart';

class RegistroPage extends StatelessWidget {

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
    final registroProvider = Provider.of<LoginFormProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final socketService = Provider.of<SocketService>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.43),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              key: registroProvider.loginFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [

                  FadeIn(
                    delay: Duration(milliseconds: 100),
                    duration: Duration(seconds: 1),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3, bottom: 3, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow> [
                          BoxShadow(spreadRadius: 3, color: Colors.black12, blurRadius: 10)
                        ]
                      ),
                      child: TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          hintText: '   Nombre de Usuario',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (value) => registroProvider.usuario = value,
                        validator: (value) {
                          return value!.trim().length >  3 ? null : 'Debe de ser mayor a 3 letras';
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  FadeIn(
                    delay: Duration(milliseconds: 200),
                    duration: Duration(seconds: 1),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3, bottom: 3, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow> [
                          BoxShadow(spreadRadius: 3, color: Colors.black12, blurRadius: 10)
                        ]
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          hintText: '   Número',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (value) => registroProvider.numero = value,
                        validator: (value) {
                          if(value != null && value.length == 10) return null;
                          return 'Debe de tener 10 numeros';
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  FadeIn(
                    delay: Duration(milliseconds: 300),
                    duration: Duration(seconds: 1),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3, bottom: 3, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow> [
                          BoxShadow(spreadRadius: 3, color: Colors.black12, blurRadius: 10)
                        ]
                      ),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          hintText: '   Contraseña',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (value) => registroProvider.password = value,
                        validator: (value) {
                          if(value != null && value.length >= 6) return null;
                          return 'Debe de ser mayor o igual a 6 caracteres';
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 40),

                  GestureDetector(
                    onTap: authProvider.autenticando ? null : () async {

                      if(registroProvider.isValidForm()) {
                        final registroOk = await authProvider.registro(registroProvider.usuario.trim(), registroProvider.numero.toString().trim(), registroProvider.password.trim());
                        if(registroOk == true) {
                          // Conectar al socket Server
                          socketService.connect();
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          mostrarAlerta(context, 'Registro Incorrecto', registroOk);
                        }
                        // Navigator.pushNamed(context, 'home');
                        // FocusScope.of(context).unfocus();
                      }
                    },
                    child: FadeInUpBig(
                      delay: Duration(milliseconds: 800),
                      duration: Duration(milliseconds: 600),
                      child: Container(
                        width: 100,
                        height: 100,
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

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('¿Ya tienes una cuenta?'),
                      // SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, 'login');
                          Navigator.pushReplacementNamed(context, 'login');
                        }, 
                        child: Text('Login', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
        SizedBox(height: size.height * 0.15),
        
        Center(
          child: FadeInDown(
            delay: Duration(milliseconds: 1200),
            duration: Duration(milliseconds: 800),
            child: Image(
              image: AssetImage('assets/logo.png'),
              width: size.width * 0.25,
            ),
          ),
        ),

        SizedBox(height: size.height * 0.02),

        FadeInLeft(
          delay: Duration(milliseconds: 500),
          duration: Duration(milliseconds: 500),
          child: Text('Registro', style: TextStyle(fontSize: 30, fontFamily: 'Pacifico'))
        ),
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
        // color: Color.fromRGBO(255, 255, 255, 0.2),
      ),
    );
  }
}
