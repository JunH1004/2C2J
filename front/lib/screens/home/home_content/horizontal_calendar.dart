import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todotodo/my_style.dart';

class HorizontalWeekTodoBoard extends StatefulWidget {
  const HorizontalWeekTodoBoard({super.key});

  @override
  State<HorizontalWeekTodoBoard> createState() => _HorizontalWeekTodoBoardState();
}

class _HorizontalWeekTodoBoardState extends State<HorizontalWeekTodoBoard> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, double> todoDoneRatio = {
    //그날 투두를 얼마나 잘 수행했는지 0 ~ 1 = 안함 ~ 다함
    DateTime.utc(2024, 2, 15): 1,
    DateTime.utc(2024, 2, 17): 0.4,
    DateTime.utc(2024, 2, 18): 0.5,
    DateTime.utc(2024, 2, 20): 0.6,
    DateTime.utc(2024, 2, 23): 1,
    DateTime.utc(2024, 2, 24): 0.6,
    DateTime.utc(2024, 2, 25): 1,
  };
  StartingDayOfWeek getStartingDay() {
    DateTime now = DateTime.now();
    int weekday = now.weekday;
    // DateTime.weekday는 월요일이 1, 일요일이 7
    int startDayOffset = (weekday - 4).abs() % 7; // 오늘로부터 시작 요일까지의 거리 계산
    StartingDayOfWeek startingDay;

    switch (startDayOffset) {
      case 0:
        startingDay = StartingDayOfWeek.monday;
        break;
      case 1:
        startingDay = StartingDayOfWeek.tuesday;
        break;
      case 2:
        startingDay = StartingDayOfWeek.wednesday;
        break;
      case 3:
        startingDay = StartingDayOfWeek.thursday;
        break;
      case 4:
        startingDay = StartingDayOfWeek.friday;
        break;
      case 5:
        startingDay = StartingDayOfWeek.saturday;
        break;
      case 6:
        startingDay = StartingDayOfWeek.sunday;
        break;
      default:
        startingDay = StartingDayOfWeek.monday; // 기본값 설정
    }

    return startingDay;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
            });
          },
          headerVisible: false,
          daysOfWeekHeight: 24,
          startingDayOfWeek: getStartingDay(),
          calendarFormat: CalendarFormat.week,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: MyTextStyles.b4,
            weekendStyle: MyTextStyles.b4
          ),
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (context, day, focusedDay) {
              return Container(
                decoration: BoxDecoration(
                  color: MyColors.dark_beige,
                  borderRadius: BorderRadius.circular(8)
                ),
              );
            },
            markerBuilder: (context, date, events) {
              double completionRate = todoDoneRatio[date] ?? 0; //null 이라면 0넣기
              return _buildCompletionMarker(completionRate,date);
            },
          ),
          focusedDay: _selectedDay, 
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          // 다른 달력 설정...
        ),
        Text('${_selectedDay}의 데이터 로드')
      ],
    );
  }
  Widget _buildCompletionMarker(double completionRate, DateTime date) {
    Color color = Colors.red;
    if (completionRate > 0.75) {
      color = Colors.green; // 높은 완료율
    } else if (completionRate >= 0.5) {
      color = Colors.orange; // 중간 완료율
    }

    if (date.isAfter(DateTime.now())){
      color = MyColors.dark_beige;
    }
    return Padding(
      padding: date.day == DateTime.now().day ? EdgeInsets.all(2) : EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child:Text('${date.day}',style: MyTextStyles.b4.copyWith(color: MyColors.black.withOpacity(0.5),)),
        ),
      ),
    );
  }
}