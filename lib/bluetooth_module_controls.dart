import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mt_camera/color_constants.dart';
import 'dart:convert' show utf8;

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<BluetoothDevice> _devicesList = [];
  List<BluetoothService>? bluetoothServices;
  List<ControlButton> controlButtons = [];
  BluetoothDevice? arduinoDevice;

  @override
  void initState() {
    initBleList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mintCream,
        body: bluetoothServices == null ? _buildListViewOfDevices() : _buildControlButtons()
    );
  }

  Widget _buildControlButtons() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          child: const Text(
              'Mount Controls',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: darkSlateGray,
              )
          ),
        ),
        const Divider(
          color: darkSlateGray,
          thickness: 2.0,
        ),
        const Text(
            'Pan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: darkSlateGray,
            )
        ),
        Wrap(
          children: controlButtons
              .map((e) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: IconButton(
                onPressed: e.onTap,
                icon: e.icon,
              iconSize: 72,
            ),
          ))
              .toList(),
        ),
        const Divider(
          color: darkSlateGray,
          thickness: 2.0,
        ),
      ],
    );
  }

  Future initBleList() async {
    await Permission.bluetooth.request();
    await Permission.bluetoothConnect.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothAdvertise.request();
    flutterBlue.connectedDevices.asStream().listen((devices) {
      for (var device in devices) {
        _addDeviceToList(device);
      }
    });
    flutterBlue.scanResults.listen((scanResults) {
      for (var result in scanResults) {
        _addDeviceToList(result.device);
      }
    });
    flutterBlue.startScan();
  }

  void _addDeviceToList(BluetoothDevice device) {
    if (!_devicesList.contains(device)) {
      setState(() {
        _devicesList.add(device);
      });
    }
  }

  ListView _buildListViewOfDevices() {
    List<Widget> containers = [];
    containers.add(Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      child: const Text(
          'Bluetooth Devices',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: darkSlateGray,
          )
      ),
    ));
    for (BluetoothDevice device in _devicesList.where((element) => element.name.isNotEmpty)) {
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
              Column(
                children: [
                  Text(
                    device.name,
                    style: const TextStyle(
                      color: darkSlateGray,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  Text(
                    device.id.toString(),
                    style: const TextStyle(
                      color: darkSlateGray,
                      fontStyle: FontStyle.italic,
                    )
                  )
                ],
              ),
              ElevatedButton(
                child: const Text('Connect', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: cambridgeBlue,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  elevation: 3,
                ),
                onPressed: () async {
                  if (device.name.contains("DSD TECH")) {
                    try {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(child: CircularProgressIndicator());
                          }
                      );

                      await device.connect();
                      controlButtons.addAll([
                        ControlButton(buttonName: 'LEFT', onTap: () => writeValue("0"), icon: Icon(Icons.arrow_circle_left_sharp)),
                        ControlButton(buttonName: 'RIGHT', onTap: () => writeValue("1"), icon: Icon(Icons.arrow_circle_right_sharp)),
                        ControlButton(
                            buttonName: 'GO BACK',
                            onTap: () async {
                              await arduinoDevice?.disconnect();
                              setState(() {
                                bluetoothServices = null;
                              });
                            },
                            icon: Icon(Icons.cancel)
                        ),
                      ]);
                      List<BluetoothService> services = await device.discoverServices();
                      setState(() {
                        bluetoothServices = services;
                      });

                      setState(() {
                        arduinoDevice = device;
                      });

                      Navigator.of(context).pop();
                    } catch (e) {
                      await device.disconnect();
                    }
                  }
                },
              ),
            ],
          )
        ),
      );
    }
    return ListView(padding: const EdgeInsets.all(8), children: <Widget>[...containers]);
  }

  Future<void> writeValue(String value) async {
    BluetoothService? bluetoothService = bluetoothServices?.firstWhere((element) => element.uuid.toString() == '0000ffe0-0000-1000-8000-00805f9b34fb');
    BluetoothCharacteristic? bluetoothCharacteristic =
        bluetoothService?.characteristics.firstWhere((element) => element.uuid.toString() == '0000ffe1-0000-1000-8000-00805f9b34fb');
    List<int> encodedValue = utf8.encode(value);
    bluetoothCharacteristic?.write(encodedValue);
  }

  Future<void> readValue() async {
    BluetoothService? bluetoothService = bluetoothServices?.firstWhere((element) => element.uuid.toString() == '0000ffe0-0000-1000-8000-00805f9b34fb');
    BluetoothCharacteristic? bluetoothCharacteristic =
    bluetoothService?.characteristics.firstWhere((element) => element.uuid.toString() == '0000ffe1-0000-1000-8000-00805f9b34fb');
    List<int>? utf8Response = await bluetoothCharacteristic?.read();
    print(utf8.decode(utf8Response ?? []));
  }
}

class ControlButton {
  final String buttonName;
  final Function() onTap;
  final Icon icon;

  ControlButton({required this.buttonName, required this.onTap, required this.icon});
}