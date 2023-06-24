import 'package:flutter/material.dart';

class MyDateField extends StatelessWidget {
  final String labelText;
  final ValueChanged<DateTime?> onChanged;
  final FormFieldValidator<DateTime>? validator;

  final DateTime? selectedDate;

  const MyDateField({
    Key? key,
    required this.labelText,
    required this.onChanged,
    this.validator,
    this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: ListTile(
        
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                labelText,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 13.0,
                  color: Colors.grey[600],
                ),
              ),
            ),
            selectedDate != null
                ? Text(
                    '${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  )
                : const Text(
                    'Seleccionar fecha',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
          ],
        ),
        trailing: const Icon(Icons.calendar_today),
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ).then((selectedDate) {
            if (selectedDate != null) {
              onChanged(selectedDate);
            }
          });
        },
      ),
    );
  }
}
