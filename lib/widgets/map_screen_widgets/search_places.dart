import 'package:flutter/material.dart';

import '../../models/map_action.dart';
import '../../providers/map_provider.dart';
import '../../screens/search_places_screen.dart';
class SearchPlaces extends StatefulWidget {
  const SearchPlaces({super.key, this.mapProvider});

  final MapProvider? mapProvider;

  @override
  State<SearchPlaces> createState() => _SearchPlacesState();
}

class _SearchPlacesState extends State<SearchPlaces> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.mapProvider!.mapAction == MapAction.selectTrip,
      child: Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on_outlined,
                                    color: Colors.red),
                                const SizedBox(width: 10),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "From",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    widget.mapProvider!.deviceAddress != null ?
                                    Text(
                                        widget.mapProvider!.deviceAddress!
                                    ) : const Text("No device address"),
                                  ]
                                )
                              ]
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Divider(
                            height: 1,
                            thickness: 2,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) =>
                                        const SearchPlacesScreen()));
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on_outlined,
                                      color: Colors.lightGreen),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "To",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      widget.mapProvider!.remoteAddress != null ?
                                      Text(
                                          widget.mapProvider!.remoteAddress!
                                      ) : const Text("No destination address"),
                                    ],
                                  )
                                ],
                              ),
                            )
                          )
                        ]
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
