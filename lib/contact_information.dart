import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mt_camera/color_constants.dart';

class ContactInfo extends StatelessWidget {
  List<PeoplePosition> pos = [
    PeoplePosition(personName: "Isabella Palit", emailId: "ipalit1@wpi.edu", position: 'CEO'),
    PeoplePosition(personName: "Donovan Sappet", emailId: "dsappet@wpi.edu", position: 'CTO'),
    PeoplePosition(personName: "Riley Harn", emailId: "rharn@wpi.edu", position: 'CMO'),
    PeoplePosition(personName: "Rianna Santra", emailId: "rsantra@wpi.edu", position: 'CIO'),
  ];

  ContactInfo({super.key});

  Column _buildPeoplePositionCards() {
    List<Widget> containers = [];
    for (PeoplePosition ppl in pos) {
      containers.add(
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                color: darkSlateGray,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: nyanza
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                ppl.position,
                style: TextStyle(
                  fontFamily: GoogleFonts.righteous().fontFamily,
                  color: darkSlateGray,
                  fontSize: 30.0,
                )
              ),
              Column(
                children: [
                  Text(
                    ppl.personName,
                    style: const TextStyle(
                      color: darkSlateGray,
                      fontSize: 25.0
                    )
                  ),
                  Text(
                    ppl.emailId,
                    style: const TextStyle(
                      color: darkSlateGray,
                      fontSize: 25.0,
                      fontStyle: FontStyle.italic,
                    )
                  )
                ]
              )
            ],
          )
        )
      );
    }
    return Column(children: <Widget>[...containers]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mintCream,
      appBar: AppBar(
        toolbarHeight: 80, // fixed height:
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/unnamed.png', scale: 8),
              const Text(
                'Mt. Camera',
                style: TextStyle(
                    color: darkSlateGray,
                    fontSize: 25
                ),
              )
            ]
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[nyanza, cambridgeBlue]),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
              child: const Text(
                  "Our Team",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: darkSlateGray,
                  )
              )
            ),
            _buildPeoplePositionCards(),
            Container(
              margin: const EdgeInsets.all(20.0),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.all(30.0),
                  backgroundColor: cambridgeBlue,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  elevation: 3,
                ),
                child: const Text(
                    "GO BACK",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    )
                )
            )
          ],
        )
      ),
    );
  }
}

class PeoplePosition {
  final String personName;
  final String emailId;
  final String position;

  PeoplePosition({required this.personName, required this.emailId, required this.position});
}