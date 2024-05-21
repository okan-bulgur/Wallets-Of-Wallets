// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, sort_child_properties_last, prefer_const_literals_to_create_immutables
import 'package:firstly/data_base_manager.dart';
import 'package:firstly/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firstly/main_page.dart'; // Replace this import with your actual main page import
import 'package:image_picker/image_picker.dart';



class ProfileSettings extends StatelessWidget {

  final Color customColor = Color(0xFF0A5440);
  static bool isUploaded = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  // Get the current user's email

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: customColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async{
              // Add your logic here to handle the avatar change

                ImagePicker imagePicker = ImagePicker();
                //limit the size of the image to 1MB
                XFile? file = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 1024, maxWidth: 1024);

                if (file == null) return;
                UsersTableManager.updateUserPhoto(context, file);

                //create pop up to show the user that the image is being uploaded with 5 seconds delay and make it uncloseable
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Uploading Image'),
                      content: Text('Please wait while the image is being uploaded'),
                    );
                  },
                );
                
                //Future.delayed(Duration(seconds: 1));
                while (!isUploaded) {
                  await Future.delayed(Duration(milliseconds: 500));
                }
                isUploaded = false;

                //close the pop up
                Navigator.pop(context);


                //return to the profile page
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );


              },
              child: CircleAvatar(
                radius: 65,
                //get Image from the database
                backgroundImage: userPhoto!.isEmpty ? AssetImage('assets/anonymous.png') as ImageProvider<Object> : NetworkImage(userPhoto!),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.add,
                      size: 40,
                      color: customColor,
                    ),
                  ),
              ),
            ),
            SizedBox(height: 40.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                          maxLength: 10,
                          controller: firstNameController,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            filled: true,
                            fillColor: Color.fromARGB(100, 150, 150, 150),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                          ),
                          onChanged: (value) {
                          },
                        ),
                  ),

                  SizedBox(width: 10.0),
                  
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        UsersTableManager.updateUserName(context,userEmail!, firstNameController.text.trim());
                        TransactionTableManager.updateTransactionName(context, userEmail!, firstNameController.text.trim());
                      },
                      child: Text(
                        'Set',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                          maxLength: 10,
                          controller: surnameController,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            filled: true,
                            fillColor: Color.fromARGB(100, 150, 150, 150),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                          ),
                          onChanged: (value) {
                          },
                        ),
                  ),

                  SizedBox(width: 10.0),
                  
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        UsersTableManager.updateUserSurname(context,userEmail!, surnameController.text.trim());
                      },
                      child: Text(
                        'Set',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30.0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.close, size: 30.0),
            label: 'Cancel',
          ),
        ],
        
        selectedItemColor: customColor, // Set color for selected icon
        selectedFontSize: double.parse('14.5'), // Set font size for selected label
        
        showUnselectedLabels: true,
        unselectedItemColor: customColor, // Set color for unselected icon
        unselectedFontSize: double.parse('14.5'), // Set font size for unselected label
        unselectedLabelStyle: TextStyle(color: customColor), // Set color for unselected label

        onTap: (index) {
          // Add navigation logic based on the index of tapped item
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()), // Replace MainPage() with your main page widget
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()), // return to the profile page
            );
          }
        },
      ),
    );
  } 
}


