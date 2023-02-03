import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages")),
      body: ListView.builder(
        itemBuilder: (context, index) {
          bool isItMe = false;
          return Align(
            alignment: Alignment.centerRight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2
                ),
              ),
              child: const Text("Message"),
            ),
          );
        },
      ),
    );
  }
}
