import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MotivationalQuotesPage extends StatefulWidget {
  @override
  _MotivationalQuotesPageState createState() => _MotivationalQuotesPageState();
}

class _MotivationalQuotesPageState extends State<MotivationalQuotesPage> {
  List<String> _quotes = [];
  String _currentQuote = "Carregando frase...";
  String _lastQuote = ""; // Armazena a última frase gerada

  @override
  void initState() {
    super.initState();
    _fetchQuotes();
  }

  Future<void> _fetchQuotes() async {
    try {
      print("🔍 Iniciando a busca de frases...");
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      DataSnapshot snapshot = await ref.get();
      print("📸 Snapshot recebido: ${snapshot.value}");

      if (snapshot.value != null && snapshot.value is Map) {
        final Map<dynamic, dynamic> data = Map.from(snapshot.value as Map);
        print("📊 Dados recebidos: $data");

        if (data.containsKey("quotes") && data["quotes"] is List) {
          final List<dynamic> quotesList = List.from(data["quotes"]);
          setState(() {
            _quotes = quotesList.map((quote) => quote.toString()).toList();
            _currentQuote = _getRandomQuote();
          });
        } else {
          setState(() {
            _currentQuote = "Nenhuma frase encontrada no banco de dados!";
          });
        }
      } else {
        setState(() {
          _currentQuote = "Nenhuma frase encontrada no banco de dados!";
        });
      }
    } catch (e) {
      setState(() {
        _currentQuote = "Erro ao buscar frases: $e";
      });
    }
  }

  String _getRandomQuote() {
    if (_quotes.isNotEmpty) {
      final List<String> filteredQuotes = _quotes.where((quote) => quote != _lastQuote).toList();
      if (filteredQuotes.isNotEmpty) {
        filteredQuotes.shuffle();
        _lastQuote = filteredQuotes.first; // Atualiza a última frase gerada
        return _lastQuote;
      }
    }
    return "Nenhuma frase disponível!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gerador de Frases Motivacionais")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentQuote,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentQuote = _getRandomQuote();
                  });
                },
                child: Text("Gerar Nova Frase"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}