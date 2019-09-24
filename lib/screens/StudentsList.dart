import 'package:flutter/material.dart';
import 'package:tutor_helper/widgets/StudentCard.dart';
import 'StudentCreate.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:tutor_helper/widgets/StudentContactWidget.dart';

class StudentsList extends StatefulWidget {
  StudentsList({Key key}) : super(key: key);

  @override
  State createState() => StudentsListState();
}

class StudentsListState extends State<StudentsList> {
  Future future = StudentModel().all();

  updateState() {
    setState(() {
      future = StudentModel().all();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data.isEmpty)
              return Center(child: Text('Вы еще не добавили ни одного ученика', style: TextStyle( color:  Theme.of(context).hintColor)),);
            else
              return GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  StudentModel item = snapshot.data[index];
                  return Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: StudentContact(student: item),
                  );
                },
              );
          }else{
            return Center(
              child: Text('Загрузка', style: TextStyle( color:  Theme.of(context).hintColor)),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
//          StudentModel().all();
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StudentCreate()))
              .then((val) => updateState());
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}
