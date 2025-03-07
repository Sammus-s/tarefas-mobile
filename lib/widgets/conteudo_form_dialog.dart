import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/model/tarefa.dart';
import 'package:intl/intl.dart';

class ConteudoFormDialog extends StatefulWidget{
  final Tarefa? tarefaAtual;

  ConteudoFormDialog({Key? key, this.tarefaAtual}) : super(key: key);

  @override
  ConteudoFormDialogState createState() => ConteudoFormDialogState();
}

class ConteudoFormDialogState extends State<ConteudoFormDialog>{
  final formKey = GlobalKey<FormState>();
  final descricaoController = TextEditingController();
  final prazoController = TextEditingController();
  final _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState(){
    super.initState();
    if(widget.tarefaAtual != null){
      descricaoController.text = widget.tarefaAtual!.descricao;
      prazoController.text = widget.tarefaAtual!.prazoFormatado;
    }
  }

  @override
  Widget build (BuildContext context){
    return Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
              validator: (String? valor){
                if (valor == null || valor.isEmpty){
                  return "o campo descrição é obrigatório";
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: prazoController,
              decoration: InputDecoration(
                labelText: 'Prazo',
                prefixIcon: IconButton(icon: Icon(Icons.calendar_month), onPressed: _abrirCalendario),
                suffixIcon: IconButton(onPressed: ()=>prazoController.clear(), icon: Icon(Icons.close)),
              ),
              readOnly: true,
            )
          ],
        ),
    );
  }

  bool dadosValidados() => formKey.currentState?.validate() == true;

  void _abrirCalendario(){
    final dataFormatada = prazoController.text;
    var data = DateTime.now();
    if (dataFormatada.isNotEmpty){
      data = _dateFormat.parse(dataFormatada);
    };
    
    showDatePicker(
        context: context,
        initialDate: data,
        firstDate: data.subtract(Duration(days: 365*5)),
        lastDate: data.add(Duration(days: 5*365))
    ).then((DateTime? dataSelecionada){
      if (dataSelecionada != null) {
        setState(() {
          prazoController.text = _dateFormat.format(dataSelecionada);
        });
      }
    });
  }

  Tarefa get novaTarefa => Tarefa(
      id: widget.tarefaAtual!.id ?? 0,
      descricao: descricaoController.text,
      prazo: prazoController.text.isEmpty ? null : _dateFormat.parse(prazoController.text));
}