import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'app_state.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  // Map<DateTime, List<String>> selectedEvents = {};
  Map<String, List<String>> selectedEvents = {};
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   selectedEvents = {};
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (context, appState, _) {
      selectedEvents = {};
      for (var event in appState.events) {
        if (selectedEvents
            .containsKey(DateFormat('yyyy-MM-dd').format(event.date))) {
          List<String> oldList =
              selectedEvents[DateFormat('yyyy-MM-dd').format(event.date)]!;
          oldList.add(event.keyword);
          selectedEvents
              .addAll({DateFormat('yyyy-MM-dd').format(event.date): oldList});
        } else {
          selectedEvents.addAll({
            DateFormat('yyyy-MM-dd').format(event.date): [event.keyword]
          });
        }
      }
      print('events: ${appState.events}');
      print('selected events: $selectedEvents');

      List<String> getEventsFromDay(DateTime date) {
        return selectedEvents[DateFormat('yyyy-MM-dd').format(date)] ?? [];
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('검색기록'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            TableCalendar(
              locale: 'ko_KR',
              headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2023, 12, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              selectedDayPredicate: (DateTime date) {
                return isSameDay(_selectedDay, date);
              },
              onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                setState(() {
                  // today = day;
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
              // eventLoader: getEventsFromDay,
            ),
            ...getEventsFromDay(_selectedDay).map(
              (String e) => ListTile(title: Text(e)),
            )
          ],
        ),
      );
    });
  }
}
