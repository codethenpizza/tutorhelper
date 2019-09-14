import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:tutor_helper/widgets/Layout.dart';
import 'package:tutor_helper/widgets/CardLayout.dart';
import 'package:tutor_helper/main.dart';


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
  var _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    nameController.text = widget.student.name;
    phoneController.text = widget.student.phone;
    emailController.text = widget.student.email;

  }

  void removeStudent(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          settings: RouteSettings(isInitialRoute: true),
          builder: (context) => AlertDialog(
            title: Text('Вы уверенны, что хотите удалить ученика?'),
            actions: <Widget>[
              FlatButton(
                  child: Text('Отмена'),
                  onPressed: () => Navigator.pop(context)),
              RaisedButton(
                  textColor: Colors.white,
                  child: Text('Удалить'),
                  onPressed: () async {
                    await widget.student.delete();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    studentListKey.currentState.updateState();
                    Flushbar(
                      message: 'Ученик удален',
                      duration: Duration(seconds: 2),
                    )..show(context);
                  }),
            ],
          ),
        ));
  }

 //TODO add skype
  @override
  Widget build(BuildContext context) => Layout(
    title: "Редактирование ученика",
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.delete,
          color: Theme.of(context).backgroundColor,
        ),
        onPressed: () => removeStudent(context),
      )
    ],
    child: Form(
      key: _formKey,
      child: ListView(
          children: <Widget>[
            CardLayout(
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Название не может быть пустым";
                    }
                  },
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
                TextField(
//                controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Skype',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate()) {
                          editStudent(context);
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Обновить',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .backgroundColor,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
