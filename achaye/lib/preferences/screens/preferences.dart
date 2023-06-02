import 'package:achaye/matching/blocs/swiping_bloc.dart';
import 'package:achaye/preferences/blocs/preferences_bloc.dart';
import 'package:achaye/preferences/widgets/hobby_selection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PreferenceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Preferences"),
          leading: BackButton(
            onPressed: () => context.pop(),
          ),
          backgroundColor: Color(0xFFFF7F50),
        ),
        body: SingleChildScrollView(
          child: PreferencesBox(),
        ));
  }
}

class PreferencesBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preferencesBloc = context.watch<PreferencesBloc>();
    final swipingBloc = context.read<SwipingBloc>();
    // final state = preferencesBloc.state;

    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Enter the religon for your pontential match"),
          SizedBox(
            height: 15,
          ),
          CustomDropDown(),
          SizedBox(
            height: 25,
          ),
          MultiSelectChip(),
          SizedBox(
            height: 25,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 5.0)
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                colors: [
                  Colors.deepOrange.shade400,
                  Colors.deepOrange.shade200,
                ],
              ),
              color: Colors.deepOrange.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            width: 180,
            child: SizedBox(
              width: 180,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                    onPressed: () {
                      /////////////////////////////////////////////////////////////////////////////////////////////
                      preferencesBloc.add(PreferenceSubmitEvent());
                      swipingBloc.add(GiveMeData());
                      context.go('/discover');
                    },
                    child: Text("Submit"),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CustomDropDownState();
  }
}

class _CustomDropDownState extends State<CustomDropDown> {
  List<String> _religion_preferences = [
    'Orthodox',
    'Catholic',
    'Protestant',
    'Muslim',
    'Other',
    'I don\'t mind',
    'abc'
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<PreferencesBloc>();
    final state = bloc.state;

    if (state is PreferencesInitial) {
      bloc.add(PreferencesInitialEvent());
      return Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Color(0xFFFF7F50),
        ),
      );
    } else if (state is PreferencesSelection) {
      String _preferences = state.religionChoice;
      return Container(
        width: 300,
        margin: EdgeInsets.only(left: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.orange, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                items: _religion_preferences.map((value) {
                  return DropdownMenuItem(
                    child: Text(
                      value,
                      style: TextStyle(),
                    ),
                    value: value,
                  );
                }).toList(),
                value: _preferences,
                onChanged: (String? value) {
                  if (value != null) {
                    bloc.add(ReligionSelectionEvent(value));
                  }
                },
                isExpanded: true,
                iconSize: 32,
                underline: null,
                iconEnabledColor: Colors.black,
              ),
            ),
          ),
        ),
      );
    }
    throw Exception("Unhandled state");
  }
}

class MultiSelectChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hobbies',
          style: TextStyle(
              fontFamily: 'Nunito', fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Choose a maximum of 5')),
        SizedBox(
          height: 20,
        ),
        HobbySelection()
      ],
    );
  }
}
