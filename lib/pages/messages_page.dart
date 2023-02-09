import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication_app/repository/messages_repository.dart';
import 'package:student_communication_app/model/message.dart';

class MessagesPage extends ConsumerStatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends ConsumerState<MessagesPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value){
      ref.read(newMessageCountProvider.notifier).makeZero();
    });
  }
  @override
  Widget build(BuildContext context) {
    final messagesRepository = ref.watch(messagesProvider);


    return Scaffold(
      appBar: AppBar(title: const Text("Messages")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // to show the newest messages (listview starts from the bottom)
              itemBuilder: (context, index) {
                Message message = messagesRepository.messages[messagesRepository.messages.length -index -1];
                return MessageWidget(message: message);
              },
              itemCount: messagesRepository.messages.length,
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
