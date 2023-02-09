import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication_app/model/teacher.dart';
import 'package:student_communication_app/pages/teacher_form_page.dart';
import 'package:student_communication_app/repository/teachers_repository.dart';

class TeachersPage extends ConsumerWidget {
  const TeachersPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersRepository = ref.watch(teachersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Teachers")),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          //return a bool? because it the user presses back button or there is an Exception, the return value is null
          bool? isSuccessful =  await Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return const TeacherFormPage();
          },),);

          if(isSuccessful == true){
            //refresh the data source
            print("refresh the teachers page");
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                          "${teachersRepository.teachers.length} Teachers",textAlign: TextAlign.center,),
                    ),
                    const TeacherDownloadButton()
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => TeacherListTile(
                teacher: teachersRepository.teachers[index],
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: teachersRepository.teachers.length,
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherDownloadButton extends ConsumerStatefulWidget {
  const TeacherDownloadButton({
    super.key,
  });

  @override
  ConsumerState<TeacherDownloadButton> createState() => _TeacherDownloadButtonState();
}

class _TeacherDownloadButtonState extends ConsumerState<TeacherDownloadButton> {
  bool isLoading = false;

  void negateIsLoading(){
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const CircularProgressIndicator(): IconButton(onPressed: () async {
      try{
        negateIsLoading();
        await ref.read(teachersProvider).download();
      }
      catch(_){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("The teacher could not be loaded")));
      }
      finally{
        negateIsLoading();
      }

    }, icon: const Icon(Icons.download),);
  }
}

class TeacherListTile extends StatelessWidget {
  const TeacherListTile({
    super.key,
    required this.teacher,
  });

  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IntrinsicWidth(
        child: Center(
          child: Text(teacher.gender == "female" ? "👩🏼" : "👦🏻"),
        ),
      ),
      title: Text("${teacher.name} ${teacher.surname}"),
      subtitle: Text(teacher.age.toString()),
    );
  }
}
