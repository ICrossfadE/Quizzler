import 'package:flutter/material.dart';
import 'package:quizzler/questionList.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Questionlist questionsList = Questionlist();

class QuizzlerApp extends StatefulWidget {
  const QuizzlerApp({super.key});

  @override
  State<QuizzlerApp> createState() => _QuizzlerAppState();
}

class _QuizzlerAppState extends State<QuizzlerApp> {
  int correctCounter = 0;
  List<Icon> iconList = [];

  void _resulAnswer(answer) {
    setState(() {
      if (questionsList.getAnswer() == answer) {
        iconList.add(const Icon(Icons.check, color: Colors.green));
        correctCounter++;
      } else {
        iconList.add(const Icon(Icons.close, color: Colors.red));
        correctCounter--;
      }

      if (correctCounter < 0) correctCounter++;
      if (iconList.length == questionsList.getQuestionLenght()) {
        Alert(
          context: context,
          title: "Quizz is empty :(",
          desc: "Your Score $correctCounter",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              color: Colors.green,
              child: const Text(
                "COOL",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ).show();
        iconList.clear();
        correctCounter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                correctCounter.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionsList.getQuestion(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: iconList,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 40.0),
                  ),
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                  shape: WidgetStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                child: const Text(
                  'True',
                  style: TextStyle(
                    backgroundColor: Colors.green,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  _resulAnswer(true);
                  questionsList.nextQuestion();
                },
              ),
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 40.0),
                  ),
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                  shape: WidgetStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                child: const Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  _resulAnswer(false);
                  questionsList.nextQuestion();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
