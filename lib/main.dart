import 'package:flutter/material.dart';
/*
    Statefull: pois podemos interagir, vamos ter um estado na tela, podemos colocar dados e poderá modificar
  a medida que os dados forem preenchidos. Comando stf
    Scaffold: widget que permite inserir -> barras, drawer, tabs, navigations
*/

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController(); // controlador do peso
  TextEditingController heightController = TextEditingController(); // controlador da altura

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {   // funcao privada que implementa a funcao de reset
    weightController.text = ""; // peso vazio
    heightController.text = ""; // altura vazio
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);

      if(imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade grau 1 (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade grau 2 (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 40.0) {
        _infoText = "Obesidade grau 3 (${imc.toStringAsPrecision(3)})";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculador de IMC"),   // título principal
        centerTitle: true,  // centralizar
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), // icone refresh com o metodo onPressed
            onPressed: _resetFields,
          )
        ],
      ),

      backgroundColor: Colors.white,    // cor do corpo

      body: SingleChildScrollView(    // evitando problemas de overflow de botao
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0), // espacamento dos cantos
        child: Form(
            key: _formKey,
            child: Column(     // agrupando as coisas na vertical
              crossAxisAlignment: CrossAxisAlignment.stretch, // esticando a largura no eixo horizontal
              children: <Widget>[   // filhos da coluna
                Icon(Icons.person_outline, size: 120.0, color: Colors.red), // adicionar um icone

                TextFormField(keyboardType: TextInputType.number, // adicionando  campo de texto do peso
                  decoration: InputDecoration(  // adicionando uma decoracao
                      labelText: "Peso (kg)",    // etiqueta
                      labelStyle: TextStyle(color: Colors.red)  // estilo do texto
                  ),
                  textAlign: TextAlign.center,  // alinhando um texto ao centro
                  style: TextStyle(color: Colors.black, fontSize:25.0),  // cor do texto digitado e tamanho
                  controller: weightController,
                  validator: (value) {
                    if(value.isEmpty)
                      return "Insira seu Peso!";
                    return null;
                  },
                ),

                TextFormField( // adicionando  campo de texto da altura
                  keyboardType: TextInputType.number, // tipo de texto numero
                  decoration: InputDecoration(  // adicionando uma decoracao
                      labelText: "Altura (m)",    // etiqueta
                      labelStyle: TextStyle(color: Colors.red)  // estilo do texto
                  ),
                  textAlign: TextAlign.center,  // alinhando um texto ao centro
                  style: TextStyle(color: Colors.black, fontSize:25.0),  // cor do texto digitado e tamanho
                  controller: heightController,
                  validator: (value) {
                    if(value.isEmpty)
                      return "Insira sua altura!";
                    return null;
                  },
                ),

                Padding(  // widget para definir um padding dentro de layout do botao
                  padding: EdgeInsets.only(top:10.0, bottom: 10.0), // espacamento do botao
                  child: Container(    // definindo um container de botao
                      height: 50.0,   // altura do botao
                      child: RaisedButton(   // adicionando um campo de botão
                        onPressed: () {
                          if(_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },   // metodo de pressionar
                        child: Text("Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),),  // filho de texto com cor e tamanho
                        color: Colors.black,  // cor do botao
                      )
                  ),
                ),

                Text(
                    _infoText,    // texto abaixo do botao
                    textAlign: TextAlign.center,  // centralizando o texto ao centro
                    style: TextStyle(color: Colors.black, fontSize: 25.0) // estilo da cor
                ),
              ],
            )
        ),
      ),
    );
  }
}