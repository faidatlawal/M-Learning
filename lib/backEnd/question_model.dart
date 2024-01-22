import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel{
  String questM;
  String option1M;
  String option2M;
  String option3M;
  String option4M;
  String correctAnsM;
  bool answeredM;

  QuestionModel getQuestionsModels ({DocumentSnapshot documentSnapshot}){
    QuestionModel questionModel = QuestionModel();
    questionModel.questM = documentSnapshot.data()['question'];
    List<String>optionList = [
      documentSnapshot.data()['option1'],
      documentSnapshot.data()['option2'],
      documentSnapshot.data()['option3'],
      documentSnapshot.data()['option4'],
    ];
    optionList.shuffle(); //=====================

    questionModel.option1M = optionList[0];
    questionModel.option2M = optionList[1];
    questionModel.option3M = optionList[2];
    questionModel.option4M = optionList[3];
    questionModel.correctAnsM = documentSnapshot.data()['option1'];
    questionModel.answeredM = false;
    return questionModel;
  }
}