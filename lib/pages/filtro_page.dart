import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas_si7/model/tarefa.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FiltroPage extends StatefulWidget{
  static const ROUTE_NAME = '/filtro';
  static const CHAVE_CAMPO_ORDENACAO = 'campoOrdenacao';
  static const CHAVE_FILTRO_DESCRICAO = 'filtroDescricao';
  static const USAR_ORDEM_DECRESCENTE = 'usarOrdemDecrescente';

  @override
  _FiltroPageState createState() => _FiltroPageState();
}

class _FiltroPageState extends State<FiltroPage>{

  final camposParaOrdenacao = {
    Tarefa.CAMPO_ID: 'Código',
    Tarefa.CAMPO_DESCRICAO: 'Descrição',
    Tarefa.CAMPO_PRAZO: 'Prazo'
  };

  late final SharedPreferences prefs;
  String campoOrdenacao = Tarefa.CAMPO_ID;
  bool usarOrdemDecrescente = false;
  final descricaoController = TextEditingController();
  bool _alterouValores = false;

  @override
  Widget build(BuildContext context){
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Filtros'),
          ),
          body: _criarBody()
        ),
        onWillPop: _onVoltarClick
    );
  }

  Widget _criarBody(){
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Text('Campos para ordenação'),
        ),

        for (final campo in camposParaOrdenacao.keys)
          Row(
              children: [
                Radio(
                  value: campo,
                  groupValue: campoOrdenacao,
                  onChanged: _onCheckCampoOrdencao,
                ),
                Text(camposParaOrdenacao[campo] ?? "")
              ]
          ),
          const Divider(),
          Row(
            children: [
              Checkbox(
                  value: usarOrdemDecrescente,
                  onChanged: _checkUsarOrdemDecrescente
              ),
              const Text('Usar ordem decrescente')
            ],
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(labelText: 'a descrição começa com'),
              controller: descricaoController,
              onChanged: _checkDescricao,
            ),
          )
      ],
    );
  }

  void _checkDescricao(String? valor){
    prefs.setString(FiltroPage.CHAVE_FILTRO_DESCRICAO, valor ?? '');
    _alterouValores = true;
  }

  void _checkUsarOrdemDecrescente(bool? valor){
    prefs.setBool(FiltroPage.USAR_ORDEM_DECRESCENTE, valor == true);
    _alterouValores = true;

    setState(() {
      usarOrdemDecrescente = valor == true;
    });
  }

  void _onCheckCampoOrdencao(String? valor){
    prefs.setString(FiltroPage.CHAVE_CAMPO_ORDENACAO, valor ?? '');
    _alterouValores = true;

    setState(() {
      campoOrdenacao = valor ?? '';
    });
  }

  Future<bool> _onVoltarClick() async{
    Navigator.of(context).pop(_alterouValores);
    return true;
  }
}