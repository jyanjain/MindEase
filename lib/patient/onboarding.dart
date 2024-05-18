import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:vr_therapy_ipd/design/colors.dart';
import 'package:vr_therapy_ipd/patient/features/appointment/appointment.dart';
import 'package:vr_therapy_ipd/patient/features/appointment/moveon.dart';
import 'package:vr_therapy_ipd/patient/features/progresstracker.dart';
import 'package:vr_therapy_ipd/patient/features/simulationAcro.dart';
import 'package:vr_therapy_ipd/patient/profile.dart';
import 'package:vr_therapy_ipd/patient/questionnaire_claustrophobia.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // bookAppointment()
    // simulations()
    // progresstracking()
    Qscreen(),
    // ProgressTrackingPage(),
    ProfilePage(),
    VideoPlayerItema(
      videoUrl:
          'https://www.youtube.com/watch?v=3rLPQgMwpD4&list=PLFyjjoCMAPtzgITDreXNNkSWLKbd1wf51&index=21',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Study Buddy',
      //     style: TextStyle(color: AppColors.primary),
      //   ),
      //   backgroundColor: AppColors.white,
      //   elevation: 0,
      // ),
      backgroundColor: Color(0xffF7EBE1),
      body: _pages[_currentIndex],
      bottomNavigationBar: FlashyTabBar(
        // Use FlashyTabBar
        selectedIndex: _currentIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
        }),
        backgroundColor: Color(0xFFEBFF00), // Set background color
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.groups, color: AppColors.black),
            title: Text('Q AND A', style: TextStyle(color: AppColors.black)),
          ),
          // FlashyTabBarItem(
          //   icon: Icon(Icons.home, color: AppColors.white),
          //   title: Text('Progress Tracking',
          //       style: TextStyle(color: AppColors.white)),
          // ),
          FlashyTabBarItem(
            icon: Icon(Icons.emoji_emotions, color: AppColors.black),
            title: Text('ChatBot', style: TextStyle(color: AppColors.black)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.more_horiz, color: AppColors.black),
            title:
                Text('Simulations', style: TextStyle(color: AppColors.black)),
          ),
        ],
      ),
    );
  }
}


// class Page extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Page 3 Content'),
//     );
//   }
// }
