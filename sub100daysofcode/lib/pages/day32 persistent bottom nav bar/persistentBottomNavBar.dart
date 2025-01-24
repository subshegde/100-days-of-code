import "package:flutter/material.dart";
import "package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart";


BuildContext? testContext;

class MyAppPersistentBottomNavBar extends StatelessWidget {
  const MyAppPersistentBottomNavBar({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MaterialApp(
        title: "Persistent Bottom Navigation Bar example project",
        theme: ThemeData.dark(),
        home: const MainMenu(),
        initialRoute: "/",
        routes: {
          "/first": (final context) => const MainScreen2(),
          "/second": (final context) => const MainScreen3(),
        },
      );
}

class MainMenu extends StatefulWidget {
  const MainMenu({final Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Sample Project"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ElevatedButton(
                child: const Text("Custom widget example"),
                onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: CustomWidgetExample(menuScreenContext: context),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                child: const Text("Built-in styles example"),
                onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: ProvidedStylesExample(menuScreenContext: context),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                child: const Text("Animated icons example"),
                onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: AnimatedIconScreen(menuScreenContext: context),
                ),
              ),
            ),
          ],
        ),
      );
}

// Placeholder Screens for navigation
class MainScreen extends StatelessWidget {
  const MainScreen({required this.menuScreenContext, this.hideStatus = false, this.scrollController, Key? key})
      : super(key: key);

  final BuildContext menuScreenContext;
  final bool hideStatus;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Action for the button
          },
          child: const Text("Go to Main Screen"),
        ),
      ),
    );
  }
}

class MainScreen2 extends StatelessWidget {
  const MainScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Screen 2")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Action for the button
          },
          child: const Text("Go to Main Screen 2"),
        ),
      ),
    );
  }
}

class MainScreen3 extends StatelessWidget {
  const MainScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Screen 3")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Action for the button
          },
          child: const Text("Go to Main Screen 3"),
        ),
      ),
    );
  }
}

class AnimatedIconScreen extends StatelessWidget {
  const AnimatedIconScreen({required this.menuScreenContext, Key? key}) : super(key: key);

  final BuildContext menuScreenContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Icons Example"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Animation action
          },
          child: const Text("Show Animated Icons"),
        ),
      ),
    );
  }
}

class CustomWidgetExample extends StatelessWidget {
  const CustomWidgetExample({required this.menuScreenContext, Key? key}) : super(key: key);

  final BuildContext menuScreenContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Widget Example"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Action for custom widget
          },
          child: const Text("Custom Widget Example Action"),
        ),
      ),
    );
  }
}

class ProvidedStylesExample extends StatefulWidget {
  const ProvidedStylesExample({required this.menuScreenContext, Key? key}) : super(key: key);
  final BuildContext menuScreenContext;

  @override
  _ProvidedStylesExampleState createState() => _ProvidedStylesExampleState();
}

class _ProvidedStylesExampleState extends State<ProvidedStylesExample> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provided Styles Example")),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: [
          MainScreen(menuScreenContext: widget.menuScreenContext),
          MainScreen2(),
          MainScreen3(),
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: "Home",
            activeColorPrimary: Colors.blue,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.search),
            title: "Search",
            activeColorPrimary: Colors.green,
          ),
        ],
      ),
    );
  }
}
