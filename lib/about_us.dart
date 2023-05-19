import 'package:flutter/material.dart';
import 'package:mt_camera/color_constants.dart';
import 'package:mt_camera/contact_information.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mintCream,
      appBar: AppBar(
        toolbarHeight: 80, // fixed height
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
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
              child: const Text(
                "Empathetic Engineering, Inc.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: darkSlateGray
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: const Text(
                  "We are a group of high school students trying to develop a flexible camera mount for wheelchair users. This app controls the actual mount of the camera through an Arduino board.",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: darkSlateGray
                  )
              )
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: const Text(
                    "If you experience any problems, please contact us through these email addresses.",
                    style: TextStyle(
                        fontSize: 25.0,
                        color: darkSlateGray
                    )
                )
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactInfo()),
                    );
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
                      "GET CONTACT INFO",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      )
                  )
              ),
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
      )
    );
  }
}