import 'package:achaye/account/blocs/profile_managing_bloc.dart';
import 'package:achaye/account/repository/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/custom_rounded_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(
          "Profile",
        ),
        elevation: 0,
        backgroundColor: Color(0xFFFF7F50),
      ),
      body: ProfileBodyScreen(),
    );
  }
}

class ProfileBodyScreen extends StatelessWidget {
  const ProfileBodyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ProfileManagingBloc(context.read<AccountRepository>()),
        child: BlocConsumer<ProfileManagingBloc, ProfileManagingState>(
            builder: (context, state) {
          final bloc = context.read<ProfileManagingBloc>();
          final state = bloc.state;

          if (state is ProfileManagingInitial) {
            bloc.add(RequestProfileData());
            return const CircularProgressIndicator(
              color: Color(0XFFFF7F50),
            );
          } else if (state is ProfileManagingLoading) {
            return const CircularProgressIndicator(
              color: Color(0xFFFF7F50),
            );
          } else if (state is ProfileManagingLoaded) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(32),
                child: Column(children: [
                  CustomRoundedImage(
                    imageUrl: state.imageUrl,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(state.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(state.email,
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF7F50),
                          side: BorderSide.none,
                          shape: StadiumBorder()),
                      onPressed: () => context.push('/editprofile'),
                      child: Text("Edit Profile"),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  ProfileOptions(
                    onPress: () {
                      context.go('/');
                    },
                    title: "Logout",
                    icon: Icons.logout,
                  ),
                  ProfileOptions(
                    onPress: () {
                      bloc.add(DeleteProfile());
                    },
                    title: "Delete account",
                    icon: Icons.delete,
                    textColor: Color(0xFFF82A1C),
                  ),
                ]),
              ),
            );
          } else if (state is ProfileManagingDeleted) {
            return Center(
              child: Text("Account Successfully Deleted"),
            );
          } else if (state is ProfileManagingLogout) {
            return Center(child: Text("Account Successfully Logged Out"));
          }
          throw Exception("Unhandled state in profile page $state");
        }, listener: (context, state) {
          if (state is ProfileManagingDeleted ||
              state is ProfileManagingLogout) {
            context.go('/');
          }
        }));
  }
}

// class ProfileBodyScreen extends StatelessWidget {
//   const ProfileBodyScreen({super.key});

// }

class ProfileOptions extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final IconData icon;
  final Color? textColor;
  const ProfileOptions({
    required this.onPress,
    required this.icon,
    this.textColor,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color(0xFF494101).withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: Color(0xFF494101),
        ),
      ),
      title: Text(
        this.title,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Nunito',
            color: this.textColor),
      ),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: const Icon(Icons.arrow_right, size: 32, color: Colors.grey),
      ),
    );
  }
}
