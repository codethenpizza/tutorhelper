import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tutor_helper/models/StudentModel.dart';

class StudentEdit extends StatefulWidget {
  final StudentModel student;

  const StudentEdit(this.student);

  @override
  State createState() => StudentEditState();
}

class StudentEditState extends State<StudentEdit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  @override
  void initState() {
    super.initState();
    nameController.text = widget.student.name;
    phoneController.text = widget.student.phone;
    emailController.text = widget.student.email;
  }
  //TODO: Change when student create will be ready
  //TODO: Add delete button
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Редактирование ученика'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Имя',
            ),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Телефон',
            ),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Почта',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              color: Theme.of(context).buttonColor,
              textColor: Colors.white,
              onPressed: () => editStudent(context),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: const Text('Обновить'),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  editStudent(BuildContext context) async {
    StudentModel student =
    new StudentModel(id: widget.student.id, name: nameController.text, phone: phoneController.text, email: emailController.text);

    await student.save();

    Navigator.pop(context, student);
    Flushbar(
      message: 'Ученик изменен',
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
