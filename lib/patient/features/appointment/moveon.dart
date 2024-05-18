import 'package:flutter/material.dart';
import 'package:vr_therapy_ipd/patient/features/simulationAcro.dart';
import 'package:vr_therapy_ipd/patient/features/simulationClaustro.dart';
import 'package:vr_therapy_ipd/patient/questionarre_acrophobia.dart';
import 'package:vr_therapy_ipd/patient/questionnaire_claustrophobia.dart';

class Qscreen extends StatefulWidget {
  @override
  _QscreenState createState() => _QscreenState();
}

class _QscreenState extends State<Qscreen> {
  String? _selectedScenario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Let\'s detect your phobia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a scenario and start. It will take 5 seconds for each scenario.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildScenarioCard(
                  'assets/clausto.jpeg',
                  'Claustrophobia',
                  _selectedScenario == 'Claustrophobia',
                  () => _selectScenario('Claustrophobia'),
                ),
                _buildScenarioCard(
                  'assets/acrophoto.jpeg',
                  'Acrophobia',
                  _selectedScenario == 'Acrophobia',
                  () => _selectScenario('Acrophobia'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: _selectedScenario == null
                    ? null
                    : () {
                        // Navigate to the selected scenario screen
                        if (_selectedScenario == 'Claustrophobia') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerItemc(
                                videoUrl:
                                    'https://www.youtube.com/watch?v=Z4MRoIhigOI&embeds_referring_euri=https%3A%2F%2Fhubblecontent.osi.office.net%2F&source_ve_path=Mjg2NjY&feature=emb_logo',
                              ),
                            ),
                          );
                        } else if (_selectedScenario == 'Acrophobia') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerItema(
                                videoUrl:
                                    'https://youtube.com/watch?v=2kZTRzgTj4k&embeds_referring_euri=https%3A%2F%2Fhubblecontent.osi.office.net%2F&source_ve_path=Mjg2NjY&feature=emb_logo',
                              ),
                            ),
                          );
                        }
                      },
                child: Text('Start',
                    style: TextStyle(
                        color: Colors.black)), // Change text color to black
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEBFF00), // Yellow button color
                  minimumSize: Size(100, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectScenario(String scenario) {
    setState(() {
      _selectedScenario = scenario;
    });
  }

  Widget _buildScenarioCard(
    String imagePath,
    String title,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              // Add indicator if selected
              border: isSelected
                  ? Border.all(
                      color: Colors.blue, // Indicator color
                      width: 3.0, // Indicator width
                    )
                  : null,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'CustomFont', // Apply custom font
            ),
          ),
        ],
      ),
    );
  }
}

class ClaustrophobiaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Claustrophobia Screen'),
      ),
      body: Center(
        child: Text('This is the Claustrophobia screen!'),
      ),
    );
  }
}

class AcrophobiaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acrophobia Screen'),
      ),
      body: Center(
        child: Text('This is the Acrophobia screen!'),
      ),
    );
  }
}
