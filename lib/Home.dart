import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _textoSalvo = 'Nada salvo';

  TextEditingController _controllerCampo = TextEditingController();
  
  _salvar() async {
    String valorDigitado = _controllerCampo.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", valorDigitado);
    print("operacao: $valorDigitado");

  }

  _recuperar()async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textoSalvo = prefs.getString("nome") ?? "Sem valor";
    });

    print("operacao: $_textoSalvo");

  }

  _remover()async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manipulação de dados'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
        child: Column(
          children: [
             Center(
              child: Text(_textoSalvo),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Digite algo',
              ),
              controller: _controllerCampo,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _salvar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(120, 50),
                      textStyle: const TextStyle(
                        fontSize: 16,),
                    ),
                    child: const Text('Salvar',
                    style: TextStyle(color: Colors.white),),),
                ),
                ElevatedButton(
                  onPressed: _recuperar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(120, 50),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text('Recuperar',
                  style: TextStyle(color: Colors.white),
                ),
                ),
                ElevatedButton(
                  onPressed: _remover,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(120, 50),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text(
                    'Remover',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
