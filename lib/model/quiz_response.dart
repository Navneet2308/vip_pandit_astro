class QuizResponse {
  String? message;
  List<AstrologyQuiz>? data;

  QuizResponse({this.message, this.data});

  QuizResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(AstrologyQuiz.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AstrologyQuiz {
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? answer;


  AstrologyQuiz({
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.answer
  });

  AstrologyQuiz.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    option1 = json['option1'];
    option2 = json['option2'];
    option3 = json['option3'];
    option4 = json['option4'];
    // answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['option1'] = option1;
    data['option2'] = option2;
    data['option3'] = option3;
    data['option4'] = option4;
    data['answer'] = answer;
    return data;
  }
}
