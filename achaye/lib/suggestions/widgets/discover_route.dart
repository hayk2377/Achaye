import 'package:achaye/suggestions/widgets/profilecard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../swiping/bloc/swiping_bloc.dart';
import 'package:flutter/material.dart';

import 'discover_outline.dart';

class Discover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BackgroundCurveWidget(),
            MainSwipingWidget(),
          ],
        ),
      ),
    );
  }
}

class MainSwipingWidget extends StatelessWidget {
  const MainSwipingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SwipingBloc>();
    final state = bloc.state;
    if (state is SwipingInitial) {
      bloc.add(GiveMeData());
      return Container();
    } else if (state is SwipingLoading) {
      return const Center(child: CupertinoActivityIndicator());
    } else if (state is SwipingError) {
      return Center(
          child: TextButton(
        child: Text(state.toString()),
        onPressed: () => bloc.add(
          GiveMeData(),
        ),
      ));
    } else if (state is SwipingLoaded) {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 150),
        child: Dismissible(
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                bloc.add(SwipeRight());
              } else if (direction == DismissDirection.endToStart) {
                bloc.add(SwipeLeft());
              }
            },
            key: Key(state.profiles[state.index].id.toString()),
            child: ProfileCard(
              profile: (state as SwipingLoaded)
                  .profiles[(state as SwipingLoaded).index],
            )),
      );
    } else if (state is NoMoreMatches) {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 280),
        child: Text(
          "It's like a desert in here...",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
        ),
      );
    }
    return Container();
  }
}
