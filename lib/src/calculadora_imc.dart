import 'package:flutter/material.dart';

import 'pessoa.dart';

class CalculadoraIMC extends StatefulWidget {
  @override
  _CalculadoraIMCState createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  final _formKey = GlobalKey<FormState>();
  final _pessoa = Pessoa(nome: '', peso: 0.0, altura: 0.0);

  double imc = 0.0;
  String resultado = "";
  bool mostrarLimpar = false;

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
                initialValue: _pessoa.nome,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  _pessoa.nome = value!;
                },
              ),
              TextFormField(
                initialValue: _pessoa.peso != 0.0 ? _pessoa.peso.toStringAsFixed(1) : '',
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira seu peso';
                  }
                  return null;
                },
                onSaved: (value) {
                  _pessoa.peso = double.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _pessoa.altura != 0.0 ? _pessoa.altura.toStringAsFixed(2) : '',
                decoration: const InputDecoration(labelText: 'Altura (m)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira sua altura';
                  }
                  return null;
                },
                onSaved: (value) {
                  _pessoa.altura = double.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    calcularIMC();
                  }
                },
                child: const Text('Calcular'),
              ),
              if(mostrarLimpar)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                        setState(() {
                          imc = 0.0;
                          resultado = "";
                          mostrarLimpar = false;
                        });
                      },
                      child: const Text('Limpar Dados'),
                    ),
                    const SizedBox(height: 10),
                    Text('IMC: ${imc.toStringAsFixed(1)}', style: const TextStyle(fontSize: 20)),
                    Text('Resultado: $resultado', style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calcularIMC() {
    final imc = _pessoa.peso / (_pessoa.altura * _pessoa.altura);
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
      classificacao = 'Obesidade Grau II (severa)';
    } else {
      classificacao = 'Obesidade Grau III (mórbida)';
    }

    setState(() {
      this.imc = imc;
      this.resultado = classificacao;
      mostrarLimpar = true;
    });
  }
}