import 'package:flutter/material.dart';
import 'package:mt_camera/color_constants.dart';

class CameraControlsPage extends StatelessWidget {
  const CameraControlsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/sidewalk_photo.jpg'),
                  )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    color: oldGold,
                    child: const Text(
                      'Photo',
                      style: TextStyle(
                        color: darkSlateGray,
                      ),
                    )
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Video',
                      style: TextStyle(
                        color: darkSlateGray,
                      ),
                    )
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.circle_outlined, size: 45, color: darkSlateGray,),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: nyanza,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text('CANON-18'),
                        Icon(Icons.wifi),
                      ],
                    )
                  ],
                )
            )
          ],
        )
    );
  }
}