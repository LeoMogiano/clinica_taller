import 'package:flutter/material.dart';

class MyTimeField extends StatelessWidget {
  final String labelText;
  final ValueChanged<TimeOfDay?> onChanged;
  final FormFieldValidator<TimeOfDay>? validator;
  final TimeOfDay? selectedTime;

  const MyTimeField({
    Key? key,
    required this.labelText,
    required this.onChanged,
    this.validator,
    this.selectedTime,
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
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 13.0,
                  color: Colors.grey,
                ),
              ),
            ),
            selectedTime != null
                ? Text(
                    selectedTime!.format(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  )
                : const Text(
                    'Seleccionar hora',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
          ],
        ),
        trailing: const Icon(Icons.access_time),
        onTap: () {
          showTimePicker(
            context: context,
            initialTime: selectedTime ?? TimeOfDay.now(),
          ).then((selectedTime) {
            if (selectedTime != null) {
              onChanged(selectedTime);
            }
          });
        },
      ),
    );
  }
}
