import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  final ValueChanged<String> onNumberSelected;

  NumberPad({required this.onNumberSelected});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.7,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        String number;
        if (index < 9) {
          number = '${index + 1}';
        } else if (index == 9) {
          number = 'Clear'; // Clear button
        } else if (index == 10) {
          number = '0';
        } else {
          number = '<';
        }

        return InkWell(
          onTap: () {
            if (number == 'Clear') {
              onNumberSelected('C'); // Custom signal for clearing input
            } else {
              onNumberSelected(number == '<' ? '-1' : number);
            }
          },
          child: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Color(0XFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 24,
                  color: number == 'Clear' ? Colors.red : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
