import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:mt_camera/color_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: const Text(
              'GoPro Quik App',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: darkSlateGray,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: 120,
            height: 40,
            child: ElevatedButton(
                onPressed: () async {
                  await LaunchApp.openApp(
                    androidPackageName: 'com.gopro.smarty',
                    openStore: false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: cambridgeBlue,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  elevation: 3,
                ),
                child: const Center(
                    child: Text(
                      'OPEN APP',
                      textAlign: TextAlign.center,
                    )
                ))
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: const Text(
              'AKASO GO App',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: darkSlateGray,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                  onPressed: () async {
                    await LaunchApp.openApp(
                      androidPackageName: 'com.cnest.motioncamera',
                      openStore: false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cambridgeBlue,
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    elevation: 3,
                  ),
                  child: const Center(
                      child: Text(
                        'OPEN APP',
                        textAlign: TextAlign.center,
                      )
                  ))
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Canon Camera Connect App',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: darkSlateGray,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                  onPressed: () async {
                    await LaunchApp.openApp(
                      androidPackageName: 'jp.co.canon.ic.cameraconnect',
                      openStore: false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cambridgeBlue,
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    elevation: 3,
                  ),
                  child: const Center(
                      child: Text(
                        'OPEN APP',
                        textAlign: TextAlign.center,
                      )
                  ))
          ),
        ],
      ),
    );
  }
}