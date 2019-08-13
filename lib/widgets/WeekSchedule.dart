import 'package:flutter/material.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tutor_helper/widgets/DashboardWidget.dart';

class WeekSchedule extends StatefulWidget {

  @override
  State createState() => WeekScheduleState();
}

class WeekScheduleState extends State<WeekSchedule>{

  @override
  Widget build(BuildContext context) {
    return DashboardWidget(
      title: 'Расписание на неделю',
      child: FutureBuilder(
          future: StLessonModel().nextWeek(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              if(!snapshot.data.isEmpty)
                return CustomPaint(
                  painter: new WeekSchedulePainter(snapshot.data),
                  child: SizedBox(height: 600, ),
                );
              else
                return Container(
                  child: Center(
                    child: Text('На ближайшую неделю занятия отсутствуют'),
                  ),
                );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
      ),
    );
  }

}

class WeekSchedulePainter extends CustomPainter {
  List lessons;

  WeekSchedulePainter(this.lessons);

  @override
  void paint(Canvas canvas, Size size) {
    double padding = 10;
    double timeTextWidth = 40;
    double daysTextHeight = 10;

    double leftLineLength = size.height - padding * 2 - daysTextHeight;
    double bottomLineLength = size.width - padding * 2 - timeTextWidth;

    //Liens
    Paint bgLine = Paint()
      ..color = Colors.grey[200]
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    Paint bgLineBold = Paint()
      ..color = Colors.grey[400]
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    //Draw left & bottom lines
    canvas.drawLine(
        Offset(padding + timeTextWidth, padding),
        Offset(padding + timeTextWidth, padding + leftLineLength),
        bgLineBold);
    canvas.drawLine(
        Offset(padding + timeTextWidth, padding + leftLineLength),
        Offset(padding + timeTextWidth + bottomLineLength,
            padding + leftLineLength),
        bgLine);

    //Draw time text & time lines
    TextPainter text = new TextPainter(
        textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    var twoDigits = new intl.NumberFormat("00", "en_US");
    for (int i = 0; i < 24; i++) {
      double timeY = leftLineLength - leftLineLength / 24 * i;
      if (i % 2 == 0) {
        text.text = TextSpan(
            style: new TextStyle(color: Colors.grey),
            text: twoDigits.format(i) + ":00");

        text.layout();
        text.paint(canvas, Offset(padding, timeY));
        canvas.drawLine(
            Offset(padding + timeTextWidth, padding + timeY),
            Offset(padding + timeTextWidth + bottomLineLength,
                padding + timeY),
            bgLineBold);
      } else {
        canvas.drawLine(
            Offset(padding + timeTextWidth, padding + timeY),
            Offset(padding + timeTextWidth + bottomLineLength,
                padding + timeY),
            bgLine);
      }

      if(i<7 || i>22){
        canvas.drawRect(
            Rect.fromLTWH(padding + timeTextWidth,
                padding + timeY, bottomLineLength, -leftLineLength / 24),
            Paint()
              ..style = PaintingStyle.fill
              ..color = Color(0x22212121));
      }
    }

    text.text = TextSpan(
        style: new TextStyle(color: Colors.grey),
        text: "24:00");

    text.layout();
    text.paint(canvas, Offset(padding, padding - 5));
    canvas.drawLine(
        Offset(padding + timeTextWidth, padding),
        Offset(padding + timeTextWidth + bottomLineLength,
            padding),
        bgLineBold);

    //Draw days
    DateTime day = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime currentDay = day.add(Duration(days: i));

      text.text = TextSpan(
          style: new TextStyle(color: Colors.grey),
          text: intl.DateFormat('E', 'ru').format(currentDay));
      text.layout();
      double dayX = bottomLineLength / 7 * i;
      double dayWidth = bottomLineLength / 7;

      text.paint(
          canvas,
          Offset(
              padding + timeTextWidth + dayX + 10, padding + leftLineLength));

      canvas.drawLine(
          Offset(padding + timeTextWidth + dayX, padding + leftLineLength),
          Offset(padding + timeTextWidth + dayX, padding),
          bgLine);

      if(currentDay.weekday == 6 || currentDay.weekday == 7){
        canvas.drawRect(
            Rect.fromLTWH(padding + timeTextWidth + dayX,
                padding, dayWidth, leftLineLength),
            Paint()
              ..style = PaintingStyle.fill
              ..color = Color(0x22212121));
      }


      lessons.forEach((lesson) {
        DateTime date = DateTime.parse(lesson.date);

        if (date.day == currentDay.day &&
            date.month == currentDay.month &&
            date.year == currentDay.year) {
          double from =
              leftLineLength / 1440 * (date.hour * 60 + date.minute);
          double to = leftLineLength /
              1440 *
              (date.hour * 60 + date.minute + lesson.duration);

          Paint lessonLine = Paint()
            ..style = PaintingStyle.fill
            ..color = Colors.red[300];

          canvas.drawRect(
              Rect.fromLTWH(padding + timeTextWidth + dayX,
                  padding + leftLineLength - to, dayWidth, to - from),
              lessonLine);
        }
      });
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
