import 'package:flutter/material.dart';
import 'package:student_communication_app/repository/messages_repository.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key, required this.messagesRepository}) : super(key: key);

  final MessagesRepository messagesRepository;
  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    super.initState();
    widget.messagesRepository.newMessageCount=0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // to show the newest messages (listview starts from the bottom)
              itemBuilder: (context, index) {
                Message message = widget.messagesRepository.messages[widget.messagesRepository.messages.length -index -1];
                return MessageWidget(message: message);
              },
              itemCount: widget.messagesRepository.messages.length,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          )),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none, //to remove the line
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(onPressed: () {}, child: Text("Send")),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.sender == "Rachel" ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            color: Colors.orange[100],
            borderRadius:
                const BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(message.text),
          ),
        ),
      ),
    );
  }
}
