import 'package:achaye/account/account.dart';
import 'package:achaye/account/blocs/edit_profile_bloc.dart';
import 'package:achaye/account/widgets/custom_rounded_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EditProfileBloc(context.read<AccountRepository>()),
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: () => context.pop()),
            title: Text(
              "Edit Profile",
            ),
            elevation: 0,
            backgroundColor: Color(0xFFFF7F50),
          ),
          body: EditedProfileBody(),
        ));
  }
}

class EditedProfileBody extends StatelessWidget {
  const EditedProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditProfileBloc>();

    return BlocConsumer<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          context.go('/discover');
        }
      },
      builder: (context, state) {
        if (state is EditProfileInitial) {
          bloc.add(FetchExistingData());
          return Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: Color(0xFFFF7F50),
            ),
          );
        } else if (state is EditProfileDefault) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(32),
              child: Column(children: [
                CustomRoundedImage(imageUrl: state.imageUrl,),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  child: Column(
                    children: [
                      EditedInputFields(
                        isHidden: false,
                        inputFieldName: "Name",
                        icon: Icons.person_outline_rounded,
                        inputTextController: state.nameController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      EditedInputFields(
                        isHidden: true,
                        inputFieldName: "password",
                        icon: Icons.password,
                        inputTextController: state.passwordController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      EditedInputFields(
                          isHidden: false,
                          inputFieldName: "Bio",
                          icon: Icons.note_outlined,
                          inputTextController: state.bioController)
                    ],
                  ),
                ),
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
                      onPressed: () {
                        bloc.add(SubmitUpdatedData());
                        context.push('/editprofile');
                      },
                      child: Text("Update Profile"),
                    ))
              ]),
            ),
          );
        } else if (state is EditProfileSuccess) {
          return Container();
        }
        throw Exception("Unrecognized state $state it is being handled here");
      },
    );
  }
}

class EditedInputFields extends StatelessWidget {
  final IconData icon;
  final String inputFieldName;
  final bool isHidden;
  final TextEditingController inputTextController;

  const EditedInputFields({
    required this.isHidden,
    required this.inputFieldName,
    required this.icon,
    required this.inputTextController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.withOpacity(0.2)),
      child: TextFormField(
        maxLines: isHidden ? 1 : null,
        obscureText: isHidden,
        controller: this.inputTextController,
        decoration: InputDecoration(
            border: InputBorder.none,
            label: Text(this.inputFieldName),
            prefixIcon: Icon(this.icon)),
      ),
    );
  }
}
