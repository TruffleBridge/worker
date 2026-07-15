import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nimora_worker/core/utils/location_services.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _locationController = TextEditingController();

  bool _isLoadingLocation = false;

  double? _latitude;
  double? _longitude;
  String _address = '';

  Future<void> _useCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final Position position = await LocationService.getCurrentLocation();

      _latitude = position.latitude;
      _longitude = position.longitude;

      final geocoding = Geocoding();

      final placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        final city = place.locality?.trim() ?? '';
        final state = place.administrativeArea?.trim() ?? '';

        final parts = <String>[
          if (city.isNotEmpty) city,
          if (state.isNotEmpty) state,
        ];

        _address = parts.join(', ');

        _locationController.text = _address.isNotEmpty
            ? _address
            : '${position.latitude}, ${position.longitude}';
      } else {
        _address = '';
        _locationController.text =
        '${position.latitude}, ${position.longitude}';
      }

      if (!mounted) return;
      setState(() {});
    } catch (e) {
      _showMessage(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _submitLocation() {
    if (_latitude == null || _longitude == null) {
      _showMessage('Please select a location first');
      return;
    }

    final request = {
      "page": 1,
      "limit": 10,
      "search": "caregiver",
      "locationType": "current",
      "latitude": _latitude,
      "longitude": _longitude,
      "address":
      _address.isNotEmpty ? _address : _locationController.text.trim(),
      "radiusKm": 25,
    };

    debugPrint('Location request: $request');

    // TODO:
    // call bloc / repository / API here
    //
    // Example:
    // context.read<JobsBloc>().add(
    //   JobsOnLoadedEvent(
    //     latitude: _latitude,
    //     longitude: _longitude,
    //     address: _address,
    //   ),
    // );
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _locationController,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your location',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.white70,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1A1A1A),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFF2B2B2B),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFF4C6FFF),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoadingLocation ? null : _useCurrentLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E7A6D),
                    disabledBackgroundColor: const Color(0xFF0E7A6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    _isLoadingLocation
                        ? 'Fetching location...'
                        : 'Use my current location',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submitLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C6FFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}