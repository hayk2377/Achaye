import 'package:achaye/common/options_dialog.dart';
import 'package:achaye/matching/end_to_end_chat/bloc/chat_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFFF7F50),
          actions: [
            OptionsDialog()
          ],
          flexibleSpace: SafeArea(
              child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => context.go('/chat_list'),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  child: SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipOval(
                          child: Image.asset(
                        'images/girlfour.jpg',
                        fit: BoxFit.cover,
                      ))),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Text('Pam',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ))),
              ],
            ),
          )),
        ),
        body: ChatBody());
  }
}

class ChatBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ChatBloc>();
    final state = bloc.state;

    if (state is ChatInitial) {
      bloc.add(GiveMeData());
      return Container();
    } else if (state is ChatLoading) {
      return Align(
        alignment: Alignment.center,
        child: CupertinoActivityIndicator(),
      );
    } else if (state is ChatLoaded) {
      return Stack(
        children: [
          ListView.builder(
            itemCount: state.messages.length,
            padding: EdgeInsets.only(top: 10, bottom: 50),
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
              child: InkWell(
                onTap: () => bloc.add(TextArrival()),
                child: Align(
                    alignment: (state.messages[index].sentBySelf
                        ? Alignment.topRight
                        : Alignment.topLeft),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (!state.messages[index].sentBySelf
                            ? Colors.grey.shade200
                            : Colors.orange[200]),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        state.messages[index].content,
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 45,
                  ),
                  Expanded(
                    child: TextField(
                      controller: state.writtenMessage,
                      decoration: InputDecoration(
                          hintText: "Write a message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (state.writtenMessage.text.length == 0) {
                        print('Can\'t send a null message');
                      } else {
                        bloc.add(TextSent());
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.orange,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
    throw Exception("Unrecognized state used");
  }
}
