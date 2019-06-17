import 'package:flutter/material.dart';
import 'package:tutor_helper/widgets/StudentCard.dart';
import '../main.dart';
import 'StudentCreate.dart';
import 'package:tutor_helper/models/StudentModel.dart';

class StudentsList extends StatefulWidget {

  @override
  State createState() => StudentsListState();
}

class StudentsListState extends  State<StudentsList>{
  final Future future = StudentModel().all();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FutureBuilder(
          future: future,
          builder: (BuildContext context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    StudentModel item = snapshot.data[index];
                    return StudentCard(item);
                  },
              );
            }else{
              return Center(
                child: Text('Ученики отсутствуют'),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
//          StudentModel().all();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => StudentCreate()));
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}