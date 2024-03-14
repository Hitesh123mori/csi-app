import 'package:csi_app/models/event_model/event_model.dart';
import 'package:flutter/material.dart';


class AddEventScreen extends StatefulWidget {
  final Function(Event) onEventAdded;

  const AddEventScreen({Key? key, required this.onEventAdded}) : super(key: key);

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );
    if (pickedStartTime != null && pickedStartTime != _selectedStartTime) {
      setState(() {
        _selectedStartTime = pickedStartTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );
    if (pickedEndTime != null && pickedEndTime != _selectedEndTime) {
      setState(() {
        _selectedEndTime = pickedEndTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
                SizedBox(width: 8),
                Text('Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () => _selectStartTime(context),
                  child: Text('Select Start Time'),
                ),
                SizedBox(width: 8),
                Text('Start Time: ${_selectedStartTime.hour}:${_selectedStartTime.minute}'),
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () => _selectEndTime(context),
                  child: Text('Select End Time'),
                ),
                SizedBox(width: 8),
                Text('End Time: ${_selectedEndTime.hour}:${_selectedEndTime.minute}'),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final newEvent = Event(
                  eventName: titleController.text,
                  description: descriptionController.text,
                  startTime: DateTime(
                    _selectedDate.year,
                    _selectedDate.month,
                    _selectedDate.day,
                    _selectedStartTime.hour,
                    _selectedStartTime.minute,
                  ),
                  endTime: DateTime(
                    _selectedDate.year,
                    _selectedDate.month,
                    _selectedDate.day,
                    _selectedEndTime.hour,
                    _selectedEndTime.minute,
                  ),
                );
                widget.onEventAdded(newEvent);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
