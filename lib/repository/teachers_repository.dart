class TeachersRepository{
  final List<Teacher> teachers = [
    Teacher("Gerard", "Carney", 32, "male"),
    Teacher("Elena", "Shepard", 28, "female"),
  ];
}

class Teacher{
  String name;
  String surname;
  int age;
  String gender;

  Teacher(this.name, this.surname, this.age, this.gender);
}