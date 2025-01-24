import "package:flutter/material.dart";
import "package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart";  // Ensure correct import

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget({
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    Key? key,
  }) : super(key: key);

  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;  // Corrected: Define List<PersistentBottomNavBarItem>
  final ValueChanged<int> onItemSelected;

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                size: 26,
                color: isSelected
                    ? (item.activeColorSecondary ?? item.activeColorPrimary)
                    : item.inactiveColorPrimary ?? item.activeColorPrimary,
              ),
              child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                child: Text(
                  item.title ?? "",
                  style: TextStyle(
                    color: isSelected
                        ? (item.activeColorSecondary ?? item.activeColorPrimary)
                        : item.inactiveColorPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade900,
      child: SizedBox(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            final int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () => onItemSelected(index),
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
