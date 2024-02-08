import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarPreco();
  }

  void _recuperarPreco() async {
    var url = Uri.parse('https://blockchain.info/ticker');
    var bolsa =
        Uri.parse('http://economia.awesomeapi.com.br/json/last/USD-BRL');
    http.Response response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    /*http.Response response1 = await http.get(bolsa);
    Map<String, dynamic> retorno1 = json.decode(response1.body);*/

    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });
    print("Preço do bitcoin: " + retorno["BRL"]["buy"].toString());
    //print("Preços--------" + retorno1.toString());//
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("Imagens/bitcoin.png"),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$" + _preco,
                  style: const TextStyle(fontSize: 35),
                ),
              ),
              ElevatedButton(
                onPressed: _recuperarPreco,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 15)),
                child: const Text(
                  "Atualizar", //ok
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
