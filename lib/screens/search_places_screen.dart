import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/predicted_places.dart';
import '../providers/map_provider.dart';
import '../services/request_service.dart';
import '../widgets/place_prediction_tile.dart';
class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({super.key});

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {

  List<PredictedPlaces> placesPredictedList = [];
  late var countryString = "CO";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      countryString = Provider.of<MapProvider>(context, listen: false).deviceCountry!;
    });
  }

  findPlaceAutoCompleteSearch(String inputText) async {
    if (inputText.length > 2) {
      String urlAutoComplete =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$googleMapApi&components=country:$countryString";
      var responseAutoCompleteSearch =
      await RequestService.receiveRequest(urlAutoComplete);

      if (responseAutoCompleteSearch == "Error Ocurred, No Response") {
        return;
      }

      if (responseAutoCompleteSearch["status"] == "OK") {
        var placePredictions = responseAutoCompleteSearch["predictions"];
        var placePredictionsList = (placePredictions as List)
            .map((jsonData) => PredictedPlaces.fromJson(jsonData))
            .toList();
        setState(() {
          placesPredictedList = placePredictionsList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: const Text("Search destination", style: TextStyle(color: Colors.white),),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 8,
                      spreadRadius: 0.5,
                      offset: const Offset(
                        0.7,
                        0.7,
                      ),
                    )
                  ],
                ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.adjust_sharp,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 18.0),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextField(
                                onChanged: (value) {
                                  findPlaceAutoCompleteSearch(value);
                                },
                                decoration: const InputDecoration(
                                  hintText: "Search location here",
                                  fillColor: Colors.grey,
                                  filled: true,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    left: 11,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                ),
                              ),
                            )
                        ),
                      ]
                    ),
                  ],
                ),
              ),
            ),

            (placesPredictedList.isNotEmpty) ?
                Expanded(
                  child: ListView.separated(
                    itemCount: placesPredictedList.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PlacePredictionTile(
                        predictedPlaces: placesPredictedList[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, index) {
                      return const Divider(
                        height: 0,
                        color: Colors.red,
                        thickness: 0,
                      );
                    },
                  ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}
