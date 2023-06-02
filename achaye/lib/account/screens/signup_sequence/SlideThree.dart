import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class SlideThree extends StatefulWidget {

  Map<String, Object> userData;

  SlideThree({Key? key, required this.userData})
      : super(key: key);

  @override
  _SlideThreeState createState() => _SlideThreeState();
}

class _SlideThreeState extends State<SlideThree> {
  List<String> interests = [];
  String? selectedReligion;
  String bio = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        backgroundColor: Color(0xFFFF7F50),
      ),
      body: Card(
        elevation: 5,
        shadowColor: Colors.blue.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:Form(
          key:_formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Step 3: additional informations',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
              'Bio:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                setState(() {
                  bio = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your bio',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Religion:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedReligion,
              hint: const Text('Select Religion'),
              onChanged: (newValue) {
                setState(() {
                  selectedReligion = newValue!;
                });
              },
              items: const [
                DropdownMenuItem<String>(
                  value: 'Orthodox',
                  child: Text('Orthodox'),
                ),
                DropdownMenuItem<String>(
                  value: 'Muslim',
                  child: Text('Muslim'),
                ),
                DropdownMenuItem<String>(
                  value: 'Catholic',
                  child: Text('Catholic'),
                ),
                DropdownMenuItem<String>(
                  value: 'Protestant',
                  child: Text('Protestant'),
                ),
                DropdownMenuItem<String>(
                  value: 'Other',
                  child: Text('Other'),
                ),
                DropdownMenuItem<String>(
                  value: 'Atheist',
                  child: Text('Atheist'),
                ),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a religion';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Hobbies:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
               _buildChoiceButton( '🎆 Anime',),
               _buildChoiceButton('⚽️ Sports',),
               _buildChoiceButton('📺 Series',),
               _buildChoiceButton('🎨 Art'),
               _buildChoiceButton('🍿 Movies',),
               _buildChoiceButton('📚 Books',),
               _buildChoiceButton('🍳 Cooking',),
               _buildChoiceButton('🥂 Party',),
               _buildChoiceButton('👗 Fashion',),
               _buildChoiceButton('🎮 Games',),
               _buildChoiceButton( '💻 Coding'),

              ],
            ),
            const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed:(){
                      context.go('/pagetwo');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF7F50)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: const Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                        final form = _formKey.currentState;
                        if (form!.validate()) {
                          if (interests.length==5) {
                            widget.userData['hobbies'] = interests;
                            widget.userData['religion'] = selectedReligion as Object;
                            widget.userData['bio'] = bio;
                             context.go('/pageimage');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please make sure to select five hobbies'),
                              ),
                            );
                          }
                        }
                      },

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),);
  }
  Widget _buildChoiceButton(String choice) {
    bool isSelected = interests.contains(choice);
    
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (isSelected) {
            interests.remove(choice);
          } else {
            if (interests.length < 5) {
              interests.add(choice);
            } else {
              // Display an error message or handle maximum selections
              print('Maximum selections reached!');
            }
          }
        });
      },
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        side: BorderSide.none,
        backgroundColor: isSelected ? Color(0xFFFF7F50): Colors.grey, // Set the button's background color
      ),
      child: Text(
        choice,
        style: const TextStyle(
          color:  Colors.black,
        ),
      ),
    );
  }
}
