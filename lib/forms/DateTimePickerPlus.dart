import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class DateTimePickerPlus extends StatefulWidget {
  const DateTimePickerPlus({super.key});

  @override
  DateTimePickerPlusState createState() => DateTimePickerPlusState();
}

class DateTimePickerPlusState extends State<DateTimePickerPlus> {
  final format = DateFormat('yyyy-MM-dd HH:mm:ss');
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      decoration: const InputDecoration(
        labelText: 'Select Date and Time',
        border: OutlineInputBorder(),
      ),
      format: format,
      onChanged: (value) {
        setState(() {
          selectedDateTime = value;
        });
      },
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
          context: context,
          initialDate: currentValue ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );

          // Combine the selected date and time into a DateTime object
          if (time != null) {
            return DateTimeField.combine(date, time);
          }
        }

        return currentValue;
      },
    );
  }
}
