import 'dart:math';

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // to show the newest messages (listview starts from the bottom)
              itemBuilder: (context, index) {
                bool isItMe = Random().nextBool();

                return Align(
                  alignment:
                      isItMe ? Alignment.centerRight : Alignment.centerLeft,
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
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Message"),
                      ),
                    ),
                  ),
                );
              },
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
