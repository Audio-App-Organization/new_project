import 'package:flutter/material.dart';
import 'package:new_project/Diagnosisreport.dart';
import 'package:new_project/Searchpatient.dart';
import 'package:new_project/login.dart';
import 'package:new_project/addPatient.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Implement logout functionality here
                // After logout, you can navigate to the login screen or perform other actions
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Loginpage())); // Close the dialog
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patients"), actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Searchpatient()));
          },
        )
      ]),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Your Name"),
              accountEmail: Text("your@email.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/man.png"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the profile page or perform other actions here
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Manage Account"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the settings page or perform other actions here
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                _showLogoutDialog(context); // Close the drawer
                // Implement logout functionality here
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            _buildPatientCard("John Doe"),
            _buildPatientCard("Jane Smith"),
            // Add more _buildPatientCard widgets as needed
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddPatient()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget _buildPatientCard(String patientName) {
  return Card(
    child: ListTile(
      title: Text(patientName),
      // Add more patient information or actions here if needed
    ),
  );
}
