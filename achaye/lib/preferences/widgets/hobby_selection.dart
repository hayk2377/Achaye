import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../preferences_bloc/preferences_bloc.dart';


class HobbySelection extends StatelessWidget {
  List _hobby_list = [
    '⚽ Sports',
    '🎆 Anime',
    '📺 Series',
    '🍿 Movies',
    '📚 Books',
    '🍳 Cooking',
    '🥂 Party',
    '👗 Fashion',
    '🎮 Games',
    '🎨 Art',
    '💻 Coding'
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<PreferencesBloc>();
    final state = bloc.state;
    print(state);

    if (state is PreferencesInitial) {
      bloc.add(PreferencesInitialEvent());
      return CupertinoActivityIndicator();
    } else if (state is PreferencesSelection) {
      return Wrap(
        children: _hobby_list
            .map((e) => Container(
                  padding: EdgeInsets.all(5),
                  child: ChoiceChip(
                    elevation: 5,
                    selectedColor: Color(0xFFFF7F50),
                    label: Text(e),
                    selected: state.choices.contains(e),
                    onSelected: (selectedValue) {
                      bloc.add(PreferencesSelectionEvent(e));
                    },
                  ),
                ))
            .toList(),
      );
    }
    return Container();
  }
}
