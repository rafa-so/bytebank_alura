import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatefulWidget {
  final TextEditingController _controladorCampoNumeroConta =
  TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criando Transferência')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
                controlador: widget._controladorCampoNumeroConta,
                rotulo: "Número da Conta",
                dica: '0000'),
            Editor(
                controlador: widget._controladorCampoValor,
                rotulo: "Valor",
                dica: '0.00',
                icone: Icons.monetization_on),
            ElevatedButton(
                onPressed: () => _criaTransferencia(context),
                child: Text("Confirmar")),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(context) {
    final int? numeroConta = int.tryParse(widget._controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(widget._controladorCampoValor.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

  Editor(
      {required this.controlador,
      required this.rotulo,
      required this.dica,
      this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
      ),
    );
  }
}

class ListaTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencia> {
  final List<Transferencia> _transferencias = List<Transferencia>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Transferências"),
        ),
        body: ListView.builder(
          itemBuilder: (context, indice) {
            final transferencia = _transferencias[indice];
            return ItemTransferencia(transferencia);
          },
          itemCount: _transferencias.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final Future<Transferencia?> future =
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormularioTransferencia();
            }));
            future.then((transferenciaRecebida) {
              if (transferenciaRecebida != null) {
                setState(() {
                  _transferencias.add(transferenciaRecebida);
                });
              }
            });
          },
        child: Icon(Icons.add),
      )
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(this._transferencia.valor.toString()),
        subtitle: Text(this._transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia { valor: $valor, numeroConta: $numeroConta }';
  }
}
