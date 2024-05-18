import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:vr_therapy_ipd/doctor/checkappointment.dart';
import 'package:vr_therapy_ipd/design/colors.dart';
import 'package:vr_therapy_ipd/doctor/doctor_session.dart';
import 'package:vr_therapy_ipd/patient/features/appointment/appointment.dart';
import 'package:vr_therapy_ipd/patient/features/progresstracker.dart';
import 'package:vr_therapy_ipd/patient/features/simulationAcro.dart';
import 'package:vr_therapy_ipd/patient/profile.dart';

class HomePageD extends StatefulWidget {
  @override
  _HomePageDState createState() => _HomePageDState();
}

class _HomePageDState extends State<HomePageD> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // bookAppointment()
    // simulations()
    // progresstracking()

    AppointmentCheck(),
    NewSession(),
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
        backgroundColor: AppColors.secondary, // Set background color
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.groups, color: AppColors.white),
            title: Text('Check Appointment',
                style: TextStyle(color: AppColors.white)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.home, color: AppColors.white),
            title:
                Text('New session', style: TextStyle(color: AppColors.white)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.emoji_emotions, color: AppColors.white),
            title: Text('Chat', style: TextStyle(color: AppColors.white)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.more_horiz, color: AppColors.white),
            title:
                Text('Simulations', style: TextStyle(color: AppColors.white)),
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
