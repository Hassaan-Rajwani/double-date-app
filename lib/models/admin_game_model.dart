class AdminGameModel {
  String? sId;
  String? name;
  int? iV;
  List<QuestionsAndAnswers>? questionsAndAnswers;

  AdminGameModel({this.sId, this.name, this.iV});

  AdminGameModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    iV = json['__v'];
    if (json['questionsAndAnswers'] != null) {
      questionsAndAnswers = <QuestionsAndAnswers>[];
      json['questionsAndAnswers'].forEach((v) {
        questionsAndAnswers!.add(QuestionsAndAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['__v'] = iV;
    if (questionsAndAnswers != null) {
      data['questionsAndAnswers'] = questionsAndAnswers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionsAndAnswers {
  int? questionNumber;
  String? question;
  String? answer;
  bool? showAnswer;
  String? response;

  QuestionsAndAnswers({this.questionNumber, this.question, this.answer});

  QuestionsAndAnswers.fromJson(Map<String, dynamic> json) {
    questionNumber = json['questionNumber'];
    question = json['question'];
    answer = json['answer'];
    response = json['response'] ?? '';
    showAnswer = json['showAnswer'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionNumber'] = questionNumber;
    data['question'] = question;
    data['showAnswer'] = showAnswer;
    data['response'] = response;
    if (answer != null) {
      data['answer'] = answer;
    }
    return data;
  }
}
