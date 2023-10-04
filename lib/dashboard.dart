import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/addPatient.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardPage();
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("Patients"), actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ]),
      drawer: Drawer(
        child: ListView(
          children: [
            // add firebase details
            UserAccountsDrawerHeader(
              accountName: Text(user!.displayName.toString() != "" ? user.displayName.toString() : "No Name"),
              accountEmail: Text(user.email.toString() != "" ? user.email.toString() : "NoEmail"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  user.displayName.toString() != "" ? user.email.toString()[0] : "N",
                  style: TextStyle(fontSize: 40.0),
                ),
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
              onTap: () => FirebaseAuth.instance.signOut(),
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
              context, MaterialPageRoute(builder: (context) => AddPatient()));
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
