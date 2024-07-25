import 'package:flutter/material.dart';

import '../../../custom_exception/custom_exception.dart';
import '../../models/employee_data.dart';
import 'numpad.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController pinController;
  String? selectedEmployee;

  LoginForm({required this.pinController, this.selectedEmployee});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final Color primaryAccentColor = Color(0xFFCCE8F6); // Initial Primary Accent color
  final Color primaryColor = Color(0xFF008BD0); // Primary color
  final Color secondaryColor = Color(0xFF84AE2B); // Secondary color
  final Color errorColor = Color(0xFFDE0B1C); // Error color

  List<Color> _pinColors = List.filled(4, Color(0xFFCCE8F6));

  void _showEmployeeModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.close, color: Colors.red),
              title: Text('Select An Employee', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () => Navigator.pop(context),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0), // or 15.0
                      child: Container(
                        height: 45.0,
                        width: 45.0,
                        color: _getAvatarColor(index),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
                          child: Text(
                            '${employees[index].name[0]}${employees[index].name.split(" ").last[0]}',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    title: Text(employees[index].name),
                    onTap: () {
                      setState(() {
                        widget.selectedEmployee = employees[index].name;
                        widget.pinController.clear();
                        _pinColors = List.filled(4, primaryAccentColor); // Reset pin dots color
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Color _getAvatarColor(int index) {
    List<Color> colors = [
      Color(0XFF008BD0),
      Color(0XFF1A887A),
      Color(0XFF84AE2B),
      Color(0XFFF26611),
      Color(0XFFDE0B1C)
    ];
    return colors[index % colors.length];
  }

  void _updatePinDots(String pin) {
    setState(() {
      for (int i = 0; i < 4; i++) {
        if (i < pin.length) {
          _pinColors[i] = primaryColor; // Primary color
        } else {
          _pinColors[i] = primaryAccentColor; // Primary Accent color
        }
      }
    });
  }

  void _showAppInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'App Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
                child: Container(
                  margin: EdgeInsets.all(4.0),
                  color: Color(0XFFF5F5F5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Version 6.6.5', style: TextStyle(fontSize: 12)),
                        SizedBox(height: 8),
                        Text('Production', style: TextStyle(fontSize: 12)),
                        SizedBox(height: 8),
                        Text('Device ID: ACEHFJDJ3-DJUFG-SJHFS-B4Y5S', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0XFFF26611),
                  backgroundColor: Color(0XFFFEF0E7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Reset app functionality
                },
                icon: Icon(Icons.refresh),
                label: Text('Reset App'),
              ),
            ],
          ),
        );
      },
    );
  }

  bool loggedIn = false;
  void _validatePin() {
    if (widget.selectedEmployee != null) {
      final user = employees.firstWhere(
            (user) => user.name == widget.selectedEmployee,
        orElse: () => throw UserNotFoundException("No User Found"),
      );
      setState(() {
        if (user != null && user.pin == widget.pinController.text) {
          _pinColors = List.filled(4, secondaryColor);
          setState(() {
            loggedIn = true;
          }); // Secondary color for success
        } else {
          _pinColors = List.filled(4, errorColor); // Error color for failure
        }
      });
    }
  }

  String title = "Jims' Place";
  String subtitle = "22 Button Road";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      height: 45.0,
                      width: 45.0,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                        child: Text(
                          '${title[0]}${title.split(" ").last[0]}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$title",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                            textAlign: TextAlign.start),
                        Text(
                          "$subtitle",
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                              fontSize: 12),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // This is the inkwell with the that pops up the alert dialog
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
                child: Container(
                  height: 36,
                  width: 36,
                  color: Color(0XFF36505c),
                  child: InkWell(
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    onTap: () => _showAppInfoDialog(context),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            "Hi there, let’s get you logged in.",
            style: TextStyle(
                color: Colors.white,
                fontSize: 33,
                fontWeight: FontWeight.w300),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => _showEmployeeModal(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(widget.selectedEmployee ?? 'Select Employee',
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.blue),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.lock, color: Colors.blue),
                SizedBox(width: 10),
                Text('Pin:', style: TextStyle(color: Colors.black)),
                Spacer(),
                ...List.generate(4, (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: _pinColors[index],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Container(
            margin: EdgeInsets.all(2),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Color(0XFFF5F5F5),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: NumberPad(
              onNumberSelected: (number) {
                if (number == '-1') {
                  if (widget.pinController.text.isNotEmpty) {
                    widget.pinController.text = widget.pinController.text
                        .substring(0, widget.pinController.text.length - 1);
                    _updatePinDots(widget.pinController.text);
                  }
                } else if (number == 'C') {
                  widget.pinController.clear();
                  _pinColors = List.filled(4, primaryAccentColor); // Reset pin colors
                  setState(() {}); // Update the UI
                } else {
                  if (widget.pinController.text.length < 4) {
                    widget.pinController.text += number;
                    _updatePinDots(widget.pinController.text);
                    if (widget.pinController.text.length == 4) {
                      _validatePin();
                    }
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}