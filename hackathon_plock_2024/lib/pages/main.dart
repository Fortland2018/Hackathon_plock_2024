import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Dodaj ten import
import 'package:hackathon_plock_2024/themes/light_mode.dart';
import '../themes/dark_mode.dart';
import '../themes/theme_provider.dart';

final List<int> _items = List<int>.generate(10, (int index) => index);

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hackathon Plock 2024',
            theme: themeProvider.themeData,
            darkTheme: darkMode, // Zakładając, że masz zdefiniowany darkMode
            themeMode: themeProvider.themeMode,
            home: Home(),
          );
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool shadowColor = false;
  double? scrolledUnderElevation;
  Widget buildtheme(BuildContext context) {
    return IconButton(
      icon: Icon(
        Provider.of<ThemeProvider>(context).themeData == darkMode
            ? Icons.nights_stay
            : Icons.wb_sunny,
        size: 30,
        color: Provider.of<ThemeProvider>(context).themeData == darkMode
            ? Colors.white
            : Colors.black,
      ),
      onPressed: () {
        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nazwa apki'),
        scrolledUnderElevation: 4,
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
        actions: [
          Builder(
            builder: (context) => buildtheme(context), // Użycie Buildera
          ),
        ],
      ),
      body: Column(
        children: [
          Switch(
            value:
                Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark,
            onChanged: (value) {
              if (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme('dark', darkMode);
              } else {
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme('light', lightMode);
              }
            },
          ),
          Expanded(
            child: GridView.builder(
              itemCount: _items.length,
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Center(
                    child: Text(
                      'Custom Element',
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: _items[index].isOdd ? oddItemColor : evenItemColor,
                  ),
                  child: Text('Item $index'),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            alignment: MainAxisAlignment.center,
            overflowSpacing: 5.0,
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}

/*
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Ustal kolory na podstawie motywu
    final color = themeProvider.currentThemeKey == 'light'
        ? Colors.grey.shade300
        : Colors.grey.shade900;
    final color2 = themeProvider.currentThemeKey == 'light'
        ? const Color.fromARGB(255, 133, 196, 255)
        : Colors.grey.shade900;

    final isDarkMode = themeProvider.currentThemeKey == 'dark';
    */
