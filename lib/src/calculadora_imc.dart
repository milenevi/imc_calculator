import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculadoraIMC extends StatefulWidget {
  @override
  _CalculadoraIMCState createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  double imc = 0.0;
  String resultado = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pesoController,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira seu peso';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _alturaController,
                decoration: const InputDecoration(labelText: 'Altura (m)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira sua altura';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    calcularIMC();
                  }
                },
                child: Text('Calcular'),
              ),
              const SizedBox(height: 10),
              Text('IMC: $imc', style: TextStyle(fontSize: 20)),
              Text('Resultado: $resultado', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }

  void calcularIMC() {
    // Parse dos valores de peso e altura
    final peso = double.parse(_pesoController.text);
    final altura = double.parse(_alturaController.text);

    // Cálculo do IMC
    final imc = peso / (altura * altura);

    // Definição da classificação
    String classificacao = '';

    if (imc < 16) {
      classificacao = 'Magreza grave';
    } else if (imc < 17) {
      classificacao = 'Magreza moderada';
    } else if (imc < 18.5) {
      classificacao = 'Magreza leve';
    } else if (imc < 24.9) {
      classificacao = 'Saudável';
    } else if (imc < 29.9) {
      classificacao = 'Sobrepeso';
    } else if (imc < 34.9) {
      classificacao = 'Obesidade Grau I';
    } else if (imc < 39.9) {
      classificacao = 'Obesidade Grau II';
    } else {
      classificacao = 'Obesidade Grau III';
    }

    setState(() {
      this.imc = imc;
      this.resultado = classificacao;
    });
  }
}