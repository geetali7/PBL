import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInputScreen extends StatefulWidget {
  @override
  _LocationInputScreenState createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location Input"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: const LatLng(37.7749, -122.4194),
          zoom: 12,
        ),
        onTap: (LatLng location) {
          setState(() {
            _selectedLocation = location;
          });
        },
        markers: _selectedLocation != null
            ? {Marker(markerId: MarkerId('selected_location'), position: _selectedLocation!)}
            : {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Selected location: $_selectedLocation');
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
