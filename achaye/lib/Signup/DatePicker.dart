
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateChanged;

  DatePicker({required this.selectedDate, required this.onDateChanged});

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateChanged(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Birthdate',
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(widget.selectedDate!)
                  : 'Select a date',
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}
