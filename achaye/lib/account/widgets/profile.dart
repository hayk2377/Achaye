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
          style: Theme.of(context).textTheme.headline4,
        ),
        elevation: 0,
        backgroundColor: Color(0xFFFF7F50),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('images/girlfour.jpg', fit:BoxFit.cover,)),
              ),
            ),
            const SizedBox(height: 10,),
            Text("Pam", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("pamelabeesly@gmail.com", style: TextStyle(fontSize: 12, color: Colors.grey))
          ]),
        ),
      ),
    );
  }
}
