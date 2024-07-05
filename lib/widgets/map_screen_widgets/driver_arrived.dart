import 'package:flutter/material.dart';

import '../../models/map_action.dart';
import '../../providers/map_provider.dart';

class DriverArrived extends StatelessWidget {
  const DriverArrived({super.key, this.mapProvider});

  final MapProvider? mapProvider;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: mapProvider!.mapAction == MapAction.driverArrived,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Driver Arrived',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Get to the car fast',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
