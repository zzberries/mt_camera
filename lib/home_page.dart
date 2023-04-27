import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

const empatheticLightYellow = Color(0xffffcd5c);
const empatheticLightGreen = Color(0xff96ceb5);

const cambridgeBlue = Color(0xff7ca982);
const nyanza = Color(0xffe0eec6);
const mintCream = Color(0xfff1f7ed);
const darkSlateGray = Color(0xff243e36);
const oldGold = Color(0xffc2a83e);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  final List<BluetoothDevice> _devicesList = [];

  @override
  void initState() {
    initBleList();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return _buildListViewOfDevices();
  }

  ListView _buildListViewOfDevices() {
    List<Widget> containers = [];
    print(_devicesList);
    for (BluetoothDevice device in _devicesList.where((element) => element.name.isNotEmpty)) {
      containers.add(
        SizedBox(
          height: 60,
          child: Row(
            children: <Widget>[
              Expanded(child: Column(children: <Widget>[Text(device.name), Text(device.id.toString())])),
            ],
          )
        )
      );
    }
    return ListView(padding: const EdgeInsets.all(8), children: <Widget>[...containers]);
  }
}