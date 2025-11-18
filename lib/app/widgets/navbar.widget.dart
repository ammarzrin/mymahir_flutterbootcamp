import 'package:flutter/material.dart';
import 'package:myflutter_nov2025/app/views/contacts.screen.dart';
import 'package:myflutter_nov2025/app/views/layout.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // To define the current page/starting
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: [const LayoutDemo(), const ContactsScreen()][currentPageIndex],
      body: IndexedStack(
        index: currentPageIndex,
        children: const [LayoutDemo(), ContactsScreen()],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Theme.of(context).colorScheme.primary,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.contacts, color: Colors.white),
            icon: Icon(Icons.contacts_outlined),
            label: 'Contacts',
          ),
        ],
      ),
    );
  }
}
