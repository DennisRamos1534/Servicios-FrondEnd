import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:servicios/helpers/mostrar_alerta.dart';

import 'package:servicios/models/reporte.dart';
import 'package:servicios/providers/auth_provider.dart';

class ItemListaHistorial extends StatelessWidget {

  // final String titulo;
  final Reporte reporte;

  const ItemListaHistorial(this.reporte);

  @override
  Widget build(BuildContext context) {

    final auhtProvider = Provider.of<AuthProvider>(context);

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showCupertinoDialog(
          context: context, 
          builder: (_) => CupertinoAlertDialog(
            title: Text('Eliminar Reporte', style: TextStyle(fontSize: 20, fontFamily: 'TenaliRamakrishna')),
            content: Text('¿Deseas eliminar el reporte?', style: TextStyle(fontSize: 15)),
            actions: [
              TextButton(onPressed: () { Navigator.of(context).pop(false); }, child: Text('No')),
              TextButton(onPressed: () async { 
                Navigator.of(context).pop(true); 
                // aqui se hace la peticion de la api para borrar el reporte
                final borradoOk = await auhtProvider.borrarReporte(reporte.uid);
                if(borradoOk) {
                  await mostrarAlerta(context, 'Eliminado', 'El reporte se borro correctamente');
                } else {
                  await mostrarAlerta(context, 'Error', 'No se pudo borrar el reporte, intente de nuevo');
                }
              }, child: Text('Si')),
            ],
          )
        );
      },
      child: FadeInLeft(
        delay: Duration(milliseconds: 400),
        duration: Duration(milliseconds: 500),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
          
                Color(0xffD291BC),
                Color(0xffFEC8D8)
              ]
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 5, offset: Offset(0, 5))
            ]
          ),
          child: _CustomItemListTitle(this.reporte),
        ),
      ),
    );
  }
}

class _CustomItemListTitle extends StatelessWidget {

  // final String titulo;
  final Reporte reporte;
  const _CustomItemListTitle(this.reporte);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.circle_rounded, color: reporte.estado ? Colors.green : Colors.red),
      title: Text(this.reporte.tipoServicio, style: TextStyle(fontSize: 22, fontFamily: 'TenaliRamakrishna')),
      subtitle: Text(this.reporte.direccion, style: TextStyle(fontSize: 14)),
      dense: true,
      trailing: imagen(this.reporte.urlImagen),
    );
  }
}

Widget imagen(url) {
  if(url == 'no-imagen') {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image(
        image: AssetImage('assets/no-image.png'),
        width: 55,
        height: 55,
        fit: BoxFit.cover,
      ),
    );
  } else {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'), 
        image: NetworkImage(url),
        width: 55,
        height: 55,
        fit: BoxFit.cover,
      ),
    );
  }
}