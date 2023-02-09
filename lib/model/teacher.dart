class Teacher{
  String name;
  String surname;
  int age;
  String gender;

  Teacher(this.name, this.surname, this.age, this.gender);

  Teacher.fromMap(Map<String, dynamic> map): this(map["name"], map["surname"], map["age"],
      map["gender"] == true ? "male": "female");

  Map<String, dynamic> toMap() {
    return {
      "name":name,
      "surname":surname,
      "age": age,
      "gender": gender == "male" ? true : false
    };
  }


}