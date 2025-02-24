import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  // ... (existing code)
}

class _HomeScreenState extends State<HomeScreen> {
  // ... (existing code)

  @override
  Widget build(BuildContext context) {
    // ... (existing code)

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationBarIndex,
        backgroundColor: Theme.of(context).colorScheme.surface,
        fixedColor: Theme.of(context).colorScheme.inversePrimary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              PariyattiIcons.get(IconName.today),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            activeIcon: Icon(
              PariyattiIcons.get(IconName.today),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            label: I18n.get("today")
          ),
          BottomNavigationBarItem(
            icon: Icon(
              PariyattiIcons.get(IconName.person),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            activeIcon: Icon(
              PariyattiIcons.get(IconName.person),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            label: I18n.get("account")
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.volunteer_activism,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              activeIcon: Icon(
                Icons.volunteer_activism,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              label: I18n.get("donate")
          ),
        ],
        onTap: (int tappedItemIndex) {
          this.setState(() {
            this._tab = HomeScreenTab.values[tappedItemIndex];
          });
        },
      ),
    );
  }
} 