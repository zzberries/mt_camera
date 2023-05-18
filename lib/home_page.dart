import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:mt_camera/color_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CameraAppIcon> _apps = [];

  @override
  void initState() {
    super.initState();
    _apps.add(CameraAppIcon(appName: 'GoPro', androidPackage: 'com.gopro.smarty', imageUrl: 'assets/images/gopro_image.png'));
    _apps.add(CameraAppIcon(appName: 'AKASO', androidPackage: 'com.cnest.motioncamera', imageUrl: 'assets/images/akaso_image.png'));
    _apps.add(CameraAppIcon(appName: 'Canon', androidPackage: 'jp.co.canon.ic.cameraconnect', imageUrl: 'assets/images/canon_image.png'));
  }

  Column _buildCameraAppIcons() {
    List<Widget> containers = [];
    for (CameraAppIcon cai in _apps) {
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
                Image.asset(
                  cai.imageUrl,
                  height: 80.0,
                  fit: BoxFit.fitHeight,
                ),
                Column(
                  children: [
                    Text(
                        cai.appName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: darkSlateGray,
                          fontSize: 20,
                        )
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await LaunchApp.openApp(
                            androidPackageName: cai.androidPackage,
                            openStore: false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
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
                        )
                    ),
                  ],
                )
              ]
          )
        )
      );
    }
    return Column(children: <Widget>[...containers]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          child: const Text(
              'What type of camera will you be using?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: darkSlateGray,
              )
          ),
        ),
        _buildCameraAppIcons(),
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: const [
              Text(
                  'Are you using a camera our app doesn\'t support?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: darkSlateGray,
                  )
              ),
              Text(
                  'Contact us.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: cambridgeBlue,
                  )
              )
            ],
          )
        )
      ],
    );
  }
}

class CameraAppIcon {
  final String appName;
  final String androidPackage;
  final String imageUrl;

  CameraAppIcon({required this.appName, required this.androidPackage, required this.imageUrl});
}

