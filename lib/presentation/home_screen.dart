import 'package:accident_identifier/presentation/auth/authenticate.dart';
import 'package:accident_identifier/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accident_identifier/presentation/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text(
        'Home',
      ),
    ),
    Center(
      child: Text(
        'Contacts',
      ),
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accident Identifier"),
        actions: [
          Consumer(
            builder: (context, watch, child) {
              final _auth = watch(authServicesProvider);

              return IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    _auth.signOut().then((value) {
                      if (value == true)
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Authenticate()));
                    });
                  });
            },
          )
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
