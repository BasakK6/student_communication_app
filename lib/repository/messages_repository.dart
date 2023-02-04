class MessagesRepository{
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

  int newMessageCount = 11;
}

class Message{
  String text;
  String sender;
  DateTime date;

  Message(this.text, this.sender, this.date);
}