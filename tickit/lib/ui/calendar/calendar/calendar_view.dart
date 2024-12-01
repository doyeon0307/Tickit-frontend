import 'package:flutter/material.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final markedDates = {
      DateTime(2024, 8, 29): Image.asset(
        'assets/image/hades.jpg',
        fit: BoxFit.cover,
      ),
      DateTime(2024, 8, 12): const Text(
        '도쿄여행!',
        style: TextStyle(fontSize: 10),
      ),
    };
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomCalendar(
                selectedDate: DateTime(2024, 8),
                markedDates: markedDates,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Map<DateTime, Widget> markedDates;

  const CustomCalendar({
    super.key,
    required this.selectedDate,
    this.markedDates = const {},
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final weeksInMonth = _getWeeksInMonth();

    final gridHeight = screenHeight - 220;
    final cellHeight = gridHeight / weeksInMonth;

    return Column(
      children: [
        // 년월 표시
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '${selectedDate.year}년 ${selectedDate.month}월',
            style: Typo.pretendardSB24.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
        ),

        // 요일 헤더
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: Typo.pretendardR12.copyWith(
                          color: AppColors.calendarDateColor,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio:
                MediaQuery.of(context).size.width / 7 / cellHeight,
          ),
          itemCount: _getDaysInMonth(),
          itemBuilder: (context, index) {
            final date = _getDateFromIndex(index);
            final hasMarker = markedDates.containsKey(date);

            if (date.month != selectedDate.month) {
              return Container();
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 12.0,
                  ),
                  child: Text(
                    date.day.toString(),
                    style: Typo.pretendardR8.copyWith(
                      color: AppColors.calendarDateColor,
                    ),
                  ),
                ),
                if (hasMarker)
                  Container(
                    child: markedDates[date]!,
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  // 해당 월의 주 수 계산
  int _getWeeksInMonth() {
    final firstDay = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDay = DateTime(selectedDate.year, selectedDate.month + 1, 0);

    // 첫째 주의 시작일과 마지막 주의 마지막일을 구함
    final firstDayOffset = firstDay.weekday - 1; // 0 = 월요일, 6 = 일요일
    final totalDays = firstDayOffset + lastDay.day;

    return (totalDays / 7).ceil(); // 전체 일수를 7로 나누어 올림하여 주 수 계산
  }

  int _getDaysInMonth() {
    final weeksInMonth = _getWeeksInMonth();
    return weeksInMonth * 7; // 실제 주 수 * 7
  }

  DateTime _getDateFromIndex(int index) {
    final firstDay = DateTime(selectedDate.year, selectedDate.month, 1);
    final diff = index - (firstDay.weekday - 1);
    return DateTime(selectedDate.year, selectedDate.month, diff);
  }
}
