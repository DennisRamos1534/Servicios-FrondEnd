import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animate_do/animate_do.dart';

class ItemListaHistorial extends StatelessWidget {

  final String titulo;

  const ItemListaHistorial(this.titulo);

  @override
  Widget build(BuildContext context) {
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
              TextButton(onPressed: () { Navigator.of(context).pop(true); }, child: Text('Si')),
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
                // Color(0xffD291BC),
                // Color(0xff957DAD),
          
                // Color(0xffFA5F49),
                // Color(0xffF9A59A)
          
                Color(0xffD291BC),
                Color(0xffFEC8D8)
              ]
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 5, offset: Offset(0, 5))
            ]
          ),
          child: _CustomItemListTitle(this.titulo),
        ),
      ),
    );
  }
}

class _CustomItemListTitle extends StatelessWidget {

  final String titulo;

  const _CustomItemListTitle(this.titulo);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.circle_rounded, color: Colors.green),
      title: Text(this.titulo, style: TextStyle(fontSize: 22, fontFamily: 'TenaliRamakrishna')),
      subtitle: Text('Calle 14 No. 89A Col. Centro', style: TextStyle(fontSize: 14)),
      dense: true,
      trailing: Icon(Icons.arrow_back_ios),
    );
  }
}