import 'package:age_calculator/age_calculator.dart';
import 'package:age_calculator/duration_model.dart';
import 'package:flutter/material.dart';

import 'age_model.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  BuildContext context;
  Age _userAge = Age();
  Duration _nextBirthDay = Duration();

  final TextEditingController _dateOfBirthController =
      TextEditingController(text: "01-01-2000");

  final TextEditingController _todayDateController =
      TextEditingController(text: "01-01-2020");

  DateTime dateOfBirth;
  DateTime futureDate;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    Widget _dateOfBirthHeading = _buildHeading("Date of Birth");
    Widget _birthDateTextField = _buildBirthDateTextField();
    Widget _todayDateHeading = _buildHeading("Today Date");
    Widget _todayDateTextField = _buildTodayDateTextField();

    Widget _clearCalculateButtonsRow = _buildClearCalcButtonsRow();
    Widget _ageOutputHeading = _buildHeading("Age is");
    Widget _ageOutputRow = _buildAgeOutputRow();
    Widget _nextBirthDayHeading = _buildHeading("Next Birth Day in");
    Widget _nextBirthOutputRow = _buildNextBirthDayOutputRow();
    Widget _emptyBox = SizedBox(height: 20);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _dateOfBirthHeading,
            _birthDateTextField,
            _emptyBox,
            _todayDateHeading,
            _todayDateTextField,
            _emptyBox,
            _clearCalculateButtonsRow,
            _emptyBox,
            _ageOutputHeading,
            _ageOutputRow,
            _emptyBox,
            _nextBirthDayHeading,
            _nextBirthOutputRow,
          ],
        ),
      ),
    );
  }

  Widget _buildOutputField(String outputTitle, String outputData) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          width: 115,
          height: 30,
          child: Center(
              child: Text(
            outputTitle,
            style: TextStyle(color: Colors.white),
          )),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor)),
          width: 115,
          height: 30,
          child: Center(
              child: Text(
            outputData,
            style: TextStyle(color: Colors.grey),
          )),
        )
      ],
    );
  }

  Widget _buildHeading(String headingTitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        headingTitle,
        style: TextStyle(fontSize: 20, color: Colors.grey),
      ),
    );
  }

  InputDecoration _getTextFieldWithCalendarIconDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      suffixIcon: Icon(
        Icons.date_range,
        color: Theme.of(context).primaryColor,
      ),
      hintText: '2017-04-10',
    );
  }

  Widget _buildBirthDateTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          showCursor: true,
          readOnly: true,
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1940),
                    lastDate: DateTime.now())
                .then((date) {
              //code to handle date
              print(date.toString());
            });
          },
          controller: _dateOfBirthController,
          decoration: _getTextFieldWithCalendarIconDecoration(),
        )
      ],
    );
  }

  Widget _buildTodayDateTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          showCursor: true,
          readOnly: true,
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1940),
                    lastDate: DateTime.now())
                .then((date) {
              print(date.toString());
            });
          },
          controller: _todayDateController,
          decoration: _getTextFieldWithCalendarIconDecoration(),
        )
      ],
    );
  }

  Widget _buildClearButton() {
    return ButtonTheme(
      minWidth: 160,
      height: 60,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {},
        child:
            Text('CLEAR', style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget _buildCalculateButton() {
    return ButtonTheme(
      minWidth: 160,
      height: 60,
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Age _test = AgeCalaculator().calculateAge(dateOfBirth, futureDate);
          print(_test);
        },
        child: Text('CALCULATE',
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget _buildClearCalcButtonsRow() {
    Widget _clearOrangeButton = _buildClearButton();
    Widget _calcOrangeButton = _buildCalculateButton();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _clearOrangeButton,
        _calcOrangeButton,
      ],
    );
  }

  Widget _buildAgeOutputRow() {
    Widget _ageYearsOutputField =
        _buildOutputField("Years", _userAge.years.toString());
    Widget _ageMonthsOutputField =
        _buildOutputField("Months", _userAge.months.toString());
    Widget _ageDaysOutputField =
        _buildOutputField("Days", _userAge.day.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _ageYearsOutputField,
        _ageMonthsOutputField,
        _ageDaysOutputField,
      ],
    );
  }

  Widget _buildNextBirthDayOutputRow() {
    Widget _nextBirthYearsOutputField = _buildOutputField("Years", "-");
    Widget _nextBirthMonthsOutputField =
        _buildOutputField("Months", _nextBirthDay.months.toString());
    Widget _nextBirthDaysOutputField =
        _buildOutputField("Days", _nextBirthDay.days.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _nextBirthYearsOutputField,
        _nextBirthMonthsOutputField,
        _nextBirthDaysOutputField,
      ],
    );
  }
}
