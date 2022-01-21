import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:servicios/widgets/fondo_usuario.dart';


class UsuarioPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        FondoUsuario(),
        _IconoNombre(),
        _FormularioUsuario(),
      ],
    );
  }
}


class _FormularioUsuario extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: size.height * 0.35),
      
              // Campo de Texto
              FadeIn(
                delay: Duration(milliseconds: 300),
                duration: Duration(milliseconds: 500),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow> [
                      BoxShadow(spreadRadius: 1, color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
                    ]
                  ),
                  child: TextFormField(
                    initialValue: 'Antonio Aguilar',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      hintText: '   Nombre',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person, color: Colors.orange),
                    ),
                  ),
                ),
              ),
      
              SizedBox(height: 30),
      
              // Descripcion
              FadeIn(
                delay: Duration(milliseconds: 400),
                duration: Duration(milliseconds: 500),
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow> [
                      BoxShadow(spreadRadius: 1, color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
                    ]
                  ),
                  child: TextFormField(
                    initialValue: '9821144162',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      hintText: '   Numero ',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.phone_iphone_rounded, color: Colors.orange),
                    ),
                    // maxLines: 4,
                  ),
                ),
              ),

              SizedBox(height: 30),

              FadeIn(
                delay: Duration(milliseconds: 500),
                duration: Duration(milliseconds: 500),
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow> [
                      BoxShadow(spreadRadius: 1, color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
                    ]
                  ),
                  child: TextFormField(
                    obscureText: true,
                    initialValue: 'loquesea',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      hintText: '   Contraseña',
                      prefixIcon: Icon(Icons.lock, color: Colors.orange),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    // maxLines: 4,
                    
                  ),
                ),
              ),
      
              SizedBox(height: 40),
      
              FadeInRight(
                delay: Duration(milliseconds: 700),
                duration: Duration(milliseconds: 500),
                child: TextButton(
                  onPressed: () {}, 
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
                      ],
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffFF9460),
                          Color(0xffFF6D2A),
                          // Color.fromRGBO(55, 56, 79, 1),
                          // Color.fromRGBO(61, 113, 133, 1),
                          // Color.fromRGBO(247, 204, 129, 1),
                          // Color.fromRGBO(222, 113, 82, 1),
                        ]
                      ),
                    ),
                    child: Text('Actualizar', style: TextStyle(color: Colors.white, fontSize: 21, fontFamily: 'LobsterTwo'))
                  ),
                ),
              ),

              SizedBox(height: 30),
            ],
          )
        ),
      ),
    );
  }
}


class _IconoNombre extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.07),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          FadeInDown(
            delay: Duration(milliseconds: 400),
            duration: Duration(milliseconds: 500),
            child: Icon(Icons.person_pin, color: Colors.white, size: 60)
          ),
          FadeInDown(
            delay: Duration(milliseconds: 550),
            duration: Duration(milliseconds: 500),
            child: Text('Antonio Aguilar', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'TenaliRamakrishna'))
          ),
          SizedBox(height: 50),
          FadeInLeft(
            delay: Duration(milliseconds: 500),
            duration: Duration(milliseconds: 500),
            child: Text('Perfil', style: TextStyle(color: Color(0xffAF5700), fontSize: 30, fontFamily: 'LobsterTwo', fontWeight: FontWeight.bold))
          ),
        ],
      ),
    );
  }
}