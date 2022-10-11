import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CalculoImc());
}

class CalculoImc extends StatelessWidget {
  const CalculoImc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _peso = 50.0;
  double _altura = 1.50;
  double _imc = 80 / 1.50 * 1.50;
  String _resultado = 'Normal';
  Color _statusColor = Color.fromARGB(255, 64, 138, 66);
  Color _backgroundColor = Color.fromARGB(255, 194, 241, 195);
  IconData _statusIcon = Icons.sentiment_very_satisfied;

  void _calcularImc() {
    setState(() {});
    _imc = _peso / (_altura * _altura);
    HapticFeedback.heavyImpact();
    if (_imc < 18.5) {
      _resultado = 'Magreza';
      _statusColor = Colors.orange;
      _backgroundColor = Color.fromARGB(255, 240, 213, 172);
      _statusIcon = Icons.sentiment_neutral;
      //HapticFeedback.lightImpact();
      return;
    }
    if (_imc > 18.5 && _imc < 24.9) {
      _resultado = 'Normal';
      _statusColor = Color.fromARGB(255, 64, 138, 66);
      _backgroundColor = Color.fromARGB(255, 172, 240, 195);
      _statusIcon = Icons.sentiment_very_satisfied;
      //HapticFeedback.vibrate();
      return;
    }
    if (_imc > 24.9 && _imc < 30) {
      _resultado = 'Sobrepeso';
      _statusColor = Color.fromARGB(255, 205, 151, 33);
      _backgroundColor = Color.fromARGB(255, 238, 197, 139);
      _statusIcon = Icons.sentiment_dissatisfied;
      //HapticFeedback.mediumImpact();
      return;
    }
    if (_imc > 30) {
      _resultado = 'Obesidade';
      _statusColor = Colors.red;
      _backgroundColor = Color.fromARGB(255, 238, 150, 139);
      _statusIcon = Icons.sentiment_very_dissatisfied;
      //HapticFeedback.heavyImpact();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _backgroundColor,
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _statusIcon,
                size: 150,
                color: _statusColor,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 600),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: _statusColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _resultado,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            _imc.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text('Seu IMC')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      'Peso',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      '${_peso.ceil().toString()} kg',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Slider(
                        min: 40,
                        max: 180,
                        value: _peso,
                        onChanged: (novoPeso) {
                          _peso = novoPeso;
                          _calcularImc();
                        })
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      'Altura',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      '${_altura.toStringAsFixed(2).replaceFirst(".", ",")} m',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Slider(
                        min: 1.30,
                        max: 2.10,
                        value: _altura,
                        onChanged: (novoAltura) {
                          _altura = novoAltura;
                          _calcularImc();
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Feito com Flutter por Erick Melo',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 29, 28, 28)),
                    ),
                    FlutterLogo(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
