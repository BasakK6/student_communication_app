import 'package:flutter/material.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
      ),
      body: Column(
        children: [
          const PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text("10 Students"),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                leading: const Text("👩🏼"),//👦🏻
                title: const Text("Rachel"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 25,
            ),
          ),
        ],
      ),
    );
  }
}
