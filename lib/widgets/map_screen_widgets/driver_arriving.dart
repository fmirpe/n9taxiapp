import 'package:flutter/material.dart';

import '../../models/map_action.dart';
import '../../providers/map_provider.dart';

class DriverArriving extends StatelessWidget {
  const DriverArriving({super.key, this.mapProvider});

  final MapProvider? mapProvider;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: mapProvider!.mapAction == MapAction.driverArriving,
      child: Positioned(
        bottom: 15,
        left: 15,
        right: 15,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Driver Arriving',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (mapProvider!.distance != null)
                Text(
                  'Distance: ${mapProvider!.distance!.toStringAsFixed(2)} Km',
                )
            ],
          ),
        ),
      ),
    );
  }
}
