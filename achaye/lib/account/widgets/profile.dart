import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(children: [
            CustomRoundedImage(),
            const SizedBox(
              height: 10,
            ),
            Text("Pam",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("pamelabeesly@gmail.com",
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
              onPress: () {},
              title: "Delete account",
              icon: Icons.delete,
              textColor: Color(0xFFF82A1C),
            ),
          ]),
        ),
      ),
    );
  }
}

class CustomRoundedImage extends StatelessWidget {
  const CustomRoundedImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'images/girlfour.jpg',
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}

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
