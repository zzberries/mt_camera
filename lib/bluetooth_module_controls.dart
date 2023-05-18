import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mt_camera/control_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mt_camera/color_constants.dart';

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
  late String _buttonState;

  @override
  void initState() {
    initBleList();
    super.initState();
    _buttonState = "no button pressed.";
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
        Wrap(
          children: controlButtons
              .map((e) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(onPressed: e.onTap, child: Text(e.buttonName)),
          ))
              .toList(),
        ),
        Center(child: Text(_buttonState)),
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
    for (BluetoothDevice device in _devicesList.where((element) => element.name.isNotEmpty)) {
      containers.add(
        SizedBox(
          height: 60,
          child: Row(
            children: <Widget>[
              Expanded(child: Column(children: <Widget>[Text(device.name), Text(device.id.toString())])),
              ElevatedButton(
                child: const Text('Connect', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  if (device.name.contains("DSD TECH")) {
                    try {
                      await device.connect();
                      controlButtons.addAll([
                        ControlButton(buttonName: 'On', onTap: () => _buttonState = "On Button Tapped"),
                        ControlButton(buttonName: 'Off', onTap: () => _buttonState = "Off Button Tapped"),
                      ]);
                      List<BluetoothService> services = await device.discoverServices();
                      setState(() {
                        bluetoothServices = services;
                      });
                    } catch (e) {
                      await device.disconnect();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      );
    }
    return ListView(padding: const EdgeInsets.all(8), children: <Widget>[...containers]);
  }
}