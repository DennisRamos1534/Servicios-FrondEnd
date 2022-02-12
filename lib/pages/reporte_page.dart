import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animate_do/animate_do.dart';

import 'package:servicios/providers/auth_provider.dart';
import 'package:servicios/providers/reporte_form_provider.dart';
import 'package:servicios/providers/socket_service.dart';
import 'package:servicios/providers/ui_provider.dart';

import 'package:servicios/helpers/mostrar_alerta.dart';
import 'package:servicios/widgets/forma_fondo.dart';
import 'package:servicios/widgets/imagen_reporte.dart';
import 'package:servicios/widgets/progress_circular.dart';


class ReportePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final servicio = ModalRoute.of(context)?.settings.arguments ?? Icons.person;
    final size = MediaQuery.of(context).size;
    final uiProvider = Provider.of<UiProvider>(context);
  
    return Scaffold(
      body: Stack(
        children: [
          _FondoReporte(),
          _FormularioReporte(servicio),

          if(uiProvider.isLoading)
            Positioned(bottom: 200, left: size.width * 0.5 - 50, child: ProgressCircular())
        ],
      ),
    );
  }
}

class _FormularioReporte extends StatelessWidget {

  final servicio;

  const _FormularioReporte(this.servicio);

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ImagenReporte(),
                Positioned(
                  top: 60,
                  left: 20,
                  child: FadeInLeft(
                    delay: Duration(milliseconds: 300),
                    child: IconButton(
                      onPressed: () => {
                        // vaciar la imagen 
                        uiProvider.imagePath = '',
                        Navigator.of(context).pop()
                      }, 
                      icon: Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white)
                    ),
                  )
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: FadeInRight(
                    delay: Duration(milliseconds: 300),
                    child: IconButton(
                      onPressed: () async {
                        final ImagePicker pickerCamara = new ImagePicker();
                        final XFile? pickedFileCamara = await pickerCamara.pickImage(source: ImageSource.camera, imageQuality: 30);
                      
                        if(pickedFileCamara == null) {
                          uiProvider.imagePath = '';
                          return;
                        }

                        uiProvider.imagePath = pickedFileCamara.path;
                        uiProvider.selectedImage(pickedFileCamara.path);
                      }, 
                      icon: Icon(Icons.camera_alt, size: 40, color: Colors.white)
                    ),
                  )
                ),

                //// galeria
                Positioned(
                  top: 120,
                  right: 20,
                  child: FadeInRight(
                    delay: Duration(milliseconds: 300),
                    child: IconButton(
                      onPressed: () async {
                        final ImagePicker pickerGaleria = new ImagePicker();
                        final XFile? pickedFileGaleria = await pickerGaleria.pickImage(source: ImageSource.gallery, imageQuality: 30);
                      
                        if(pickedFileGaleria == null) {
                          uiProvider.imagePath = '';
                          return;
                        }

                        uiProvider.imagePath = pickedFileGaleria.path;
                        uiProvider.selectedImage(pickedFileGaleria.path);
                      }, 
                      icon: Icon(Icons.image, size: 40, color: Colors.white)
                    ),
                  )
                ),
              ],
            ),

            ChangeNotifierProvider(
              create: (_) => ReporteFormProvider(),
              child: _ItemForm(this.servicio)
            ),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _ItemForm extends StatelessWidget {

  final servicio;

  const _ItemForm(this.servicio);

  @override
  Widget build(BuildContext context) {

    final reporteForm = Provider.of<ReporteFormProvider>(context);
    final socketService = Provider.of<SocketService>(context);
    final uiProvider = Provider.of<UiProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final usuario = authProvider.usuario;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Form(
        key: reporteForm.reporteFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 20),

            // Text(servicio, style: TextStyle(fontSize: 18, color: Color.fromRGBO(222, 113, 82, 1))),

            SizedBox(height: 20),

            // Campo de Texto
            FadeIn(
              delay: Duration(milliseconds: 400),
              duration: Duration(seconds: 1),
              child: Container(
                padding: EdgeInsets.only(top: 3, left: 3, bottom: 3, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow> [
                    BoxShadow(spreadRadius: 1, color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
                  ]
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: '   Dirección ',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (value) => reporteForm.direccion = value,
                  validator: (value) {
                    return value!.trim().length >  5 ? null : 'Debe de ser mayor a 5 letras';
                  },
                ),
              ),
            ),

            SizedBox(height: 20),

            // Descripcion
            FadeIn(
              delay: Duration(milliseconds: 600),
              duration: Duration(seconds: 1),
              child: Container(
                padding: EdgeInsets.only(top: 3, left: 3, bottom: 3, right: 20),
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow> [
                    BoxShadow(spreadRadius: 1, color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
                  ]
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: '   Descripcion ',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (value) => reporteForm.descripcion = value,
                  validator: (value) {
                    return (value!.trim().length >  5) ? null : 'Debe de ser mayor a 5 letras';
                  },
                  maxLines: 4,
                ),
              ),
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(this.servicio.icon, size: 70, color: Color.fromRGBO(222, 113, 82, 1)),
                
                TextButton(
                  onPressed: uiProvider.isLoading ? null : () async {
                    if(!reporteForm.isValidForm()) return;
                    FocusScope.of(context).unfocus();
                    uiProvider.isLoading = true;
                    // cargar imagen en cloudinary
                    final String? imageUrl = await uiProvider.cargarImagen(); // Url de la imagen para subir a Mongo
                    // guardar info en mongo
                    final reporte = await authProvider.reporte(usuario.nombre, usuario.numero, imageUrl!, reporteForm.direccion.trim(), reporteForm.descripcion.trim(), this.servicio.nombre);
                    // final bool reporte = await authProvider.reporte(usuario.nombre, usuario.numero, imageUrl!, reporteForm.direccion.trim(), reporteForm.descripcion.trim(), this.servicio.nombre);
                    uiProvider.isLoading = false;
                    
                    if(reporte == false) {
                      mostrarAlerta(context, 'Algo salio Mal', 'Vuelva a intentarlo, hubo algun problema de conexion y no se pudo enviar el reporte');
                    }

                    // Enviar por socket de la info
                    socketService.emit('prueba', {
                      'nombre': usuario.nombre,
                      'numero': usuario.numero,
                      'urlImagen': imageUrl,
                      'direccion': reporteForm.direccion.trim(),
                      'descripcion': reporteForm.descripcion.trim(),
                      'tipoServicio': this.servicio.nombre,
                      'eliminado': false,
                      'estado': false,
                      'uid': reporte
                    });

                    // Mostrar Alerta de enviado
                    await mostrarAlerta(context, 'Enviado', 'El reporte se envio correctamente');
                    uiProvider.imagePath = '';
                    Navigator.pushReplacementNamed(context, 'home');

                  }, 
                  child: FadeInRight(
                    delay: Duration(milliseconds: 800),
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
                        ],
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(55, 56, 79, 1),
                            Color.fromRGBO(61, 113, 133, 1),
                          ]
                        ),
                      ),
                      child: Text(uiProvider.isLoading ? 'Espere...' : 'Enviar Reporte', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'LobsterTwo'))
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}


class _FondoReporte extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(247, 204, 129, 1),
            Color.fromRGBO(252, 230, 185, 1)
          ]
        )
      ),
      child: FormasFondo(),
    );
  }
}
