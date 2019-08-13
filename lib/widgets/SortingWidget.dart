import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/widgets/ClassWidget.dart';
import 'package:tutor_helper/widgets/DashboardWidget.dart';

class SortingWidget extends StatefulWidget {
  final List sLessons;

  const SortingWidget({Key key, this.sLessons}) : super(key: key);

  @override
  State createState() => SortingWidgetState();
}

class SortingWidgetState extends State<SortingWidget> {
  List items;

  @override
  void initState() {
    items = widget.sLessons;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: StLessonModel().allPast(),
        builder: (context, snap) {
          if (snap.hasData) {
            print(snap.data);
            if (snap.data.isEmpty)
              return Container();
            else
              return DashboardWidget(
                title: 'Сортировка',
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      final StLessonModel item = snap.data[index];

                      return Slidable(
                        key: Key(item.id.toString()),
                        actionPane: SlidableBehindActionPane(),
                        actionExtentRatio: 0.25,
                        dismissal: SlidableDismissal(
                          child: SlidableDrawerDismissal(),
                          onDismissed: (actionType) {
//                  _showSnackBar(
//                      context,
//                      actionType == SlideActionType.primary
//                          ? 'Dismiss Archive'
//                          : 'Dimiss Delete');
                            setState(() {
                              items.removeAt(index);
                            });
                          },
                        ),
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: Text('Игорь'),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                            ),
                            subtitle: Text('123'),
                          ),
                        ),
                        actions: <Widget>[
                          IconSlideAction(
                            caption: 'Успешно',
                            color: Colors.blue,
                            icon: Icons.done,
//                  onTap: () => _showSnackBar('Archive'),
                          ),
                        ],
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Удалить',
                            color: Colors.red,
                            icon: Icons.do_not_disturb,
//                  onTap: () => _showSnackBar('Delete'),
                          ),
                        ],
                      );
                    }),
              );
          } else {
            return SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ));
          }
        });
  }
}
