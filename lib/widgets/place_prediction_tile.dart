import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../models/predicted_places.dart';
import '../providers/map_provider.dart';
import '../services/request_service.dart';
import 'progress_dialog.dart';


class PlacePredictionTile extends StatefulWidget {
  const PlacePredictionTile({super.key, this.predictedPlaces});

  final PredictedPlaces? predictedPlaces;

  @override
  State<PlacePredictionTile> createState() => _PlacePredictionTileState();
}

class _PlacePredictionTileState extends State<PlacePredictionTile> {
  getPlaceDirectionsDetails(String? placeId, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        message: "Please wait...",
      ),
    );

    String placeDirectionDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleMapApi";
    var responseapi =
    await RequestService.receiveRequest(placeDirectionDetailsUrl);

    Navigator.pop(context);
    if (responseapi == "Error Ocurred, No Response") {
      return;
    }

    if (responseapi["status"] == "OK") {
      LatLng pos = LatLng(
          responseapi["result"]["geometry"]["location"]["lat"],
          responseapi["result"]["geometry"]["location"]["lng"]
      );
      Provider.of<MapProvider>(context, listen: false).onTap(pos);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        getPlaceDirectionsDetails(widget.predictedPlaces!.place_id, context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const Icon(Icons.add_location, color: Colors.black),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.predictedPlaces!.main_text!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.predictedPlaces!.secondary_text!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
