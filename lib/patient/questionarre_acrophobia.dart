import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vr_therapy_ipd/patient/features/finalresults.dart';

class QuestionnairePagea extends StatefulWidget {
  final String phobiaA;

  QuestionnairePagea({required this.phobiaA});
  @override
  _QuestionnairePageaState createState() => _QuestionnairePageaState();
}

class _QuestionnairePageaState extends State<QuestionnairePagea>
    with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  final List<Map<String, dynamic>> _questions = [
    // Questionnaire data...
    {
      'question':
          'Did you feel a strong sense of fear or anxiety during the VR simulation involving heights or rollercoasters?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did you experience physical symptoms such as sweating, trembling, or an increased heart rate during the VR simulation',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did you have thoughts of wanting to exit the VR simulation or stop the experience due to the fear?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did you feel a sense of panic or dread that persisted throughout the virtual height exposure?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did you find yourself holding your breath or having difficulty breathing during the VR simulation?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did you find it challenging to engage in the VR simulation due to overwhelming fear or discomfort?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Do you consistently feel a sense of panic or dread when you think about being at a high place?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Do you often find yourself thinking about the possibility of falling when you are in a high place?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Have you ever had difficulty breathing or felt short of breath when in a high place?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Have you ever turned down a job or an opportunity because it involved working at a height?',
      'options': ['Yes', 'No'],
    },
  ];

  String? _selectedAnswer;
  String userEmail = "";
  List<String?> selectedAnswers = [];
  String? phobiaPrediction;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        selectedAnswers.add(_selectedAnswer);
        _selectedAnswer = null;
        _animationController.reset(); // Reset animation for next question
        _animationController.forward(); // Start animation for next question
      } else {
        // User has completed the questionnaire
        selectedAnswers.add(_selectedAnswer);
        print('Selected Answers: $selectedAnswers'); // Print selected answers

        // Send selected answers to the API
        postData(selectedAnswers);
      }
    });
  }

  Future<void> postData(List<String?> selectedAnswers) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.194.60:8000/predict'), // Replace with your API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'user_answers':
              selectedAnswers.map((answer) => answer == 'Yes' ? 1 : 0).toList(),
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('Data posted successfully');
        print('Response: ${response.body}');
        setState(() {
          phobiaPrediction = response.body.toString();
        });

        // Navigate to FinalDetect page with responseBody as parameter
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinalDetect(
              simulationValue: widget.phobiaA,
              questionnaireValue: phobiaPrediction!,
            ),
          ),
        );
      } else {
        // Handle error response
        print('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Failed to post data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFFEBFF00)), // Yellow progress bar
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    _questions[_currentQuestionIndex]['question'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CustomFont', // Apply custom font
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: _questions[_currentQuestionIndex]['options']
                        .map<Widget>((option) => InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedAnswer = option;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: _selectedAnswer == option
                                      ? Colors.blue.withOpacity(0.5)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: _selectedAnswer == option
                                        ? Colors.blue
                                        : Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily:
                                              'CustomFont', // Apply custom font
                                        ),
                                      ),
                                    ),
                                    if (_selectedAnswer == option)
                                      Icon(Icons.check, color: Colors.blue),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _selectedAnswer != null ? _nextQuestion : null,
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.black, // Change text color to black
                        fontFamily: 'CustomFont', // Apply custom font
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: _selectedAnswer != null
                          ? Color(0xFFEBFF00)
                          : Colors.grey, // Yellow button color
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_nextQuestion == null)
                    Text(
                      'Phobia Prediction: $phobiaPrediction',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'CustomFont', // Apply custom font
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
