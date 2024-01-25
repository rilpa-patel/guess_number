import 'package:flutter/material.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   int? _targetNumber;
  int? _userGuess;
  late int _attempts;
  String _resultText = '';
  final List<int> _guessHistory = [];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    _targetNumber = Random().nextInt(10) + 1;
    _attempts = 0;
    _resultText = '';
    _guessHistory.clear();
    _textEditingController.clear();
  }

  void _checkGuess() {
    setState(() {
      _userGuess = int.tryParse(_textEditingController.text)!;

      if (_userGuess != null) {
        _attempts++;
        _guessHistory.add(_userGuess!);

        if (_userGuess == _targetNumber) {
          _resultText =
              'Congratulations! You guessed the correct number in $_attempts attempts.';
              
        } else if (_userGuess! < _targetNumber!) {
          _resultText = 'Too low! Try again.';
        } else {
          _resultText = 'Too high! Try again.';
        }
      } else {
        _resultText = 'Please enter a valid number.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Guessing Game'),
        backgroundColor: Colors.blue,
        centerTitle: true,
          toolbarHeight: 60.2,
          automaticallyImplyLeading: false,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 0.5,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Guess the number between 1 and 10:',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter your guess',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(
                fontWeight: FontWeight.bold)),
                onPressed: _checkGuess,
                child: const Text('Check Guess'),
              ),
              const SizedBox(height: 16),
              Text(
                _resultText,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (_attempts > 0)
                Column(
                  children: [
                    const Text(
                      'Guess History:',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _guessHistory
                          .map(
                            (guess) => Chip(
                              label: Text(
                                guess.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.blue,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(
                fontWeight: FontWeight.bold)),
                onPressed: _startNewGame,
                child: const Text('New Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
