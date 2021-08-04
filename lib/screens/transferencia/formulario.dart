import 'package:flutter/material.dart';
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';

const _tituloAppBar = 'Criando Transferência';
const _rotuloConta = "Número da Conta";
const _dicaConta = '0000';

const _rotuloValor = "Valor";
const _dicaValor = '0.00';

const _rotuloBotao = 'Confirmar';

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
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
                controlador: widget._controladorCampoNumeroConta,
                rotulo: _rotuloConta,
                dica: _dicaConta),
            Editor(
                controlador: widget._controladorCampoValor,
                rotulo: _rotuloValor,
                dica: _dicaValor,
                icone: Icons.monetization_on),
            ElevatedButton(
                onPressed: () => _criaTransferencia(context),
                child: Text(_rotuloBotao)),
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