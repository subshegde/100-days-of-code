import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';
import 'package:url_launcher/url_launcher.dart';

class CallPhone extends StatefulWidget {
  CallPhone({Key? key}) : super(key: key);

  @override
  _CallPhoneState createState() => _CallPhoneState();
}

class _CallPhoneState extends State<CallPhone> {
  int _selectedIndex = 0;

  void launchEmail() async {
    final Uri emailUri = Uri.parse(
      'mailto:example@gmail.com?subject=${Uri.encodeComponent('Subject')}&body=${Uri.encodeComponent('Body content here')}',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch email client');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No email client found or misconfigured')),
      );
    }
  }

  void customLaunch(String command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Could not launch phone: $command');
    }
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return _contactScreen();
      case 1:
        return const Center(child: Text('Tab 2 Placeholder'));
      case 2:
        return const Center(child: Text('Tab 3 Placeholder'));
      default:
        return _contactScreen();
    }
  }

  Widget _contactScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Contact us for more details!",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          InkWell(
            onTap: () {
              launchEmail();
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Send an Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          InkWell(
            onTap: () {
              customLaunch("tel:05554443322");
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Call Us",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
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
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: Colors.teal,
        title: const Text('Contact Us',style: TextStyle(color: AppColors.white),),
      ),
      body: _getSelectedScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contact Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Tab 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Tab 3',
          ),
        ],
      ),
    );
  }
}
