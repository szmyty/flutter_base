import "package:flutter/material.dart";

@visibleForTesting
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueSetter<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: "test"
        //   label: context.l10n.bottomNavBarTopStories,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.search,
            key: Key("bottomNavBar_search"),
          ),
            label: "test2"
        //   label: context.l10n.bottomNavBarSearch,
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
