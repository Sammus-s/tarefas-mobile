import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/model/tarefa.dart';

class ListaTarefasPage extends StatefulWidget{
  @override
  _ListaTarefasPageState createState() => _ListaTarefasPageState();
}

class _ListaTarefasPageState extends State<ListaTarefasPage>{
  final tarefas = <Tarefa> [
    Tarefa(id: 1, descricao: "Tarefa1", prazo: DateTime.now()),
    Tarefa(id: 2, descricao: "Tarefa2"),
    Tarefa(id: 3, descricao: "Tarefa3"),
    Tarefa(id: 4, descricao: "Tarefa4"),
  ];

  var _ultimoId = 4;

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criaBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Nova Tarefa',
        child: Icon(Icons.add)
      ),
    );
  }

  AppBar _criarAppBar(){
    return AppBar(
      centerTitle: true,
      title: const Text("Tarefas"),
      actions: [IconButton(onPressed: (){}, icon: Icon(Icons.filter_list))],
    );
  }

  Widget _criaBody() {
    if (tarefas.isEmpty){
      return Center(
        child: Text(
            "Sem Tarefas Cadastradas",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
      );
    }

    return ListView.separated(
        itemCount: tarefas.length,
        itemBuilder: (BuildContext context, int index){
          final tarefa = tarefas[index];

          return ListTile(
            title: Text('${tarefa.id} - ${tarefa.descricao}'),
            subtitle: Text(tarefa.prazoFormatado.isNotEmpty ?'Prazo - ${tarefa.prazo}':'sem prazo cadastrado'),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider()
        );
  }
}
