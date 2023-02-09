import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication_app/model/message.dart';

class MessagesRepository extends ChangeNotifier{
  final List<Message> messages = [
    Message("Hello Rachel!", "Jane", DateTime.now().subtract(Duration(minutes: 2))),
    Message("Hi!", "Rachel", DateTime.now().subtract(Duration(minutes: 1))),
    Message("How are you?", "Rachel", DateTime.now().subtract(Duration(minutes: 1))),
    Message("Great! What about you?", "Jane", DateTime.now()),
    Message("I'm doing alright!", "Rachel", DateTime.now().add(Duration(minutes: 1))),
    Message("Have you talked to the teacher?", "Jane", DateTime.now().add(Duration(minutes: 1))),
    Message("Not yet, I'm planning to talk with her tomorrow.", "Rachel", DateTime.now()),
    Message("Oh really? I can come with you if you want", "Jane", DateTime.now()),
    Message("Really? That would be great, thanks!", "Rachel", DateTime.now()),
    Message("No worries!", "Jane", DateTime.now()),
    Message("OK! Then, see you tomorrow!", "Rachel", DateTime.now()),
  ];
}

final messagesProvider = ChangeNotifierProvider((ref) {
  return MessagesRepository();
});

class NewMessageCount extends StateNotifier<int>{
  NewMessageCount(int state): super(state);

  void makeZero(){
    state = 0;
  }
}

final newMessageCountProvider = StateNotifierProvider<NewMessageCount, int>((ref){
  return NewMessageCount(11);
});
