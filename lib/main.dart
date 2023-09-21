import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  List<Map<String, dynamic>> _questions = [
    {
      'question': 'Excess of Everything is bad?',
      'answer': true,
    },
    {
      'question': 'Pakistan is our Beloved Country',
      'answer': true,
    },
    {
      'question': 'Quaid-e-Azam is the 1st PM of Pakistan',
      'answer': false,
    },
  ];

  void _nextQuestion(bool userAnswer) {
    if (_questions[_currentQuestionIndex]['answer'] == userAnswer) {
      _correctAnswers++;
    }
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
    });
  }

  Widget _buildQuestionResult(int index) {
    bool userAnswer = _questions[index]['answer'];
    bool? isCorrect = _currentQuestionIndex == index ? null : userAnswer;

    return ListTile(
      title: Text(
        _questions[index]['question'],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
      ),
      subtitle: isCorrect == null
          ? null
          : Text(
              isCorrect ? 'Your Answer: True' : 'Your Answer: False',
              style: TextStyle(
                color: isCorrect ? Colors.green : Colors.red,
                fontSize: 18.0,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text("Quizapp"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _currentQuestionIndex < _questions.length
                  ? Expanded(
                      child: Center(
                        child: Text(
                          _questions[_currentQuestionIndex]['question'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _questions.length,
                        itemBuilder: (context, index) {
                          return _buildQuestionResult(index);
                        },
                      ),
                    ),
              if (_currentQuestionIndex < _questions.length)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        _nextQuestion(true);
                      },
                      child: const Text(
                        "True✅",
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ),
                ),
              if (_currentQuestionIndex < _questions.length)
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      _nextQuestion(false);
                    },
                    child: const Text(
                      "False❌",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              if (_currentQuestionIndex == _questions.length - 1)
                Text(
                  'Overall Result:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
              if (_currentQuestionIndex == _questions.length)
                Text(
                  'Correct Answers: $_correctAnswers',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20.0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
