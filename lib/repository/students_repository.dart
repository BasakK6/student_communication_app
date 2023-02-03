class StudentsRepository{
  final List<Student> students = [
    Student("Rachel", "Greene", 18, "female"),
    Student("Kiara", "Valenzuela", 16, "female"),
    Student("Howard", "Terry", 15, "male"),
    Student("Jonah", "Walker", 18, "male"),
    Student("Erin", "Erin", 17, "female"),
    Student("Ada", "Stanton", 18, "female"),
    Student("Jane", "Stein", 18, "female"),
  ];
}

class Student{
  String name;
  String surname;
  int age;
  String gender;

  Student(this.name, this.surname, this.age, this.gender);
}