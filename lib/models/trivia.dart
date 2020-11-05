class Trivia {
  int responseCode;
  List<Results> results;

  Trivia({this.responseCode, this.results});

  Trivia.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }
}

class Results {
  String category;
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<Answer> answers;
  List<String> incorrectAnswers;
  List<String> allAnswers;

  Results({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.answers,
    this.correctAnswer,
    this.incorrectAnswers,
  });

  Results.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    type = json['type'];
    difficulty = json['difficulty'];
    question = json['question'];
    correctAnswer = json['correct_answer'];

    incorrectAnswers = json['incorrect_answers'].cast<String>();

    allAnswers = shuffle(incorrectAnswers + toList(correctAnswer));

    if (allAnswers != null) {
      answers = List<Answer>();

      allAnswers.forEach((element) {
        var ans = Answer();
        ans.setAnswer = element;
        answers.add(ans);
      });
    }
  }
}

class Answer {
  String answer;
  bool click = false;

  set setAnswer(String ans) {
    answer = ans;
  }

  Answer({this.answer});
}

List<String> toList(String text) {
  List<String> list = [];
  list.add(text);
  return list;
}

List<String> shuffle(List<String> list) {
  list.shuffle();

  return list;
}
