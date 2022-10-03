import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:servicios/helpers/mostrar_alerta.dart';

import 'package:servicios/providers/auth_provider.dart';
import 'package:servicios/providers/ui_provider.dart';
import 'package:servicios/providers/usuario_form_provider.dart';
import 'package:servicios/widgets/fondo_usuario.dart';
import 'package:servicios/widgets/progress_circular.dart';


class UsuarioPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        FondoUsuario(),
        _IconoNombre(),
        ChangeNotifierProvider(
          create: (_) => UsuarioFormProvider(),
          child: _FormularioUsuario() 
        ),
        if(uiProvider.isLoading)
          Positioned(bottom: 30, left: size.width * 0.5 - 30, child: ProgressCircular())
      ],
    );
  }
}


class _FormularioUsuario extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    final usuario = authProvider.usuario;
    final usuarioForm = Provider.of<UsuarioFormProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);


    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: usuarioForm.usuarioFormKey,
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
                    readOnly: true,
                    initialValue: usuario.nombre,
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow> [
                      BoxShadow(spreadRadius: 1, color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
                    ]
                  ),
                  child: TextFormField(
                    readOnly: true,
                    initialValue: usuario.numero,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      hintText: '   Numero ',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.phone_iphone_rounded, color: Colors.orange),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              FadeIn(
                delay: Duration(milliseconds: 500),
                duration: Duration(milliseconds: 500),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow> [
                      BoxShadow(spreadRadius: 1, color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
                    ]
                  ),
                  child: TextFormField(
                    obscureText: true,
                    initialValue: '',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      hintText: '   Nueva Contraseña',
                      prefixIcon: Icon(Icons.lock, color: Colors.orange),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (value) => usuarioForm.password = value,
                    validator: (value) {
                      if(value != null && value.length >= 4) return null;
                      return 'Debe de ser mayor o igual a 4 caracteres';
                    },
                    // maxLines: 4,
                  ),
                ),
              ),
      
              SizedBox(height: 40),
      
              FadeInRight(
                delay: Duration(milliseconds: 700),
                duration: Duration(milliseconds: 500),
                child: TextButton(
                  onPressed: uiProvider.isLoading ? null : () async {

                    if(usuarioForm.isValidForm()) {
                      FocusScope.of(context).unfocus();
                      uiProvider.isLoading = true;
                      // Peticion http
                      final usuarioOk = await authProvider.actualizarUsuario( usuario.nombre, usuarioForm.password.toString().trim(), usuario.uid);
                      uiProvider.isLoading = false;
                      if(usuarioOk) {
                        await mostrarAlerta(context, 'El usuario se actualizo', 'El usuario se actualizo correctamente');
                      } else {
                        // mostrar Alerta
                        mostrarAlerta(context, 'Numero repetido', 'El numero ya esta registrado en otra cuenta');
                      }
                    
                    }
                  }, 
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
                        ]
                      ),
                    ),
                    child: Text(uiProvider.isLoading ? 'Espere...' : 'Actualizar', style: TextStyle(color: Colors.white, fontSize: 21, fontFamily: 'LobsterTwo'))
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
    final authProvider = Provider.of<AuthProvider>(context);
    final usuario = authProvider.usuario;

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
            child: Text(usuario.nombre, style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'TenaliRamakrishna'))
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