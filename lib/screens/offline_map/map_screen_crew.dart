import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/offline_map/custom_widgets.dart';
import 'package:CIVM/screens/offline_map/map_data_base_helper.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/image_code_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

// ignore: must_be_immutable
class MapScreenCrew extends StatefulWidget {
  String jobNo;
  String substation;
  String feeder;
  String year;
  MapScreenCrew({
    super.key,
    required this.jobNo,
    required this.substation,
    required this.feeder,
    required this.year,
  });

  @override
  State<MapScreenCrew> createState() => _MapScreenCrewState();
}

class _MapScreenCrewState extends State<MapScreenCrew> {
  late final MapController _mapController;
  double _currentZoom = 17.0;
  int driveMode = 0;
  double _deviceHeading = 0.0;
  LatLng? _currentLocation;
  bool _isVisibleSpeed = false;
  String mapStyle = "street"; // Default map style
  double? _currentSpeed;
  LatLng? newLocation;
  List<Marker> _markers = [];
  late StreamSubscription<Position> _positionStreamSubscription;
  var position; //position variable while moving marker

  bool showDetails = true;
  bool _isVisibleSearchByLocation = false;
  String? selectedType = "IVM";
  String? selectedYear = "2024";
  String? selectedSubstation;
  int? selectedSubstationId;
  String? selectedFeeder;

  final List<String> typeList = ["IVM", "Change Order"];

  List<String> yearList = [];
  List<Substation> substationList = [];
  List<String> feederList = [];

  ////
  List<Map<String, dynamic>> overHeadData = [];
  List<Map<String, dynamic>> messagesData = [];
  List<Map<String, dynamic>> commentsData = [];
  List<OverHeadPolylineData> overHeadPolylines = [];
  List<Polygon> substationBoundaryPolygons = [];
  Set<int> selectedPolylineIndexes = {};
  //---------
  List<Marker> poleMarkers = [];
  List<Marker> consumerMarkers = [];
  // List<Polyline> underGroundPolylines = [];
  List<Polyline> primaryUnderGroundPolylines = [];
  List<Polyline> secondaryUnderGroundPolylines = [];
  ////
  LatLng? selectedPopupLatLng;
  Offset? popupOffset;
  bool showPopup = false;

  String selectedWkt = "";
  double totalSelectedDistanceMiles = 0;
  double currentSelectedDistanceMiles = 0;
  int? selectedPolylineIndex;
  ///////////////dialog fields
  String? selectedPlanType = "IVM Work Plan";
  String? selectedType2 = "Regular IVM maintenance";
  String? selectedContractor = "ZIELIES";
  String? selectedForeman;
  int? selectedForemanId;

  TextEditingController commentsController = TextEditingController();
  final TextEditingController chatController = TextEditingController();

  List<String> planTypeList = ["IVM Work Plan"];

  List<String> typeList2 = ["Regular IVM maintenance"];

  List<String> contractorList = ["ZIELIES"];

  //List<String> foremanList = ["Jay"];
  List<Map<String, dynamic>> foremanList = [];

  List<Map<String, dynamic>> selectedMapObjects = [];
  List<Map<String, dynamic>> selectedMapObjectsUpdate = [];
  bool isOnline = true;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  List<Marker> chatMarkers = [];
  List<Marker> completedMarkers = [];
  List<Marker> noSprayMarkers = [];
  final ScrollController chatScrollController = ScrollController();
  final ScrollController _layerScrollController = ScrollController();
  Color polylineColor = Colors.grey;
  /////////////
  bool showLayerPanel = false;
  bool expandWorkLayers = true;
  bool showSubstationLayer = true;
  // bool showOverHeadLayer = true;
  // bool showUnderGroundLayer = true;
  bool showPrimaryLayer = true;
  bool showPrimaryOverHeadLayer = true;
  bool showPrimaryUnderGroundLayer = true;

  bool showSecondaryLayer = true;
  bool showSecondaryOverHeadLayer = true;
  bool showSecondaryUnderGroundLayer = true;
  bool showConsumerLayer = true;
  bool showPoleLayer = true;
  bool showMaintLayer = true;
  Map<String, bool> workLayerVisibility = {
    "JARRAFF": true,
    "MOWING": true,
    "MINI JARRAFF": true,
    "BYL": true,
    "BUCKET": true,
    "GROUND": true,
    "CROSS-COUNTRY SPRAY": true,
    "ROADSIDE SPRAY": true,
    "NO SPRAY": true,
  };
  bool showUpdateCardView = true;
  /////////////
  // bool isMarkAsRead = false;
  Map<String, bool> markAsReadMap = {};
  String selectedMaintType = "";
  String selectedMaintStatus = "";
  List<String> selectedWorkTypesUpdate = [];
  final Map<String, Color> workTypeColors = {
    "JARRAFF": const Color.fromARGB(255, 96, 0, 113),
    "MOWING": const Color.fromARGB(255, 113, 68, 1),
    "MINI JARRAFF": const Color.fromARGB(255, 247, 19, 2),
    "BYL": const Color.fromARGB(255, 2, 212, 249),
    "BUCKET": Colors.orange,
    "GROUND": Colors.yellow,
    "CROSS-COUNTRY SPRAY": const Color.fromARGB(255, 38, 1, 247),
    "ROADSIDE SPRAY": const Color.fromARGB(255, 1, 127, 5),
    "NO SPRAY": const Color.fromARGB(255, 252, 199, 249),
  };

  ///
  late List<CameraDescription> _cameras;
  CameraController? _camerasController;

  List<String> imagePaths = [];
  List<XFile> images = [];
  StateSetter? dialogSetState;
  bool isMarkAsRead = false;
  List<Map<String, dynamic>> availableLines = [];
  List<Map<String, dynamic>> lines = [];

  ///
  List<String> imagePathsChangeOrder = [];
  // double estimatedHours = 0.1;
  final TextEditingController _commentsCOController = TextEditingController();
  final TextEditingController _createdByCO = TextEditingController();

  StateSetter? dialogSetStateCO;
  bool isUploadLoading = false;
  Future<void>? _launched;
  final TextEditingController _searchController = TextEditingController();
  List<Marker> _markerSearch = [];
  bool _showedLocationpin = false;
  StreamSubscription<CompassEvent>? _compassSubscription;
  ImageViewViewModel imageViewModel = ImageViewViewModel();
  String imageSource = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedFeeder = widget.feeder;
    selectedSubstation = widget.substation;
    /////////
    _listenToConnectivity();
    ////////
    _mapController = MapController();
    _initializeMap();
    WakelockPlus.enable();
    /////
    ensureCameraInitialized();
    _startListeningToCompass();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mapController.dispose();
    WakelockPlus.disable();
    _positionStreamSubscription.cancel();
    _connectivitySubscription.cancel();
    chatScrollController.dispose();
    _layerScrollController.dispose();
    chatController.dispose();
    _compassSubscription?.cancel();
    disposeCamera();
  }

  Future<void> ensureCameraInitialized() async {
    if (_camerasController == null ||
        !_camerasController!.value.isInitialized) {
      await cameraInit();
    }
  }

  Future<void> disposeCamera() async {
    if (_camerasController!.value.isInitialized) {
      await _camerasController!.dispose();
      // _camerasController = null;
    }
  }

  Future<void> _listenToConnectivity() async {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      result,
    ) async {
      final online = !result.contains(ConnectivityResult.none);

      if (!mounted) return;

      setState(() {
        isOnline = online;
      });

      _showConnectivitySnackBar(online);
      if (online) {
        await loadApiData();
      }
    });
  }

  Future<void> _initializeMap() async {
    await _getCurrentLocation();
    _listenToLocationUpdates();
    // _loadGeoJSONBoundary();
    loadApiData();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar("Location services are disabled.");
      // return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showSnackBar("Location permissions are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showSnackBar("Location permissions are permanently denied.");
      return;
    }

    Position position1 = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      position = [position1.latitude, position1.longitude];
      _currentLocation = LatLng(position1.latitude, position1.longitude);
      print('_currentLocation $_currentLocation');
      _updateMarker();
      // _checkIfLocationInsidePolygon();
    });
  }

  void _updateMarker() {
    // print("_updateMarker called");
    if (_currentLocation != null) {
      _markers = [
        Marker(
          // rotateOrigin: const Offset(0.5, 0.5),
          point: _currentLocation!,
          child: Transform.rotate(
            angle: _deviceHeading * (pi / 180),
            alignment: Alignment.center,
            child: const Icon(Icons.navigation, color: Colors.blue, size: 40),
          ),
        ),
      ];
      setState(() {
        //UI Refresh
      });
    }
  }

  void _listenToLocationUpdates() {
    // print("_listenToLocationUpdates called");
    _positionStreamSubscription = Geolocator.getPositionStream().listen((
      Position position,
    ) {
      // print("Location updated: $newLocation");
      setState(() {
        newLocation = LatLng(position.latitude, position.longitude);
        var result = [
          position.latitude,
          position.longitude,
        ]; //latitude and longitude of new position
        //  transition(result); //start moving marker
        _currentLocation = newLocation;
        _currentSpeed = (position.speed * 2.23694);
        _updateMarker();
        //  _loadGeoJSON();
        if (driveMode == 1) {
          _mapController.move(_currentLocation!, _currentZoom);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final panelHeight = screenHeight < 700
        ? screenHeight * 0.50
        : screenHeight < 900
        ? screenHeight * 0.60
        : screenHeight * 0.80;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "IVM Sytem Map",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        actions: [
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {
              setState(() {
                showDetails = !showDetails;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isVisibleSearchByLocation = !_isVisibleSearchByLocation;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              loadApiData();
               showLayerPanel = false;
                 expandWorkLayers = true;
                 showSubstationLayer = true;
                 showPrimaryLayer = true;
                 showPrimaryOverHeadLayer = true;
                 showPrimaryUnderGroundLayer = true;
                 showSecondaryLayer = true;
                 showSecondaryOverHeadLayer = true;
                 showSecondaryUnderGroundLayer = true;
                 showConsumerLayer = true;
                 showPoleLayer = true;
                 showMaintLayer = true;
            },
          ),
        ],
      ),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Visibility(
                  visible: showDetails,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF073B78),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Job No
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.orange.shade700),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.badge,
                                  color: Colors.deepOrange,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Job No : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    widget.jobNo,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          /// Substation & Feeder
                          Row(
                            children: [
                              Expanded(
                                child: _infoTile(
                                  Icons.location_city,
                                  "Substation",
                                  selectedSubstation ?? "-",
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _infoTile(
                                  Icons.alt_route,
                                  "Feeder",
                                  selectedFeeder ?? "-",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Visibility(
                //   visible: showDetails,
                //   child: Container(
                //     padding: const EdgeInsets.all(12),
                //     decoration: BoxDecoration(
                //       color: const Color.fromARGB(255, 7, 59, 120),
                //       boxShadow: [
                //         BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
                //       ],
                //     ),
                //     child: Container(
                //       width: double.infinity,
                //       padding: const EdgeInsets.all(12),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           _buildInfoRow("Job No", widget.jobNo),
                //           const Divider(height: 20),

                //           _buildInfoRow(
                //             "Substation",
                //             selectedSubstation.toString(),
                //           ),
                //           const Divider(height: 20),

                //           _buildInfoRow("Feeder", selectedFeeder.toString()),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Stack(
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter:
                              _currentLocation ?? const LatLng(0.0, 0.0),
                          // LatLng(17.3850, 78.4867), // Hyderabad
                          initialZoom: _currentZoom,
                          maxZoom: 22,
                          minZoom: 0.0,
                          // Disable map rotation
                          interactionOptions: const InteractionOptions(
                            flags:
                                InteractiveFlag.all & ~InteractiveFlag.rotate,
                          ),
                          ////////////poly line on tap---------
                          onTap: (tapPosition, latLng) {
                            _onPolylineTap(latLng);

                            ///

                            // showPopup = false;
                          },
                          onPositionChanged: (position, hasGesture) {
                            final zoom = position.zoom
                                .clamp(1.0, 22.0)
                                .toDouble();
                            //to hide poles and consumers when extream zoom in
                            final bool wasStreetLevel = _currentZoom >= 15.0;
                            final bool isStreetLevel = zoom >= 15.0;

                            if (wasStreetLevel != isStreetLevel) {
                              setState(() {
                                _currentZoom = zoom;
                              });
                            } else {
                              _currentZoom = zoom;
                            }

                            // if (_currentZoom != zoom) {
                            //   setState(() {
                            //     _currentZoom = zoom;
                            //   });
                            // }

                            if (showPopup) {
                              _updatePopupPosition();
                            }
                            if (_currentZoom < 15.0) {
                              showPoleLayer = false;
                              showConsumerLayer = false;
                            }
                            if (_currentZoom >= 15.0) {
                              showPoleLayer = true;
                              showConsumerLayer = true;
                            }
                          },
                          ////////--------------
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: mapStyle == "street"
                                ? "https://tile.openstreetmap.org/{z}/{x}/{y}.png"
                                //"https://tile.openstreetmap.de/{z}/{x}/{y}.png"
                                : "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
                            userAgentPackageName: "com.ariespro.civm2",
                          ),
                          if (showSubstationLayer)
                            PolygonLayer(polygons: substationBoundaryPolygons),

                          ///plylin ontap--------
                          // if (showOverHeadLayer)
                          if (showPrimaryOverHeadLayer ||
                              showSecondaryOverHeadLayer)
                            PolylineLayer(
                              polylines: overHeadPolylines.asMap().entries.expand((
                                entry,
                              ) {
                                // final index = entry.key;
                                final polyline = entry.value;
                                final bool isPrimary = polyline.service == "0";
                                final bool isSecondary =
                                    polyline.service == "1";

                                if (isPrimary && !showPrimaryOverHeadLayer) {
                                  return <Polyline>[];
                                }

                                if (isSecondary &&
                                    !showSecondaryOverHeadLayer) {
                                  return <Polyline>[];
                                }
                                ////Mark as Completed grey fix---
                                final isMarkAsCompletedForThisSpan = lines.any(
                                  (e) => e["mapId"] == polyline.oid.toString(),
                                );

                                ///---------------
                                final maintTypes = polyline.maintType
                                    .split(",")
                                    .map((e) => e.trim().toUpperCase())
                                    .where((e) => e.isNotEmpty)
                                    .toList();

                                final maintStatuses = polyline.maintStatus
                                    .split(",")
                                    .map((e) => e.trim())
                                    .toList();

                                // No maintType -> original polyline color
                                if (maintTypes.isEmpty) {
                                  return [
                                    Polyline(
                                      points: polyline.points,
                                      strokeWidth: 12,
                                      // color: polyline.originalColor,
                                      ////lightenColor color bug fix(01-10-2026)
                                      color:
                                          selectedPolylineIndexes.contains(
                                            entry.key,
                                          )
                                          ? lightenColor(polyline.originalColor)
                                          : polyline.originalColor,
                                    ),
                                  ];
                                }

                                // Get only CHECKED maintTypes
                                final visibleIndexes = <int>[];

                                for (int i = 0; i < maintTypes.length; i++) {
                                  final type = maintTypes[i];

                                  if (workLayerVisibility[type] ?? false) {
                                    visibleIndexes.add(i);
                                  }
                                }

                                // =====================================================
                                // CASE 1: ALL maintTypes are unchecked
                                // Show complete span in original color
                                // =====================================================
                                if (visibleIndexes.isEmpty) {
                                  return [
                                    Polyline(
                                      points: polyline.points,
                                      strokeWidth: 12,
                                      ////Mark as Completed grey fix---
                                      color: isMarkAsCompletedForThisSpan
                                          ? Colors.grey
                                          : polyline.originalColor,
                                    ),
                                  ];
                                }

                                // =====================================================
                                // CASE 2: ONLY ONE maintType is checked
                                // Show COMPLETE span in that maintType color
                                // =====================================================
                                if (visibleIndexes.length == 1) {
                                  final i = visibleIndexes.first;
                                  final type = maintTypes[i];

                                  final status = i < maintStatuses.length
                                      ? maintStatuses[i].toLowerCase()
                                      : "";
                                  ////Mark as Completed grey fix---
                                  final Color color =
                                      isMarkAsCompletedForThisSpan
                                      ? Colors.grey
                                      : status == "completed" ||
                                            status == "rework completed" ||
                                            status == "final completed"
                                      ? Colors.grey
                                      : getColorFromName(
                                          type,
                                          noSprayColor: polyline.originalColor,
                                        );

                                  return [
                                    Polyline(
                                      points: polyline.points,
                                      strokeWidth: 16,
                                      color: color,
                                    ),
                                  ];
                                }

                                // =====================================================
                                // CASE 3: MULTIPLE maintTypes are checked
                                // Split the span between only the checked maintTypes
                                // =====================================================
                                final visibleColors = <Color>[];

                                for (final i in visibleIndexes) {
                                  final type = maintTypes[i];

                                  final status = i < maintStatuses.length
                                      ? maintStatuses[i].toLowerCase()
                                      : "";
                                  ////Mark as Completed grey fix---
                                  if (isMarkAsCompletedForThisSpan) {
                                    visibleColors.add(Colors.grey);
                                  } else if (status == "completed" ||
                                      status == "rework completed" ||
                                      status == "final completed") {
                                    visibleColors.add(Colors.grey);
                                  } else {
                                    visibleColors.add(
                                      getColorFromName(
                                        type,
                                        noSprayColor: polyline.originalColor,
                                      ),
                                    );
                                  }
                                }

                                final splitPoints = splitLineIntoSegments(
                                  polyline.points.first,
                                  polyline.points.last,
                                  visibleColors.length,
                                );

                                final List<Polyline> splitPolylines = [];

                                for (
                                  int i = 0;
                                  i < splitPoints.length - 1;
                                  i++
                                ) {
                                  splitPolylines.add(
                                    Polyline(
                                      points: [
                                        splitPoints[i],
                                        splitPoints[i + 1],
                                      ],
                                      strokeWidth: 16,
                                      color: visibleColors[i],
                                    ),
                                  );
                                }

                                return splitPolylines;
                              }).toList(),
                            ), //////////////////////////////////added20-8-2026
                          // if (showUnderGroundLayer)
                          //   PolylineLayer(polylines: underGroundPolylines),
                          if (showPrimaryUnderGroundLayer)
                            PolylineLayer(
                              polylines: primaryUnderGroundPolylines,
                            ),

                          if (showSecondaryUnderGroundLayer)
                            PolylineLayer(
                              polylines: secondaryUnderGroundPolylines,
                            ),
                          if ((showPrimaryOverHeadLayer ||
                                  showSecondaryOverHeadLayer) &&
                              (workLayerVisibility["NO SPRAY"] ?? false))
                            MarkerLayer(markers: noSprayMarkers),
                          if (showConsumerLayer)
                            MarkerLayer(markers: consumerMarkers),
                          if (showPoleLayer) MarkerLayer(markers: poleMarkers),
                          MarkerLayer(markers: _markers),
                          //current position marker
                          MarkerLayer(markers: completedMarkers),
                          MarkerLayer(markers: chatMarkers),
                          MarkerLayer(markers: _markerSearch),
                          // MarkerLayer(
                          //   markers: [
                          //     Marker(
                          //       point: const LatLng(17.3850, 78.4867),
                          //       width: 50,
                          //       height: 50,
                          //       child: const Icon(
                          //         Icons.location_on,
                          //         color: Colors.red,
                          //         size: 40,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                      Visibility(
                        visible: _isVisibleSearchByLocation,
                        child: Positioned(
                          top: 25,
                          left: 20,
                          right: 60,
                          height: 45,
                          child: TypeAheadField<Map<String, dynamic>>(
                            controller: _searchController,

                            builder: (context, controller, focusNode) {
                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: 'Search locations...',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.search),
                                  suffixIcon: controller.text.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            controller.clear();

                                            setState(() {
                                              _showedLocationpin = false;
                                            });
                                          },
                                        )
                                      : null,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2.0,
                                    horizontal: 12.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              );
                            },

                            // Directly call your API
                            suggestionsCallback: (query) async {
                              // if (query.trim().isEmpty) {
                              //   return [];
                              // }
                              final searchText = query.trim();
                              if (searchText.length < 1) {
                                return [];
                              }

                              try {
                                final response =
                                    await getDataByNameAndAccountNumber(
                                      query.trim(),
                                    );

                                if (response is Map &&
                                    response['getDataByNameAndAccountNumber'] !=
                                        null) {
                                  return List<Map<String, dynamic>>.from(
                                    response['getDataByNameAndAccountNumber'],
                                  );
                                }

                                return [];
                              } catch (e) {
                                print("Error getting location suggestions: $e");
                                return [];
                              }
                            },

                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                leading: const Icon(Icons.location_city),
                                title: Text(
                                  suggestion['wmBF_Name'] ??
                                      suggestion['name'] ??
                                      'Unknown',
                                ),
                                subtitle: Text(
                                  "Service: ${suggestion['wmBF_Servi'] ?? ''}\n"
                                  "Parcel: ${suggestion['parcelNumber'] ?? ''}",
                                ),
                              );
                            },

                            onSelected: (suggestion) {
                              _currentZoom = 15.0;

                              _searchController.text =
                                  suggestion['wmBF_Name'] ??
                                  suggestion['name'] ??
                                  suggestion['wmBF_Servi'] ??
                                  'Unknown';

                              _updateMapLocation(
                                suggestion['wmBF_Name'] ??
                                    suggestion['wmBF_Servi'] ??
                                    '',
                                suggestion['geometry'],
                              );

                              setState(() {
                                _showedLocationpin = true;
                              });
                            },
                          ),
                        ),
                      ), ////////////////
                      ////////////////
                      if (showPopup && popupOffset != null)
                        Positioned(
                          left: popupOffset!.dx - 130,
                          top: popupOffset!.dy - 140,
                          child:
                              RegExp(r'\d').hasMatch(
                                overHeadPolylines[selectedPolylineIndex!].jobNo
                                    .trim(),
                              )
                              ? _buildPolylineMarkAsReadPopup()
                              : _buildPolylinePopup(selectedPolylineIndex!),
                          // : const SizedBox.shrink(), // Don't show inline popup
                        ),
                      Positioned(
                        top: 10,
                        right: 5,
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: _toggleMapStyle,
                          mini: true,
                          child: (mapStyle == "street")
                              ? Image.asset(
                                  'assets/satellite_n.png',
                                  width: 24,
                                  height: 34,
                                  // color: Color.fromARGB(255, 7, 59, 120),
                                )
                              : Image.asset(
                                  'assets/map_n.png',
                                  width: 24,
                                  height: 24,
                                ),
                          //  Icon(
                          //   mapStyle == "street" ? Icons.satellite : Icons.map,
                          //   color: Colors.black,
                          // ),
                        ),
                      ),
                      Positioned(
                        top: 60,
                        right: 5,
                        child: FloatingActionButton(
                          heroTag: "layers",
                          mini: true,
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.layers,
                            color: Color.fromARGB(255, 7, 59, 120),
                            // color: Colors.black
                          ),
                          onPressed: () {
                            setState(() {
                              showLayerPanel = !showLayerPanel;
                            });
                          },
                        ),
                      ),

                      Visibility(
                        visible: _isVisibleSpeed,
                        child: Positioned(
                          bottom: 15,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _currentSpeed != null
                                      ? _currentSpeed!.toStringAsFixed(1)
                                      : "0.0",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  "mph",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 5,
                        child: Column(
                          children: [
                            MapActionButton(
                              imagePath: 'assets/list_n.png',
                              onTap: () async {
                                await showReworkDialogBMS(context);
                              },
                            ),
                            const SizedBox(height: 6),
                            GestureDetector(
                              onTap: _resetRotation,
                              child: Transform.rotate(
                                angle: -_deviceHeading * pi / 180,
                                child: Image.asset(
                                  'assets/compass.png',
                                  width: 45,
                                  height: 45,
                                ),
                              ),
                            ),

                            const SizedBox(height: 6),
                            MapActionButton(
                              imagePath: (driveMode == 0)
                                  ? 'assets/gps_black_n.png'
                                  : 'assets/gps_blue_n.png',
                              onTap: _recenterMap,
                            ),
                            // GestureDetector(
                            //   onTap: _recenterMap,
                            //   // mini: true,
                            //   // child: Icon(Icons.my_location,
                            //   //     color: (driveMode == 0)
                            //   //         ? const Color.fromARGB(233, 54, 54, 54)
                            //   //         : const Color.fromARGB(233, 46, 99, 168)),
                            //   child: (driveMode == 0)
                            //       ? Image.asset(
                            //           'assets/location black.png',
                            //           width: 50,
                            //           height: 60,
                            //         )
                            //       : Image.asset(
                            //           'assets/location_blue.png',
                            //           width: 50,
                            //           height: 60,
                            //         ),
                            // ),
                            const SizedBox(height: 6),
                            MapActionButton(
                              imagePath: 'assets/plus_n.png',
                              onTap: _zoomIn,
                            ),

                            const SizedBox(height: 6),
                            MapActionButton(
                              imagePath: 'assets/minus_n.png',
                              onTap: _zoomOut,
                            ),
                            const SizedBox(height: 6),
                            MapActionButton(
                              imagePath: 'assets/f_n.png',
                              onTap: () => _handleFeederTap(context),
                            ),
                            // GestureDetector(
                            //   onTap: () => _handleFeederTap(context),
                            //   // mini: true,
                            //   child:
                            //       // const Icon(Icons.zoom_out),
                            //       Image.asset(
                            //         'assets/F.png',
                            //         width: 50,
                            //         height: 50,
                            //       ),
                            // ),
                            const SizedBox(height: 6),
                            MapActionButton(
                              imagePath: 'assets/w_n.png',
                              onTap: () => _handleWorkTap(context),
                            ),

                            const SizedBox(height: 10),
                            // GestureDetector(
                            //   onTap: () => _handleWorkTap(context),
                            //   // mini: true,
                            //   child:
                            //       // const Icon(Icons.zoom_out),
                            //       Image.asset(
                            //         'assets/W.png',
                            //         width: 50,
                            //         height: 50,
                            //       ),
                            // ),
                          ],
                        ),
                      ),
                      if (showLayerPanel)
                        Positioned(
                          top: 110,
                          right: 10,
                          child: Material(
                            color: Colors.white,
                            elevation: 8,
                            borderRadius: BorderRadius.circular(10),
                            clipBehavior: Clip.antiAlias,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 280,
                                maxHeight: panelHeight,
                                // maxHeight:
                                //     MediaQuery.of(context).size.height *
                                //     0.70, // 65% of screen
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: StatefulBuilder(
                                  builder: (context, panelState) {
                                    return ScrollbarTheme(
                                      data: ScrollbarThemeData(
                                        // thumbColor: WidgetStateProperty.all(
                                        //   Colors.blueGrey
                                        //   // const Color.fromARGB(255, 7, 59, 120),
                                        // ),
                                        trackColor: WidgetStateProperty.all(
                                          Colors.grey.shade300,
                                        ),
                                        trackBorderColor:
                                            WidgetStateProperty.all(
                                              Colors.transparent,
                                            ),
                                        thickness: WidgetStateProperty.all(4),
                                        radius: const Radius.circular(8),
                                      ),

                                      child: Scrollbar(
                                        controller: _layerScrollController,
                                        thumbVisibility: true,
                                        trackVisibility: true,
                                        interactive: true,
                                        // radius: const Radius.circular(8),
                                        // thickness: 4,
                                        child: SingleChildScrollView(
                                          controller: _layerScrollController,
                                          child: Column(
                                            children: [
                                              /// Main Layers
                                              _layerTile(
                                                "Substation",
                                                showSubstationLayer,
                                                (v) {
                                                  panelState(
                                                    () => showSubstationLayer =
                                                        v!,
                                                  );
                                                  setState(() {});
                                                },
                                              ),

                                              // _layerTile(
                                              //   "Overhead",
                                              //   showOverHeadLayer,
                                              //   (v) {
                                              //     panelState(() {
                                              //       showOverHeadLayer = v!;
                                              //       showMaintLayer = v!;
                                              //       // Update all work layer checkboxes
                                              //       workLayerVisibility
                                              //           .updateAll(
                                              //             (key, value) =>
                                              //                 showOverHeadLayer,
                                              //           );
                                              //     });
                                              //     setState(() {
                                              //       _buildStatusMarkers();
                                              //     });
                                              //   },
                                              // ),

                                              // _layerTile(
                                              //   "Underground",
                                              //   showUnderGroundLayer,
                                              //   (v) {
                                              //     panelState(
                                              //       () => showUnderGroundLayer =
                                              //           v!,
                                              //     );
                                              //     setState(() {});
                                              //   },
                                              // ),
                                              _layerTile(
                                                "Primary",
                                                showPrimaryLayer,
                                                (v) {
                                                  panelState(() {
                                                    showPrimaryLayer = v!;
                                                    showPrimaryOverHeadLayer =
                                                        v;
                                                    showPrimaryUnderGroundLayer =
                                                        v;
                                                    showMaintLayer = v!;
                                                    // Update all work layer checkboxes
                                                    if (showMaintLayer) {
                                                      updateWorkLayerVisibilityFromMaintType(
                                                        overHeadPolylines,
                                                      );
                                                    } else {
                                                      workLayerVisibility
                                                          .updateAll(
                                                            (key, value) =>
                                                                false,
                                                          );
                                                    }
                                                  });
                                                  setState(() {});
                                                },
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 25,
                                                ),
                                                child: _layerTile(
                                                  "Overhead",
                                                  showPrimaryOverHeadLayer,
                                                  (v) {
                                                    panelState(() {
                                                      showPrimaryOverHeadLayer =
                                                          v!;

                                                      showPrimaryLayer =
                                                          showPrimaryOverHeadLayer ||
                                                          showPrimaryUnderGroundLayer;
                                                      showMaintLayer = v!;
                                                      // Update all work layer checkboxes
                                                      if (showMaintLayer) {
                                                        updateWorkLayerVisibilityFromMaintType(
                                                          overHeadPolylines,
                                                        );
                                                      } else {
                                                        workLayerVisibility
                                                            .updateAll(
                                                              (key, value) =>
                                                                  false,
                                                            );
                                                      }
                                                      ///////////////////
                                                      // workLayerVisibility
                                                      //     .updateAll(
                                                      //       (key, value) =>
                                                      //           showPrimaryOverHeadLayer,
                                                      //     );
                                                    });
                                                  },
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 25,
                                                ),
                                                child: _layerTile(
                                                  "Underground",
                                                  showPrimaryUnderGroundLayer,
                                                  (v) {
                                                    panelState(() {
                                                      showPrimaryUnderGroundLayer =
                                                          v!;

                                                      showPrimaryLayer =
                                                          showPrimaryOverHeadLayer ||
                                                          showPrimaryUnderGroundLayer;
                                                    });
                                                  },
                                                ),
                                              ),

                                              _layerTile(
                                                "Secondary",
                                                showSecondaryLayer,
                                                (v) {
                                                  panelState(() {
                                                    showSecondaryLayer = v!;
                                                    showSecondaryOverHeadLayer =
                                                        v;
                                                    showSecondaryUnderGroundLayer =
                                                        v;
                                                  });
                                                  setState(() {});
                                                },
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 25,
                                                ),
                                                child: _layerTile(
                                                  "Overhead",
                                                  showSecondaryOverHeadLayer,
                                                  (v) {
                                                    panelState(() {
                                                      showSecondaryOverHeadLayer =
                                                          v!;

                                                      showSecondaryLayer =
                                                          showSecondaryOverHeadLayer ||
                                                          showSecondaryUnderGroundLayer;
                                                    });
                                                  },
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 25,
                                                ),
                                                child: _layerTile(
                                                  "Underground",
                                                  showSecondaryUnderGroundLayer,
                                                  (v) {
                                                    panelState(() {
                                                      showSecondaryUnderGroundLayer =
                                                          v!;

                                                      showSecondaryLayer =
                                                          showSecondaryOverHeadLayer ||
                                                          showSecondaryUnderGroundLayer;
                                                    });
                                                  },
                                                ),
                                              ),

                                              _layerTile(
                                                "Consumer",
                                                showConsumerLayer,
                                                (v) {
                                                  panelState(
                                                    () =>
                                                        showConsumerLayer = v!,
                                                  );
                                                  setState(() {});
                                                },
                                              ),

                                              _layerTile(
                                                "Poles",
                                                showPoleLayer,
                                                (v) {
                                                  panelState(
                                                    () => showPoleLayer = v!,
                                                  );
                                                  setState(() {});
                                                },
                                              ),

                                              //  const Divider(),

                                              /// Expand / Collapse
                                              InkWell(
                                                onTap: () {
                                                  panelState(() {
                                                    expandWorkLayers =
                                                        !expandWorkLayers;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    //
                                                    _layerTile(
                                                      "IVM Work Plan",
                                                      showMaintLayer,
                                                      (v) {
                                                        panelState(() {
                                                          showMaintLayer = v!;

                                                          // Update all work layer checkboxes
                                                          if (showMaintLayer) {
                                                            updateWorkLayerVisibilityFromMaintType(
                                                              overHeadPolylines,
                                                            );
                                                          } else {
                                                            workLayerVisibility
                                                                .updateAll(
                                                                  (
                                                                    key,
                                                                    value,
                                                                  ) => false,
                                                                );
                                                          }
                                                          //IVM WORK PLAN ALL BOXES CHECK and UNCHECK CODE
                                                          // workLayerVisibility
                                                          //     .updateAll(
                                                          //       (key, value) =>
                                                          //           showMaintLayer,
                                                          //     );
                                                        });
                                                        setState(() {
                                                          _buildStatusMarkers();
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Icon(
                                                      expandWorkLayers
                                                          ? Icons
                                                                .keyboard_arrow_down
                                                          : Icons
                                                                .keyboard_arrow_right,
                                                    ),
                                                    // const Text(
                                                    //   "IVM Work Plan",
                                                    //   style: TextStyle(
                                                    //     fontWeight:
                                                    //         FontWeight.bold,
                                                    //     color: Colors.green,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              if (expandWorkLayers) ...[
                                                const SizedBox(height: 5),

                                                ...workLayerVisibility.keys.map((
                                                  name,
                                                ) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          left: 18,
                                                        ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        panelState(() {
                                                          workLayerVisibility[name] =
                                                              !workLayerVisibility[name]!;
                                                               //////for atleast one work type selected///////
                                                               showMaintLayer = workLayerVisibility.values.any(
                                                                (isSelected) => isSelected,
                                                               );
                                                        });
                                                        setState(() {
                                                          _buildStatusMarkers();
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 2,
                                                            ),
                                                        child: Row(
                                                          children: [
                                                            Checkbox(
                                                              value:
                                                                  workLayerVisibility[name],
                                                              visualDensity:
                                                                  VisualDensity
                                                                      .compact,
                                                              materialTapTargetSize:
                                                                  MaterialTapTargetSize
                                                                      .shrinkWrap,
                                                              activeColor:
                                                                  getColorFromName(
                                                                    name,
                                                                  ),
                                                              // const Color.fromARGB(
                                                              //   255,
                                                              //   7,
                                                              //   59,
                                                              //   120,
                                                              // ),
                                                              onChanged: (value) {
                                                                panelState(() {
                                                                  workLayerVisibility[name] =
                                                                      value!;
                                                                                                                                            //////for atleast one work type selected///////
                                                                showMaintLayer = workLayerVisibility.values.any(
                                                                (isSelected) => isSelected,
                                                                );
                                                                });
                                                                setState(() {
                                                                  _buildStatusMarkers();
                                                                });
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              width: 2,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                name,
                                                                style:
                                                                    const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _recenterMap() async {
    if (_currentLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Current location not available.")),
      );
      return;
    }
    setState(() {
      if (driveMode == 0) {
        driveMode = 1;
        _mapController.move(_currentLocation!, _currentZoom);
        _isVisibleSpeed = true;
      } else {
        driveMode = 0;
        _isVisibleSpeed = false;
      }
    });
  }

  void _startListeningToCompass() {
    // print("_startListeningToCompass called");
    // FlutterCompass.events?.listen((CompassEvent event) {
    _compassSubscription = FlutterCompass.events?.listen((CompassEvent event) {
      if (!mounted) return; // prevents calling setState on disposed widget
      setState(() {
        _deviceHeading = event.heading ?? 0.0;
        if (driveMode == 1) {
          _mapController.rotate(-_deviceHeading);
        }
      });
    });
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 1).clamp(1.0, 22.0);
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _zoomOut() {
    // print('zoomOut pressed');
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(1.0, 22.0);
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _resetRotation() {
    setState(() {
      _deviceHeading = 0.0;
    });
    _mapController.rotate(0.0);
  }

  // Function to toggle map style
  void _toggleMapStyle() {
    setState(() {
      mapStyle = (mapStyle == "street") ? "satellite" : "street";
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));

    // CustomToastSnackBarProgressDialog.flushBarSuccessMessage(message, context);
  }

  Future<String?> _showFeederColorDialog(BuildContext context) async {
    Map<String, Color> colorMap = {
      "FDR1": const Color.fromARGB(255, 1, 127, 5),
      "FDR2": const Color.fromARGB(255, 96, 0, 113),
      "FDR3": const Color.fromARGB(255, 247, 19, 2),
      "FDR4": const Color.fromARGB(255, 38, 1, 247),
      "FDR5": Colors.yellow,
      "FDR6": const Color.fromARGB(255, 113, 68, 1),
    };

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Color Feeder",
                style: TextStyle(color: Color.fromARGB(255, 7, 59, 120)),
              ), // Title
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: colorMap.entries.map((entry) {
              return ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                minTileHeight: 32,
                leading: Container(
                  width: 60,
                  height: 8,
                  decoration: BoxDecoration(
                    color: entry.value,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                title: Text(entry.key.toUpperCase()),
                onTap: () {
                  Navigator.pop(
                    context,
                    entry.key,
                  ); // Return the selected color
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _handleFeederTap(BuildContext context) async {
    String? selectedColor = await _showFeederColorDialog(context);
    if (selectedColor != null) {
      print("Selected color: $selectedColor");
    }
  }

  Future<String?> _showWorkColorDialog(BuildContext context) async {
    Map<String, Color> colorMap = {
      "Jarraff": const Color.fromARGB(255, 96, 0, 113),
      "Mowing": const Color.fromARGB(255, 113, 68, 1),
      "Mini Jarraff": const Color.fromARGB(255, 247, 19, 2),
      "BYL": const Color.fromARGB(255, 2, 212, 249),
      "Bucket": Colors.orange,
      "Ground": Colors.yellow,
      "Cross-country spray": const Color.fromARGB(255, 38, 1, 247),
      "Roadside spray": const Color.fromARGB(255, 1, 127, 5),
      "No spray": const Color.fromARGB(255, 252, 199, 249),
    };

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Color Work",
                style: TextStyle(color: Color.fromARGB(255, 7, 59, 120)),
              ), // Title
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: colorMap.entries.map((entry) {
              return ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                minTileHeight: 32,
                leading: Container(
                  width: 60,
                  height: 8,
                  decoration: BoxDecoration(
                    color: entry.value,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                title: Text(entry.key.toUpperCase()),
                onTap: () {
                  Navigator.pop(
                    context,
                    entry.key,
                  ); // Return the selected color
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _handleWorkTap(BuildContext context) async {
    String? selectedColor = await _showWorkColorDialog(context);
    if (selectedColor != null) {
      print("Selected color: $selectedColor");
    }
  }

  String id = "";
  String token = "";
  String userName = "";

  Future<void> loadApiData() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    id = data.user!.id.toString();
    token = data.token.toString();
    userName = data.user!.fName.toString();
    _createdByCO.text = userName;
    clearWorkTypes();
    lines.clear();
    print('line1---------$lines');
    selectedMapObjects.clear();
    print("selectedMapObjects ${jsonEncode(selectedMapObjects)}");
    showLoader(context);
    final connectivityResult = await Connectivity().checkConnectivity();

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      // Internet available
      // await DatabaseHelper.instance.fetchAndSaveDropdownData(
      //   selectedYear.toString(),
      //   selectedSubstationId.toString(),
      // );
      // if (!mounted) return;
      await DatabaseHelper.instance.fetchAndSaveMapData(
        selectedSubstation.toString(),
        selectedFeeder.toString(),
        token,
      );
      if (!mounted) return;
      // await DatabaseHelper.instance.fetchAndSaveContractors();
      // if (!mounted) return;
      print("Fetched from API and saved to SQLite");
    } else {
      print("Offline - Loading from SQLite");
    }
    // // Load dropdown values from SQLite
    // await loadDropdownData();
    // if (!mounted) return;

    // ///load assigneforeman values
    // await loadForemanData();
    // if (!mounted) return;
    ////////////////////////////overhead///////

    // Color polylineColor = Colors.grey;
    if (selectedFeeder == "FDR1") {
      polylineColor = const Color.fromARGB(255, 1, 127, 5);
    } else if (selectedFeeder == "FDR2") {
      polylineColor = const Color.fromARGB(255, 96, 0, 113);
    } else if (selectedFeeder == "FDR3") {
      polylineColor = const Color.fromARGB(255, 247, 19, 2);
    } else if (selectedFeeder == "FDR4") {
      polylineColor = const Color.fromARGB(255, 38, 1, 247);
    } else if (selectedFeeder == "FDR5") {
      polylineColor = Colors.yellow;
    } else if (selectedFeeder == "FDR6") {
      polylineColor = const Color.fromARGB(255, 113, 68, 1);
    }
    overHeadData = await DatabaseHelper.instance.getOverHeadData(
      selectedSubstation.toString(),
      selectedFeeder.toString(),
    );
    print("Overhead rows: ${overHeadData.length}");
    overHeadPolylines.clear();

    for (var row in overHeadData) {
      final wkt = row["wkt"];

      if (wkt != null && wkt.toString().isNotEmpty) {
        final points = parseLineString(row["wkt"]);
        // final maintType = (row["maintType"] ?? "").toString().trim();
        // // If maintType has any value, use a lighter feeder color.
        // // Otherwise use the normal feeder color.
        // final Color lineColor = maintType.isNotEmpty
        //     ? lightenColor(polylineColor)
        //     : polylineColor;
        //////////// //////////////////////////////////added20-8-2026
        // Always keep the actual original feeder color.
        // final Color lineColor = polylineColor;
        // service = 1 -> Black
        // service = 0 -> Feeder color
        final Color lineColor = row["service"] == "1"
            ? Colors.black
            : polylineColor;
        //////////////////////////////////added20-8-2026
        overHeadPolylines.add(
          //       Polyline(
          //   points: parseLineString(wkt),
          //   strokeWidth: 12,
          //   color: polylineColor,
          // ),
          /////polyline ontap-------
          OverHeadPolylineData(
            phase: row["phase"]?.toString() ?? "",
            vegetationColor: row["vegetationColor"]?.toString() ?? "",
            maintType: row["maintType"]?.toString() ?? "",
            jobNo: row["jobNo"]?.toString() ?? "",
            feederName: row["feederName"]?.toString() ?? "",
            oid: row["oId"],
            substationFeederId: row["substationFeederId"]?.toString() ?? "",
            wkt: wkt.toString(),
            points: points,
            originalColor: lineColor,
            substation: row["substation"]?.toString() ?? "",
            elementName: row["elementName"]?.toString() ?? "",
            distanceMiles: calculatePolylineLengthMiles(points),
            totalMilesApi: row["totalMiles"]?.toString() ?? "",
            spanDistanceApi: row["spanDistance"]?.toString() ?? "",
            contractorId: row["contractorId"]?.toString() ?? "",
            substationId: row["substationId"]?.toString() ?? "",
            hasChat: (row["hasChat"]?.toString().toLowerCase() == "true"),
            createDate: row["createDate"]?.toString() ?? "",
            maintStatus: row["maintStatus"]?.toString() ?? "",
            rework: row["rework"]?.toString() ?? "",
            completedByCrewName: row["completedByCrewName"]?.toString() ?? "",
            completedByCrewId: row["completedByCrewId"]?.toString() ?? "",
            assignedCrewName: row["assignedCrewName"]?.toString() ?? "",
            assignedCrewId: row["assignedCrewId"]?.toString() ?? "",
            coordinateIds: row["coordinateIds"]?.toString() ?? "",
            completionFlag: row["completionFlag"]?.toString() ?? "",
            service: row["service"]?.toString() ?? "",
          ),
          /////-------
        );
      }
    }
    updateWorkLayerVisibilityFromMaintType(overHeadPolylines);
    ////
    chatMarkers.clear();
    _buildStatusMarkers();
    /////////////
    for (int i = 0; i < overHeadPolylines.length; i++) {
      final polyline = overHeadPolylines[i];

      if (!polyline.hasChat) continue;

      final LatLng center = getPolylineCenter(polyline.points);

      chatMarkers.add(
        Marker(
          point: center,
          width: 28,
          height: 28,
          child: GestureDetector(
            onTap: () {
              _showDetailsPopupUpdate(i);
            },
            child: Image.asset("assets/note_icon_n.png"),
            //const Icon(Icons.chat, color: Colors.white, size: 30),
          ),
        ),
      );
    }
    // ================= NO SPRAY MARKERS =================
    noSprayMarkers.clear();

    for (int i = 0; i < overHeadPolylines.length; i++) {
      final polyline = overHeadPolylines[i];

      if (polyline.points.isEmpty) {
        continue;
      }

      final maintTypes = polyline.maintType
          .split(",")
          .map((e) => e.trim().toUpperCase())
          .where((e) => e.isNotEmpty)
          .toList();

      final noSprayIndex = maintTypes.indexOf("NO SPRAY");

      if (noSprayIndex == -1) {
        continue;
      }

      // Optional:
      // Show label only when NO SPRAY layer is enabled.
      if (!(workLayerVisibility["NO SPRAY"] ?? false)) {
        continue;
      }

      // Split the same way as your polyline
      // so the label is placed in the NO SPRAY section.
      final splitPoints = splitLineIntoSegments(
        polyline.points.first,
        polyline.points.last,
        maintTypes.length,
      );

      if (splitPoints.length < 2) {
        continue;
      }

      final startPoint =
          splitPoints[noSprayIndex.clamp(0, splitPoints.length - 2)];

      final endPoint =
          splitPoints[(noSprayIndex + 1).clamp(1, splitPoints.length - 1)];

      final noSprayCenter = LatLng(
        (startPoint.latitude + endPoint.latitude) / 2,
        (startPoint.longitude + endPoint.longitude) / 2,
      );

      noSprayMarkers.add(
        Marker(
          point: noSprayCenter,

          // Small label
          width: 65,
          height: 25,

          // Point of Marker is at the top,
          // so label appears just below the polyline.
          alignment: Alignment.topCenter,

          child: GestureDetector(
            onTap: () {
              _showDetailsPopupUpdate(i);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFE85B5B),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: const Text(
                "No Spray",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    }
    //////////////-------------------
    //////////////////underground////
    final undergroundData = await DatabaseHelper.instance.getUnderGroundData(
      selectedSubstation.toString(),
      selectedFeeder.toString(),
    );

    print("Underground rows: ${undergroundData.length}");

    //  underGroundPolylines.clear();
    primaryUnderGroundPolylines.clear();
    secondaryUnderGroundPolylines.clear();
    Color undergroundColor = Colors.orange;

    // Optional: use feeder color
    if (selectedFeeder == "FDR1") {
      undergroundColor = const Color.fromARGB(255, 1, 127, 5);
    } else if (selectedFeeder == "FDR2") {
      undergroundColor = const Color.fromARGB(255, 96, 0, 113);
    } else if (selectedFeeder == "FDR3") {
      undergroundColor = const Color.fromARGB(255, 247, 19, 2);
    } else if (selectedFeeder == "FDR4") {
      undergroundColor = const Color.fromARGB(255, 38, 1, 247);
    } else if (selectedFeeder == "FDR5") {
      undergroundColor = Colors.yellow;
    } else if (selectedFeeder == "FDR6") {
      undergroundColor = const Color.fromARGB(255, 113, 68, 1);
    }

    // for (var row in undergroundData) {
    //   final wkt = row["wkt"];

    //   if (wkt != null && wkt.toString().isNotEmpty) {
    //     underGroundPolylines.add(
    //       Polyline(
    //         points: parseLineString(wkt),
    //         strokeWidth: 8,
    //         color: row["service"] == "1" ? Colors.black : undergroundColor,
    //         pattern: StrokePattern.dashed(segments: [5, 10]),
    //       ),
    //     );
    //   }
    // }
    for (var row in undergroundData) {
      final wkt = row["wkt"];

      if (wkt != null && wkt.toString().isNotEmpty) {
        final polyline = Polyline(
          points: parseLineString(wkt),
          strokeWidth: 8,
          color: row["service"]?.toString() == "1"
              ? Colors.black
              : undergroundColor,
          pattern: StrokePattern.dashed(segments: [5, 10]),
        );

        if (row["service"]?.toString() == "0") {
          primaryUnderGroundPolylines.add(polyline);
        } else if (row["service"]?.toString() == "1") {
          secondaryUnderGroundPolylines.add(polyline);
        }
      }
    }
    ////////////////////poles////////////
    final polesData = await DatabaseHelper.instance.getPolesData(
      selectedSubstation.toString(),
    );

    print("Pole rows: ${polesData.length}");

    poleMarkers.clear();

    for (var row in polesData) {
      final geometry = row["geometry"];

      if (geometry != null && geometry.toString().isNotEmpty) {
        final point = parsePoint(geometry);

        poleMarkers.add(
          Marker(
            point: point,
            width: 14,
            height: 14,
            child: GestureDetector(
              onTap: () {
                _showPolePopup(
                  row["elementName"] ?? "",
                  row["substation"] ?? "",
                  row["feederName"] ?? "",
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
              ),
            ),
          ),
          // Marker(
          //   point: point,
          //   width: 30,
          //   height: 30,
          //   child: Image.asset(
          //     'assets/period1.png',
          //     fit: BoxFit.cover,
          //   ),

          // ),
        );
      }
    }
    ///////consumer
    final consumerData = await DatabaseHelper.instance.getConsumerData(
      selectedSubstation.toString(),
    );

    print("Consumer rows: ${consumerData.length}");

    consumerMarkers.clear();

    // for (var row in consumerData) {
    //   final geometry = row["geometry"];

    //   if (geometry != null && geometry.toString().isNotEmpty) {
    //     final point = parsePoint(geometry);

    //     consumerMarkers.add(
    //       Marker(
    //         point: point,
    //         width: 14,
    //         height: 14,
    //         child:  GestureDetector(
    //   onTap: () {
    //     fetchDataAndShowDialog(
    //                             context,
    //                             point.longitude,
    //                             point.latitude,
    //                             row["mapLocation"],
    //                           );
    //   },
    //           child: Container(
    //             decoration: BoxDecoration(
    //               color: Colors.lightGreenAccent,
    //               shape: BoxShape.circle,
    //               border: Border.all(color: Colors.black, width: 1),
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   }
    // }
    for (var row in consumerData) {
      final geometry = row["geometry"];

      if (geometry != null && geometry.toString().isNotEmpty) {
        final point = parsePoint(geometry);

        final bool hasComment =
            row["hasComment"]?.toString().toLowerCase() == "true";

        final String phasing = row["phasing"].toString();

        void showConsumerDialog() {
          fetchDataAndShowDialog(
            context,
            point.longitude,
            point.latitude,
            row["mapLocation"],
          );
        }

        consumerMarkers.add(
          Marker(
            point: point,
            width: 28,
            height: 28,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Consumer point
                Positioned(
                  left: 7,
                  top: 7,
                  child: GestureDetector(
                    onTap: showConsumerDialog,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: phasing == 'A'
                            ? Colors.red
                            : phasing == 'B'
                            ? const Color.fromARGB(255, 29, 109, 248)
                            : phasing == 'C'
                            ? Colors.lightGreenAccent
                            : phasing == '2'
                            ? Colors.yellow
                            : phasing == '3'
                            ? Colors.purple
                            : Colors.brown,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                ),

                // Comment icon
                if (hasComment)
                  Positioned(
                    left: 14,
                    top: 1,
                    child: GestureDetector(
                      onTap: showConsumerDialog,
                      child: Image.asset(
                        "assets/new_excl.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }
    }
    ////////////////////boundary
    substationBoundaryPolygons.clear();

    final boundaryData = await DatabaseHelper.instance.getBoundaryData(
      selectedSubstation.toString(),
    );

    print("Boundary rows: ${boundaryData.length}");
    for (final row in boundaryData) {
      final geometry = row["geometry"];

      if (geometry != null && geometry.toString().isNotEmpty) {
        final polygons = parseMultiPolygon(geometry);

        for (final polygon in polygons) {
          substationBoundaryPolygons.add(
            Polygon(
              points: polygon,
              borderStrokeWidth: 4,
              borderColor: const Color.fromRGBO(245, 127, 23, 1),
              color: Colors.yellow.withValues(alpha: 0.12),
              label: selectedSubstation,
            ),
          );
        }
      }
    }
    ////
    // // Initial center by default
    final List<LatLng> allPoints = [];
    // Polyline points
    for (final polyline in overHeadPolylines) {
      allPoints.addAll(polyline.points);
    }
    //umder ground
    // for (final polyline in underGroundPolylines) {
    //   allPoints.addAll(polyline.points);
    // }
    // Underground points
    for (final polyline in primaryUnderGroundPolylines) {
      allPoints.addAll(polyline.points);
    }

    for (final polyline in secondaryUnderGroundPolylines) {
      allPoints.addAll(polyline.points);
    }
    // Pole points
    for (final marker in poleMarkers) {
      allPoints.add(marker.point);
    }
    //consumer
    for (final marker in consumerMarkers) {
      allPoints.add(marker.point);
    }

    ////boundary
    for (final polygon in substationBoundaryPolygons) {
      allPoints.addAll(polygon.points);
    }

    // if (allPoints.isNotEmpty) {
    //   final bounds = LatLngBounds.fromPoints(allPoints);

    //   _mapController.fitCamera(
    //     CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(40)),
    //   );
    //   print('data loaded---------------');
    //   Navigator.pop(context);
    // } else {
    //   print('No data found---------------');
    //   Navigator.pop(context);
    // }
    ///////////////////////
    // if (mounted) {
    //   setState(() {});
    // }

    bool latestObjectFound = false;

    if (overHeadData.isNotEmpty) {
      latestObjectFound = await _setLatestObjectAndZoom();

      if (latestObjectFound) {
        print("Map zoomed to latest created object");
      }
    }

    // If latest createDate object is NOT found,
    // use the existing allPoints fit-camera logic.
    if (!latestObjectFound) {
      if (allPoints.isNotEmpty) {
        final bounds = LatLngBounds.fromPoints(allPoints);

        _mapController.fitCamera(
          CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(40)),
        );

        print("Latest createDate object not found");
        print("Map fitted to all available points");
      } else {
        print("No data found");
      }
    }

    if (mounted) {
      setState(() {});
    }

    Navigator.pop(context);
  }

  void updateWorkLayerVisibilityFromMaintType(
    List<OverHeadPolylineData> objects,
  ) {
    final Set<String> availableWorkTypes = {};

    for (final object in objects) {
      final maintType = object.maintType;

      if (maintType == null || maintType.trim().isEmpty) {
        continue;
      }

      final types = maintType
          .split(',')
          .map((type) => type.trim().toUpperCase())
          .where((type) => type.isNotEmpty);

      availableWorkTypes.addAll(types);
    }

    workLayerVisibility.updateAll((key, value) {
      return availableWorkTypes.contains(key.toUpperCase());
    });
    // atleast one child work layer is selected.
  showMaintLayer = workLayerVisibility.values.any(
    (isSelected) => isSelected,
  );

    print('availableWorkTypes: $availableWorkTypes');
    print('workLayerVisibility: $workLayerVisibility');
  }

  void _buildStatusMarkers() {
    completedMarkers.clear();

    for (int i = 0; i < overHeadPolylines.length; i++) {
      final polyline = overHeadPolylines[i];

      final maintTypes = polyline.maintType
          .split(',')
          .map((e) => e.trim())
          .toList();

      final maintStatuses = polyline.maintStatus
          .split(',')
          .map((e) => e.trim())
          .toList();

      final completionFlags = polyline.completionFlag
          .split(',')
          .map((e) => e.trim())
          .toList();

      final reworkArray = polyline.rework
          .split(',')
          .map((e) => e.trim())
          .toList();

      if (maintTypes.isEmpty) continue;

      final splitPoints = splitLineIntoSegments(
        polyline.points.first,
        polyline.points.last,
        maintTypes.length,
      );

      for (int j = 0; j < maintTypes.length; j++) {
        final maintType = maintTypes[j].trim();

        // IMPORTANT: skip hidden maintenance types
        if (!(workLayerVisibility[maintType] ?? true)) {
          continue;
        }

        if (j >= maintStatuses.length ||
            j >= completionFlags.length ||
            j >= reworkArray.length) {
          continue;
        }

        final status = maintStatuses[j].trim();
        final flag = completionFlags[j].trim();
        final rework = reworkArray[j].trim();

        final validStatuses = [
          "completed",
          "final completed",
          "approved",
          "rework",
          "failed",
          "rejected",
          "passed",
          "pending lcp inspection",
          "rework completed",
        ];

        if (!validStatuses.contains(status.toLowerCase())) {
          continue;
        }

        final center = LatLng(
          (splitPoints[j].latitude + splitPoints[j + 1].latitude) / 2,
          (splitPoints[j].longitude + splitPoints[j + 1].longitude) / 2,
        );

        completedMarkers.add(
          Marker(
            point: center,
            width: 34,
            height: 34,
            child:
                (status.toLowerCase() == "completed" &&
                    flag == "1" &&
                    rework.toLowerCase() != "rework completed")
                ? Container(
                    decoration: BoxDecoration(
                      color: getColorFromName(maintType),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  )
                : Image.asset(
                    getStatusImage(status, flag, rework, maintType),
                    width: 34,
                    height: 34,
                    fit: BoxFit.contain,
                  ),
          ),
        );
      }
    }
  }

  List<LatLng> parseLineString(String wkt) {
    wkt = wkt.replaceAll("LINESTRING (", "");
    wkt = wkt.replaceAll("LINESTRING(", "");
    wkt = wkt.replaceAll(")", "");

    final points = wkt.split(",");

    return points.map((point) {
      final coords = point.trim().split(RegExp(r"\s+"));

      final longitude = double.parse(coords[0]);
      final latitude = double.parse(coords[1]);

      return LatLng(latitude, longitude);
    }).toList();
  }

  LatLng parsePoint(String wkt) {
    wkt = wkt.replaceAll("POINT (", "");
    wkt = wkt.replaceAll("POINT(", "");
    wkt = wkt.replaceAll(")", "");

    final coords = wkt.trim().split(RegExp(r"\s+"));

    final longitude = double.parse(coords[0]);
    final latitude = double.parse(coords[1]);

    return LatLng(latitude, longitude);
  }

  Widget _buildDropdown(
    String hint,
    String? value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return SizedBox(
      height: 40,
      child: DropdownButtonFormField<String>(
        initialValue: items.contains(value) ? value : null,
        isExpanded: true,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  // Future<void> loadDropdownData() async {
  //   // Years
  //   final years = await DatabaseHelper.instance.getYears();
  //   yearList = years.map((e) => e["year"].toString()).toSet().toList();

  //   // Substations
  //   final substations = await DatabaseHelper.instance.getSubstations(
  //     selectedYear.toString(),
  //   );

  //   final uniqueSubstations = <String, Map<String, dynamic>>{};

  //   for (var item in substations) {
  //     uniqueSubstations[item["subName"]] = item;
  //   }

  //   substationList = uniqueSubstations.values.map((e) {
  //     return Substation(subId: e["subId"], subName: e["subName"]);
  //   }).toList();

  //   // Feeders
  //   final feeders = await DatabaseHelper.instance.getFeeders(
  //     selectedSubstation.toString(),
  //   );
  //   feederList = feeders
  //       .map((e) => e["feederName"].toString())
  //       .toSet()
  //       .toList();

  //   // // Optional: Select first item by default
  //   // if (yearList.isNotEmpty) {
  //   //   selectedYear ??= yearList.first;
  //   // }

  //   // if (substationList.isNotEmpty) {
  //   //   // selectedSubstation ??= substationList.first;
  //   // }

  //   // if (feederList.isNotEmpty) {
  //   //   selectedFeeder ??= feederList.first;
  //   // }
  // }

  // Future<void> loadForemanData() async {
  //   foremanList = await DatabaseHelper.instance.getContractors();
  //   if (foremanList.isNotEmpty) {
  //     selectedForemanId = foremanList.first["contractorId"];
  //     selectedForeman = foremanList.first["fName"]; // Optional
  //   }
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  String selectedSpanName = "";

  ///polyline on tap-----------------------
  Future<void> _onPolylineTap(LatLng tapPoint) async {
    print("Map tapped");
    double nearestDistance = double.infinity;
    int? nearestIndex;

    for (int i = 0; i < overHeadPolylines.length; i++) {
      final distance = _distanceToPolyline(
        tapPoint,
        overHeadPolylines[i].points,
      );
      // print("Polyline $i : $distance");
      if (distance < nearestDistance) {
        nearestDistance = distance;
        nearestIndex = i;
      }
    }
    print("Nearest Distance = $nearestDistance");
    if (nearestIndex != null && nearestDistance <= 5) {
      final screenPoint = _mapController.camera.latLngToScreenOffset(tapPoint);
      // Store the selected polyline
      selectedPolylineIndex = nearestIndex;

      final jobNo = overHeadPolylines[nearestIndex].jobNo;
      if ((jobNo ?? "").trim().isEmpty) {
        setState(() {
          // selectedPolylineIndexes.add(nearestIndex!);
          // Store the currently selected polyline
          selectedPolylineIndex = nearestIndex;
          if (!selectedPolylineIndexes.contains(nearestIndex)) {
            selectedPolylineIndexes.add(nearestIndex!);

            currentSelectedDistanceMiles =
                overHeadPolylines[nearestIndex].distanceMiles;

            totalSelectedDistanceMiles +=
                overHeadPolylines[nearestIndex].distanceMiles;
          } else {
            // Already selected, just show its distance in the popup
            currentSelectedDistanceMiles =
                overHeadPolylines[nearestIndex!].distanceMiles;
          }

          ////
          selectedPopupLatLng = tapPoint;
          selectedWkt = overHeadPolylines[nearestIndex].wkt;
          selectedSubstation = overHeadPolylines[nearestIndex].substation;
          selectedSpanName = overHeadPolylines[nearestIndex].elementName;
          popupOffset = screenPoint;
          showPopup = true;
        });
        //////////////create objects
        final prefs = await SharedPreferences.getInstance();
        final workTypes = prefs.getStringList("selectedWorkTypes") ?? [];

        // if (workTypes.isNotEmpty) {
        final polyline = overHeadPolylines[nearestIndex];

        final exists = selectedMapObjects.any((e) => e["oId"] == polyline.oid);
        print("Tapped OID: ${polyline.oid}");
        print(jsonEncode(selectedMapObjects));
        print("Exists: $exists");

        if (!exists) {
          selectedMapObjects.add({
            "createdById": id,
            "contractorId": selectedForemanId,
            "substationId": selectedSubstationId,
            "feederName": polyline.feederName,
            "totalMiles": totalSelectedDistanceMiles.toStringAsFixed(2),
            "maintType": workTypes.join(","),
            "wkt": polyline.wkt,
            "elementName": polyline.elementName,
            "opacity": "0.7",
            "spanDistance": currentSelectedDistanceMiles.toStringAsFixed(2),
            "oId": polyline.oid,
            "jobNo": "",
            "comments": "",
          });
          print("111111 ${jsonEncode(selectedMapObjects)}");
        }
      }
      // else {
      //   // Hide popup and open details dialog
      //   setState(() {
      //     showPopup = false;
      //   });
      //   _showDetailsPopupUpdate(nearestIndex);
      // }
      else {
        setState(() {
          selectedPolylineIndex = nearestIndex;
          selectedPopupLatLng = tapPoint;
          popupOffset = screenPoint;
          showPopup = true;
        });

        _updatePopupPosition();
      }
      // }
      ////////////////
      _updatePopupPosition();
      print("===============");
      print("NEW WKT");
      print(overHeadPolylines[nearestIndex].wkt);
      print("Substation : ${overHeadPolylines[nearestIndex].substation}");

      print("===============");
      print("ALL SELECTED WKTs");
      print(selectedPolylineIndexes);
      for (int index in selectedPolylineIndexes) {
        print(overHeadPolylines[index].wkt);
        print(overHeadPolylines[index].substation);
      }
    }
  }

  double _distanceToPolyline(LatLng point, List<LatLng> polyline) {
    double minDistance = double.infinity;

    for (int i = 0; i < polyline.length - 1; i++) {
      final distance = _distanceToSegment(point, polyline[i], polyline[i + 1]);

      if (distance < minDistance) {
        minDistance = distance;
      }
    }

    return minDistance;
  }

  double _distanceToSegment(LatLng p, LatLng a, LatLng b) {
    const meterPerDegree = 111320.0;

    final px = p.longitude * meterPerDegree;
    final py = p.latitude * meterPerDegree;

    final ax = a.longitude * meterPerDegree;
    final ay = a.latitude * meterPerDegree;

    final bx = b.longitude * meterPerDegree;
    final by = b.latitude * meterPerDegree;

    final dx = bx - ax;
    final dy = by - ay;

    if (dx == 0 && dy == 0) {
      return sqrt(pow(px - ax, 2) + pow(py - ay, 2));
    }

    double t = ((px - ax) * dx + (py - ay) * dy) / (dx * dx + dy * dy);

    t = t.clamp(0.0, 1.0);

    final nearestX = ax + t * dx;
    final nearestY = ay + t * dy;

    return sqrt(pow(px - nearestX, 2) + pow(py - nearestY, 2));
  }

  //------------------------------------
  Color lightenColor(Color color, [double amount = 0.5]) {
    return Color.lerp(color, Colors.white, amount)!;
  }

  Widget _buildPolylinePopup(int index) {
    print('open popup');
    print('jobNo------- ${overHeadPolylines[selectedPolylineIndex!].jobNo}');
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(blurRadius: 8, color: Colors.black26),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),

                      // Delete Icon
                      InkWell(
                        onTap: () {
                          deleteSelectedPolyline();
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 22,
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 4,
                      ), // <-- Change this value to adjust spacing
                      // Details Icon
                      // InkWell(
                      //   onTap: () async {
                      //     try {
                      //       final prefs = await SharedPreferences.getInstance();
                      //       print("SharedPreferences initialized");
                      //     } catch (e) {
                      //       print(e);
                      //     }
                      //     // Details action
                      //     _showDetailsPopup();
                      //   },
                      //   borderRadius: BorderRadius.circular(20),
                      //   child: const Padding(
                      //     padding: EdgeInsets.all(4),
                      //     child: Icon(
                      //       Icons.fullscreen,
                      //       color: Colors.blue,
                      //       size: 22,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(width: 4), // <-- Change this value
                      // Close Icon
                      InkWell(
                        onTap: () {
                          setState(() {
                            showPopup = false;
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.cancel_presentation_sharp,
                            color: Colors.red,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Text(
                  //   "Substation : $selectedSubstation",
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Text(
                  //   selectedWkt,
                  //   maxLines: 5,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                  // Text(
                  //   "Selected Distance : "
                  //   "${currentSelectedDistanceMiles.toStringAsFixed(2)} miles",
                  // ),
                  const SizedBox(height: 8),

                  // Text.rich(
                  //   TextSpan(
                  //     children: [
                  //       const TextSpan(
                  //         text: "Distance : ",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //           fontSize: 18,
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text:
                  //             "${totalSelectedDistanceMiles.toStringAsFixed(2)} miles",
                  //         style: const TextStyle(
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.black,
                  //           fontSize: 18,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: "Span Name : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: "${selectedSpanName}",
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () async {
                        showCreateChangeOrderDialog(index);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 40,
                        width: 180,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 34, 113, 249),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Create Change Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 20,
            height: 20,
            transform: Matrix4.rotationZ(0.785398),
            decoration: const BoxDecoration(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildPolylineMarkAsReadPopup() {
    print('open popup');
    print('jobNo------- ${overHeadPolylines[selectedPolylineIndex!].jobNo}');
    final polyline = overHeadPolylines[selectedPolylineIndex!];
    // // Check whether this particular span was marked as completed
    // isMarkAsRead = lines.any((e) => e["mapId"] == polyline.oid.toString());
    // If Mark As Read is already checked globally,
    // automatically add this span's maintTypes.
    if (isMarkAsRead) {
      final maintTypes = polyline.maintType
          .split(',')
          .map((e) => e.trim())
          .toList();

      final maintStatuses = polyline.maintStatus
          .split(',')
          .map((e) => e.trim())
          .toList();

      final coordinateIds = polyline.coordinateIds
          .split(',')
          .map((e) => e.trim())
          .toList();

      for (int i = 0; i < maintTypes.length; i++) {
        final maintType = maintTypes[i];

        final maintStatus = i < maintStatuses.length ? maintStatuses[i] : "";

        // Skip completed maintenance types
        if (maintStatus.toLowerCase() == "completed") {
          continue;
        }

        final parentFeatureId = i < coordinateIds.length
            ? coordinateIds[i]
            : "";

        final exists = lines.any(
          (e) =>
              e["parentFeatureId"] == parentFeatureId &&
              e["maintTypes"] == maintType,
        );

        if (!exists) {
          lines.add({
            "mapId": polyline.oid.toString(),
            "crewId": id.toString(),
            "parentFeatureId": parentFeatureId,
            "maintTypes": maintType,
            "tokenNo": widget.jobNo,
          });
        }
      }
    }
    final allStatusesCompleted = overHeadPolylines[selectedPolylineIndex!]
        .maintStatus
        .split(',')
        .map((e) => e.trim().toLowerCase())
        .where((e) => e.isNotEmpty)
        .every((e) => e == "completed");
    print("lines######small $lines");
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(blurRadius: 8, color: Colors.black26),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),

                      // Delete Icon
                      // InkWell(
                      //   onTap: () {
                      //     deleteSelectedPolyline();
                      //   },
                      //   borderRadius: BorderRadius.circular(20),
                      //   child: const Padding(
                      //     padding: EdgeInsets.all(4),
                      //     child: Icon(
                      //       Icons.delete,
                      //       color: Colors.red,
                      //       size: 22,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        width: 4,
                      ), // <-- Change this value to adjust spacing
                      // Details Icon
                      InkWell(
                        onTap: () {
                          // Hide the small popup
                          setState(() {
                            showPopup = false;
                          });

                          // Open the update dialog
                          _showDetailsPopupUpdate(selectedPolylineIndex!);
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.fullscreen,
                            color: Colors.blue,
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4), // <-- Change this value
                      // Close Icon
                      InkWell(
                        onTap: () {
                          setState(() {
                            showPopup = false;
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.cancel_presentation_sharp,
                            color: Colors.red,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  if (!allStatusesCompleted)
                    Row(
                      children: [
                        Checkbox(
                          value: isMarkAsRead,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            final polyline =
                                overHeadPolylines[selectedPolylineIndex!];

                            setState(() {
                              isMarkAsRead = value ?? false;

                              if (isMarkAsRead) {
                                final maintTypes = polyline.maintType
                                    .split(',')
                                    .map((e) => e.trim())
                                    .toList();

                                final maintStatuses = polyline.maintStatus
                                    .split(',')
                                    .map((e) => e.trim())
                                    .toList();

                                final coordinateIds = polyline.coordinateIds
                                    .split(',')
                                    .map((e) => e.trim())
                                    .toList();

                                for (int i = 0; i < maintTypes.length; i++) {
                                  final maintType = maintTypes[i];

                                  final maintStatus = i < maintStatuses.length
                                      ? maintStatuses[i]
                                      : "";

                                  // Skip completed maintenance types
                                  if (maintStatus.toLowerCase() ==
                                      "completed") {
                                    continue;
                                  }

                                  final parentFeatureId =
                                      i < coordinateIds.length
                                      ? coordinateIds[i]
                                      : "";

                                  final exists = lines.any(
                                    (e) =>
                                        e["parentFeatureId"] ==
                                            parentFeatureId &&
                                        e["maintTypes"] == maintType,
                                  );

                                  if (!exists) {
                                    lines.add({
                                      "mapId": polyline.oid.toString(),
                                      "crewId": id.toString(),
                                      "parentFeatureId": parentFeatureId,
                                      "maintTypes": maintType,
                                      "tokenNo": widget.jobNo,
                                    });
                                  }
                                }
                              } else {
                                // Remove only current span objects
                                lines.removeWhere(
                                  (e) => e["mapId"] == polyline.oid.toString(),
                                );
                              }

                              print(lines);
                            });
                          },
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "Mark as Completed",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Container(
            width: 20,
            height: 20,
            transform: Matrix4.rotationZ(0.785398),
            decoration: const BoxDecoration(color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _updatePopupPosition() {
    if (selectedPopupLatLng == null) return;

    setState(() {
      popupOffset = _mapController.camera.latLngToScreenOffset(
        selectedPopupLatLng!,
      );
    });
  }

  double calculatePolylineLengthMiles(List<LatLng> points) {
    const Distance distance = Distance();

    double totalMeters = 0;

    for (int i = 0; i < points.length - 1; i++) {
      totalMeters += distance(points[i], points[i + 1]);
    }

    return totalMeters * 0.000621371; // meters → miles
  }

  String popUp = "";
  void deleteSelectedPolyline() {
    if (selectedPolylineIndex == null) return;

    final index = selectedPolylineIndex!;

    if (!selectedPolylineIndexes.contains(index)) return;

    setState(() {
      selectedPolylineIndexes.remove(index);

      totalSelectedDistanceMiles -= overHeadPolylines[index].distanceMiles;

      if (totalSelectedDistanceMiles < 0) {
        totalSelectedDistanceMiles = 0;
      }

      showPopup = false;
      if (popUp == "max") {
        Navigator.pop(context);
        popUp == "";
      }

      selectedPolylineIndex = null;
    });

    print("Deleted:");
    print(overHeadPolylines[index].substation);
    print(overHeadPolylines[index].wkt);

    print(
      "Total Distance = ${totalSelectedDistanceMiles.toStringAsFixed(2)} miles",
    );
  }

  void _showDetailsPopup() async {
    final Map<String, Color> workTypeColors = {
      "JARRAFF": const Color.fromARGB(255, 96, 0, 113),
      "MOWING": const Color.fromARGB(255, 113, 68, 1),
      "MINI JARRAFF": const Color.fromARGB(255, 247, 19, 2),
      "BYL": const Color.fromARGB(255, 2, 212, 249),
      "BUCKET": Colors.orange,
      "GROUND": Colors.yellow,
      "CROSS-COUNTRY SPRAY": const Color.fromARGB(255, 38, 1, 247),
      "ROADSIDE SPRAY": const Color.fromARGB(255, 1, 127, 5),
      "NO SPRAY": const Color.fromARGB(255, 252, 199, 249),
    };

    // List<String> selectedWorkTypes = [];
    //-----
    //  List<String> selectedWorkTypes = await getWorkTypes();
    //   print("MaintType from DB: $selectedWorkTypes");
    List<String> selectedWorkTypes = [];

    final polyline = overHeadPolylines[selectedPolylineIndex!];

    if (polyline.maintType != null && polyline.maintType.trim().isNotEmpty) {
      selectedWorkTypes = polyline.maintType.split(",");
    } else {
      selectedWorkTypes = await getWorkTypes();
      // or selectedWorkTypes = [];
    }

    print("MaintType: $selectedWorkTypes");
    final mapObjectIndex = selectedMapObjects.indexWhere(
      (e) => e["oId"] == polyline.oid,
    );

    commentsController.text = mapObjectIndex != -1
        ? (selectedMapObjects[mapObjectIndex]["comments"] ?? "")
        : "";
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: 450,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),

                          // Delete Icon
                          InkWell(
                            onTap: () {
                              setState(() {
                                popUp = "max";
                              });
                              deleteSelectedPolyline();
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 4,
                          ), // <-- Change this value to adjust spacing
                          // Details Icon
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.fullscreen_exit,
                                color: Colors.blue,
                                size: 22,
                              ),
                            ),
                          ),

                          const SizedBox(width: 4), // <-- Change this value
                          // Close Icon
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.cancel_presentation_sharp,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),

                      //  const Divider(),
                      _detailRow(
                        "Distance",
                        "${totalSelectedDistanceMiles.toStringAsFixed(2)} miles",
                      ),
                      _detailRow("Span Name", selectedSpanName),
                      _detailRow("Work Type", selectedWorkTypes.join(", ")),
                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: workTypeColors.entries.map((entry) {
                            final isSelected = selectedWorkTypes.contains(
                              entry.key,
                            );

                            return GestureDetector(
                              onTap: () async {
                                if (isSelected) {
                                  selectedWorkTypes.remove(entry.key);
                                } else {
                                  selectedWorkTypes.add(entry.key);
                                }

                                await saveWorkTypes(selectedWorkTypes);
                                ////////////
                                final polyline =
                                    overHeadPolylines[selectedPolylineIndex!];

                                // final index = selectedMapObjects.indexWhere(
                                //   (e) => e["oId"] == polyline.oid,
                                // );

                                // if (index != -1) {
                                //   selectedMapObjects[index]["maintType"] =
                                //       selectedWorkTypes.join(",");
                                // }
                                if (mapObjectIndex != -1) {
                                  selectedMapObjects[mapObjectIndex]["maintType"] =
                                      selectedWorkTypes.join(",");
                                } else {
                                  selectedMapObjects.add({
                                    "createdById": id,
                                    "contractorId": selectedForemanId,
                                    "substationId": selectedSubstationId,
                                    "feederName": polyline.feederName,
                                    "totalMiles": totalSelectedDistanceMiles
                                        .toStringAsFixed(2),
                                    "maintType": selectedWorkTypes.join(","),
                                    "wkt": polyline.wkt,
                                    "elementName": polyline.elementName,
                                    "opacity": "0.7",
                                    "spanDistance": currentSelectedDistanceMiles
                                        .toStringAsFixed(2),
                                    "oId": polyline.oid,
                                    "jobNo": polyline.jobNo,
                                    "comments": commentsController.text,
                                  });
                                }
                                print(
                                  "222222 ${jsonEncode(selectedMapObjects)}",
                                );
                                ///////////
                                setDialogState(() {});
                              },
                              // onTap: () {

                              //   // setDialogState(() {
                              //   //   if (isSelected) {
                              //   //     selectedWorkTypes.remove(entry.key);
                              //   //   } else {
                              //   //     selectedWorkTypes.add(entry.key);
                              //   //   }
                              //   // });
                              // },
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: entry.value,
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.grey,
                                    width: isSelected ? 3 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      // _detailRow(
                      //   "WKT",
                      //   selectedWkt,
                      // ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: commentsController,
                        maxLines: null,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          if (mapObjectIndex != -1) {
                            selectedMapObjects[mapObjectIndex]["comments"] =
                                value;
                          }

                          print(jsonEncode(selectedMapObjects));
                        },
                        decoration: InputDecoration(
                          labelText: "Comments",
                          hintText: "Write Your comments Here",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 10),

                      _buildDropdownField(
                        hint: "Plan Type",
                        value: selectedPlanType,
                        items: planTypeList,
                        onChanged: (value) {
                          setDialogState(() {
                            selectedPlanType = value;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      _buildDropdownField(
                        hint: "Type",
                        value: selectedType2,
                        items: typeList2,
                        onChanged: (value) {
                          setDialogState(() {
                            selectedType2 = value;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      _buildDropdownField(
                        hint: "Contractor Company",
                        value: selectedContractor,
                        items: contractorList,
                        onChanged: (value) {
                          setDialogState(() {
                            selectedContractor = value;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      // _buildDropdownField(
                      //   hint: "Assign Foreman",
                      //   value: selectedForeman,
                      //   items: foremanList,
                      //   onChanged: (value) {
                      //     setDialogState(() {
                      //       selectedForeman = value;
                      //     });
                      //   },
                      // ),
                      DropdownButtonFormField<int>(
                        initialValue: selectedForemanId,
                        decoration: InputDecoration(
                          labelText: "Assign Foreman",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                        items: foremanList.map((item) {
                          return DropdownMenuItem<int>(
                            value: item["contractorId"],
                            child: Text("${item["fName"]}"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setDialogState(() {
                            selectedForemanId = value;

                            final selectedItem = foremanList.firstWhere(
                              (e) => e["contractorId"] == value,
                            );

                            selectedForeman = "${selectedItem["fName"]}}";
                            // Update all selected map objects
                            for (var item in selectedMapObjects) {
                              item["contractorId"] = selectedForemanId;
                            }

                            print("selectedForemanId: $selectedForemanId");
                            print(jsonEncode(selectedMapObjects));
                          });
                        },
                      ),
                      const SizedBox(height: 10),

                      const SizedBox(height: 20),

                      SizedBox(
                        //width: double.infinity,
                        child: InkWell(
                          onTap: () async {
                            await submitMapData(selectedMapObjects);
                            // Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 45,
                            width: 90,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDetailsPopupUpdate(int index) async {
    chatController.clear();
    final screenHeight = MediaQuery.of(context).size.height;
    final maxChatHeight = screenHeight * 0.30;
    final connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      await DatabaseHelper.instance.fetchAndSaveMessages(
        overHeadPolylines[index].oid.toString(),
      );
    }
    final Map<String, Color> workTypeColors = {
      "JARRAFF": const Color.fromARGB(255, 96, 0, 113),
      "MOWING": const Color.fromARGB(255, 113, 68, 1),
      "MINI JARRAFF": const Color.fromARGB(255, 247, 19, 2),
      "BYL": const Color.fromARGB(255, 2, 212, 249),
      "BUCKET": Colors.orange,
      "GROUND": Colors.yellow,
      "CROSS-COUNTRY SPRAY": const Color.fromARGB(255, 38, 1, 247),
      "ROADSIDE SPRAY": const Color.fromARGB(255, 1, 127, 5),
      "NO SPRAY": const Color.fromARGB(255, 252, 199, 249),
    };

    // List<String> selectedWorkTypes = [];
    selectedWorkTypesUpdate = overHeadPolylines[index].maintType.split(",");
    final polyline = overHeadPolylines[index];

    // If global Mark As Read is already checked,
    // automatically add this span's maintTypes.
    if (isMarkAsRead) {
      final maintTypes = polyline.maintType
          .split(',')
          .map((e) => e.trim())
          .toList();

      final maintStatuses = polyline.maintStatus
          .split(',')
          .map((e) => e.trim())
          .toList();

      final coordinateIds = polyline.coordinateIds
          .split(',')
          .map((e) => e.trim())
          .toList();

      for (int i = 0; i < maintTypes.length; i++) {
        final maintType = maintTypes[i];

        final maintStatus = i < maintStatuses.length ? maintStatuses[i] : "";

        // Skip completed maintenance types
        if (maintStatus.toLowerCase() == "completed") {
          continue;
        }

        final parentFeatureId = i < coordinateIds.length
            ? coordinateIds[i]
            : "";

        final exists = lines.any(
          (e) =>
              e["parentFeatureId"] == parentFeatureId &&
              e["maintTypes"] == maintType,
        );

        if (!exists) {
          lines.add({
            "mapId": polyline.oid.toString(),
            "crewId": id.toString(),
            "parentFeatureId": parentFeatureId,
            "maintTypes": maintType,
            "tokenNo": widget.jobNo,
          });
        }
      }
      print("lines######Big $lines");
    }
    //
    bool isEditMode = false;
    messagesData = await DatabaseHelper.instance.getMessages(
      overHeadPolylines[index].oid.toString(),
    );
    await imageViewModel.fetchImageApi(context, widget.jobNo);
    imagePaths.clear();
    showUpdateCardView = true;
    if (selectedWorkTypesUpdate.isNotEmpty) {
      selectedMaintType = selectedWorkTypesUpdate.first;

      final maintTypes = overHeadPolylines[index].maintType.split(',');

      final maintStatuses = overHeadPolylines[index].maintStatus.split(',');

      final statusIndex = maintTypes.indexWhere(
        (e) => e.trim().toUpperCase() == selectedMaintType.toUpperCase(),
      );

      if (statusIndex != -1 && statusIndex < maintStatuses.length) {
        selectedMaintStatus = maintStatuses[statusIndex].trim();
        print(' selectedMaintStatus $selectedMaintStatus');
      }
    }
    bool isSendButton = false;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            dialogSetState = setDialogState;
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                // width: 450,
                padding: const EdgeInsets.only(
                  // left: 10,
                  right: 10,
                  bottom: 10,
                  top: 4,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (selectedMaintStatus.trim().toLowerCase() ==
                                      "rework" ||
                                  selectedMaintStatus.trim().toLowerCase() ==
                                      "pending")
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                      value: isMarkAsRead,
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        setDialogState(() {
                                          isMarkAsRead = value ?? false;

                                          final polyline =
                                              overHeadPolylines[index];

                                          if (isMarkAsRead) {
                                            final maintTypes = polyline
                                                .maintType
                                                .split(',')
                                                .map((e) => e.trim())
                                                .toList();

                                            final maintStatuses = polyline
                                                .maintStatus
                                                .split(',')
                                                .map((e) => e.trim())
                                                .toList();

                                            final coordinateIds = polyline
                                                .coordinateIds
                                                .split(',')
                                                .map((e) => e.trim())
                                                .toList();

                                            for (
                                              int i = 0;
                                              i < maintTypes.length;
                                              i++
                                            ) {
                                              final maintType = maintTypes[i];

                                              final maintStatus =
                                                  i < maintStatuses.length
                                                  ? maintStatuses[i]
                                                  : "";

                                              // Skip completed maintenance types
                                              if (maintStatus.toLowerCase() ==
                                                  "completed") {
                                                continue;
                                              }

                                              final parentFeatureId =
                                                  i < coordinateIds.length
                                                  ? coordinateIds[i]
                                                  : "";

                                              final exists = lines.any(
                                                (e) =>
                                                    e["parentFeatureId"] ==
                                                        parentFeatureId &&
                                                    e["maintTypes"] ==
                                                        maintType,
                                              );

                                              if (!exists) {
                                                lines.add({
                                                  "mapId": polyline.oid
                                                      .toString(),
                                                  "crewId": id.toString(),
                                                  "parentFeatureId":
                                                      parentFeatureId,
                                                  "maintTypes": maintType,
                                                  "tokenNo": widget.jobNo,
                                                });
                                              }
                                            }
                                          } else {
                                            lines.removeWhere(
                                              (e) =>
                                                  e["mapId"] ==
                                                  polyline.oid.toString(),
                                            );
                                          }
                                        });
                                      },
                                    ),
                                    //  const SizedBox(width: 4),
                                    const Text(
                                      "Mark as Completed",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () async {
                                        _showSubmitProgressDialog();
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        height: 30,
                                        width: 64,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Text(
                                          "Submit",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),

                          SizedBox(
                            width: 60,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showPopup = true;
                                    Navigator.pop(context);
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.fullscreen_exit,
                                      color: Colors.blue,
                                      size: 22,
                                    ),
                                  ),
                                ),

                                // Close Button
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.cancel_presentation_sharp,
                                      color: Colors.red,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Select Vegetation Type",
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            if (!isEditMode)
                              Row(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children:
                                          (workTypeColors.entries.where(
                                                (entry) =>
                                                    selectedWorkTypesUpdate
                                                        .contains(entry.key),
                                              ) // Show only selected colors
                                              )
                                              .map((entry) {
                                                final isSelected =
                                                    selectedMaintType ==
                                                    entry.key;

                                                return InkWell(
                                                  onTap: () {
                                                    setDialogState(() {
                                                      selectedMaintType =
                                                          entry.key;

                                                      final maintTypes =
                                                          overHeadPolylines[index]
                                                              .maintType
                                                              .split(',');

                                                      final maintStatuses =
                                                          overHeadPolylines[index]
                                                              .maintStatus
                                                              .split(',');

                                                      final selectedIndex =
                                                          maintTypes.indexWhere(
                                                            (e) =>
                                                                e
                                                                    .trim()
                                                                    .toUpperCase() ==
                                                                entry.key
                                                                    .toUpperCase(),
                                                          );

                                                      if (selectedIndex != -1 &&
                                                          selectedIndex <
                                                              maintStatuses
                                                                  .length) {
                                                        selectedMaintStatus =
                                                            maintStatuses[selectedIndex]
                                                                .trim();
                                                        // // If the selected value is empty, use "Pending"
                                                        // if (selectedMaintStatus
                                                        //     .isEmpty) {
                                                        //   selectedMaintStatus =
                                                        //       "Pending";
                                                        // }
                                                      } else {
                                                        selectedMaintStatus =
                                                            "";
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 28,
                                                    height: 28,
                                                    decoration: BoxDecoration(
                                                      color: entry.value,
                                                      border: Border.all(
                                                        color: isSelected
                                                            ? Colors.black
                                                            : Colors.grey,
                                                        width: isSelected
                                                            ? 3
                                                            : 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            4,
                                                          ),
                                                    ),
                                                    child: isSelected
                                                        ? const Icon(
                                                            Icons.check,
                                                            color: Colors.white,
                                                            size: 18,
                                                          )
                                                        : null,
                                                  ),
                                                );
                                              })
                                              .toList(),
                                    ),
                                  ),
                                ],
                              ),

                            SizedBox(height: 10),

                            if (showUpdateCardView)
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final bool isTablet =
                                      constraints.maxWidth >= 600;

                                  final details = [
                                    _detailRow(
                                      "Maint Type",
                                      selectedMaintType,
                                      //selectedWorkTypesUpdate.join(", "),
                                    ),
                                    _detailRow(
                                      "Job No",
                                      overHeadPolylines[index].jobNo,
                                    ),
                                    _detailRow(
                                      "Distance",
                                      "${overHeadPolylines[index].spanDistanceApi} miles",
                                    ),
                                    _detailRow(
                                      "Total Distance",
                                      "${overHeadPolylines[index].totalMilesApi} miles",
                                    ),
                                    _detailRow(
                                      "Create Date",
                                      formatDate(
                                        overHeadPolylines[index].createDate,
                                      ),
                                    ),
                                    _detailRow(
                                      "Span Name",
                                      overHeadPolylines[index].elementName,
                                    ),
                                    _detailRow("Status", selectedMaintStatus),
                                  ];

                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      border: const Border(
                                        left: BorderSide(
                                          color: Color.fromARGB(
                                            255,
                                            7,
                                            59,
                                            120,
                                          ),
                                          width: 5,
                                        ),
                                      ),
                                    ),
                                    child: isTablet
                                        ? Column(
                                            children: [
                                              for (
                                                int i = 0;
                                                i < details.length;
                                                i += 2
                                              )
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(child: details[i]),
                                                    const SizedBox(width: 8),
                                                    if (i + 1 < details.length)
                                                      Expanded(
                                                        child: details[i + 1],
                                                      )
                                                    else
                                                      const Expanded(
                                                        child: SizedBox(),
                                                      ),
                                                  ],
                                                ),
                                            ],
                                          )
                                        : Column(
                                            children: details
                                                .map(
                                                  (detail) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          bottom: 4,
                                                        ),
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: detail,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                  );
                                },
                              ),
                            if (selectedMaintStatus.trim().toLowerCase() ==
                                "completed")
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.green.shade300,
                                  ),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "This segment is already completed.",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 8,
                                bottom: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      // maxHeight: 230, // maximum chat height
                                      maxHeight: maxChatHeight,
                                    ),
                                    child: Scrollbar(
                                      controller: chatScrollController,
                                      thumbVisibility: true,
                                      // trackVisibility:
                                      //     true, // Optional: shows the scrollbar track
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8,
                                        ),
                                        child: ListView.builder(
                                          controller: chatScrollController,
                                          shrinkWrap: true,
                                          reverse: true,
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          itemCount: messagesData.length,
                                          itemBuilder: (context, index) {
                                            final message = messagesData[index];

                                            final bool isCrew =
                                                message["userName"]
                                                    .toString()
                                                    .toLowerCase() ==
                                                userName.toLowerCase();

                                            return _chatBubble(
                                              isPlanner: isCrew,
                                              userName:
                                                  message["userName"] ?? "",
                                              date: formatChatDate(
                                                message["createdDate"] ?? "",
                                              ),
                                              message:
                                                  message["description"] ?? "",
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: chatController,
                                            maxLines: null,
                                            textInputAction:
                                                TextInputAction.done,
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Write Your Comments here...",

                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                          ),
                                          child: SizedBox(
                                            height: 42,
                                            child: ElevatedButton(
                                              onPressed: isSendButton
                                                  ? null
                                                  : () async {
                                                      setDialogState(() {
                                                        isSendButton = true;
                                                      });

                                                      try {
                                                        if (chatController.text
                                                            .trim()
                                                            .isEmpty) {
                                                          return;
                                                        }

                                                        final data = {
                                                          "lineId":
                                                              overHeadPolylines[index]
                                                                  .oid,
                                                          "description":
                                                              chatController
                                                                  .text
                                                                  .trim(),
                                                          "userId": id
                                                              .toString(),
                                                        };
                                                        // showLoader(context);
                                                        await updateMessageData(
                                                          data,
                                                          () {
                                                            setDialogState(
                                                              () {},
                                                            );
                                                          },
                                                        );
                                                      } finally {
                                                        if (mounted) {
                                                          setDialogState(() {
                                                            isSendButton =
                                                                false;
                                                          });
                                                        }
                                                      }
                                                    },

                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.teal,
                                                foregroundColor: Colors.white,
                                                disabledBackgroundColor:
                                                    Colors.teal,
                                                disabledForegroundColor:
                                                    Colors.white,
                                              ),
                                              child: isSendButton
                                                  ? progressBar()
                                                  : const Text("Send"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            final bool isTablet =
                                                constraints.maxWidth >= 600;

                                            final chooseFilesButton = InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              onTap: () {
                                                _takePictureDialog();
                                              },
                                              child: Container(
                                                height: 55,
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.grey.shade400,
                                                    width: 1.2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Text(
                                                        "Capture Photo",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),

                                                    if (imagePaths.isNotEmpty)
                                                      Container(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 4,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: Colors
                                                              .green
                                                              .shade100,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                        child: Text(
                                                          "${imagePaths.length}",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .green
                                                                .shade800,
                                                          ),
                                                        ),
                                                      ),

                                                    const SizedBox(width: 8),

                                                    Icon(
                                                      Icons.chevron_right,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );

                                            final uploadButton = SizedBox(
                                              height: 42,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  setDialogState(() {
                                                    isUploadLoading = true;
                                                  });

                                                  try {
                                                    await submitImage(
                                                      imagePaths,
                                                      widget.jobNo,
                                                    );

                                                    setDialogState(() {
                                                      // imagePaths.clear();
                                                      isUploadLoading = false;
                                                    });
                                                  } catch (e) {
                                                    setDialogState(() {
                                                      isUploadLoading = false;
                                                    });

                                                    if (context.mounted) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            "Upload failed: $e",
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.teal,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                ),
                                                child: isUploadLoading
                                                    ? progressBar()
                                                    : const Text("Upload"),
                                              ),
                                            );

                                            if (isTablet) {
                                              // TABLET — same layout as your earlier design
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    flex: 5,
                                                    child: chooseFilesButton,
                                                  ),

                                                  const SizedBox(width: 10),

                                                  Expanded(
                                                    flex: 1,
                                                    child: uploadButton,
                                                  ),
                                                ],
                                              );
                                            }

                                            // MOBILE — stack the buttons
                                            return Column(
                                              children: [
                                                chooseFilesButton,
                                                const SizedBox(height: 10),
                                                uploadButton,
                                              ],
                                            );
                                          },
                                        ),
                                      ),

                                      const SizedBox(height: 15),

                                      /// Selected Images Count
                                      if (imagePaths.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          child: Text(
                                            "${imagePaths.length} file(s) selected",
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                      const SizedBox(height: 10),

                                      /// Image Preview
                                      if (imagePaths.isNotEmpty)
                                        SizedBox(
                                          height: 125,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                            ),
                                            itemCount: imagePaths.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                width: 110,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                    ),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey
                                                                .shade300,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                        ),
                                                        child: Image.file(
                                                          File(
                                                            imagePaths[index],
                                                          ),
                                                          width: 110,
                                                          height: 110,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),

                                                    Positioned(
                                                      top: 6,
                                                      right: 6,
                                                      child: InkWell(
                                                        onTap: () {
                                                          dialogSetState?.call(
                                                            () {
                                                              imagePaths
                                                                  .removeAt(
                                                                    index,
                                                                  );
                                                              images.removeAt(
                                                                index,
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                4,
                                                              ),
                                                          decoration:
                                                              const BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                          child: const Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                            size: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),

                                      const SizedBox(height: 0),

                                      ///  IMAGE GRID VIEW
                                      _buildImageGrid(),

                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                  SizedBox(height: 0),

                                  Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () async {
                                        showCreateChangeOrderDialog(index);
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        height: 40,
                                        width: 180,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                            255,
                                            34,
                                            113,
                                            249,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Text(
                                          "Create Change Order",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const Text(":", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3),
                SelectableText(value, style: TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }

  List<List<LatLng>> parseMultiPolygon(String wkt) {
    wkt = wkt.trim();

    wkt = wkt.replaceFirst("MULTIPOLYGON", "").trim();

    while (wkt.startsWith("(") && wkt.endsWith(")")) {
      wkt = wkt.substring(1, wkt.length - 1).trim();
    }

    List<List<LatLng>> polygons = [];

    // final polygonStrings = wkt.split(")),((");
    final polygonStrings = wkt.split(RegExp(r"\)\)\s*,\s*\(\("));
    for (var polygon in polygonStrings) {
      polygon = polygon.replaceAll("((", "");
      polygon = polygon.replaceAll("))", "");

      final points = polygon.split(",");

      List<LatLng> polygonPoints = [];

      for (var point in points) {
        // final coords = point.trim().split(RegExp(r"\s+"));

        // if (coords.length < 2) continue;

        // final lon = double.parse(coords[0]);
        // final lat = double.parse(coords[1]);

        // polygonPoints.add(LatLng(lat, lon));
        final cleanedPoint = point
            .replaceAll("(", "")
            .replaceAll(")", "")
            .trim();

        final coords = cleanedPoint.split(RegExp(r"\s+"));

        if (coords.length < 2) continue;

        final lon = double.tryParse(coords[0]);
        final lat = double.tryParse(coords[1]);

        if (lon != null && lat != null) {
          polygonPoints.add(LatLng(lat, lon));
        } else {
          debugPrint("Invalid coordinate: $cleanedPoint");
        }
      }

      polygons.add(polygonPoints);
    }

    return polygons;
  }

  void _showPolePopup(String elementName, String substation, String feeder) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      "Pole ID",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(":"),
                  const SizedBox(width: 10),
                  Expanded(child: SelectableText(elementName)),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.cancel_presentation_sharp,
                        color: Colors.red,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      "Substation",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(":"),
                  const SizedBox(width: 10),
                  Expanded(child: Text(substation)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      "Feeder",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(":"),
                  const SizedBox(width: 10),
                  Expanded(child: Text(feeder)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveWorkTypes(List<String> workTypes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("selectedWorkTypes", workTypes);
  }

  Future<List<String>> getWorkTypes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("selectedWorkTypes") ?? [];
  }

  Future<void> clearWorkTypes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("selectedWorkTypes");
  }

  Future<void> submitMapData(List<Map<String, dynamic>> mapData) async {
    print("APIcalled");
    final connectivity = await Connectivity().checkConnectivity();

    if (!connectivity.contains(ConnectivityResult.none)) {
      try {
        final response = await http.post(
          Uri.parse("${AppUrl.baseUrl}login_user/createMap"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode(mapData),
        );
        print('jsonEncode(mapData) ${jsonEncode(mapData)}');
        print("response code ${response.statusCode}");
        if (response.statusCode == 200) {
          print("response code ${response.statusCode}");
          final responseData = jsonDecode(response.body);
          print("response from submitMapData-------------");
          print("Decoded Response: $responseData");
          final db = await DatabaseHelper.instance.database;

          Batch batch = db.batch();

          for (var item in mapData) {
            batch.update(
              "overHeadTable",
              {
                "createdById": item["createdById"],
                "contractorId": item["contractorId"],
                "substationId": item["substationId"],
                "feederName": item["feederName"],
                "totalMiles": item["totalMiles"],
                "maintType": item["maintType"],
                "wkt": item["wkt"],
                "elementName": item["elementName"],
                "opacity": item["opacity"],
                "spanDistance": item["spanDistance"],
                "jobNo": item["jobNo"], // if you're using it
                "status": 1,
                "createDate": formatDateTime(DateTime.now()),
                // "status": 1,
                // "maintType": item["maintType"],
                // "jobNo": item["jobNo"],
              },
              where: "oId=?",
              whereArgs: [item["oId"]],
            );
          }

          await batch.commit(noResult: true);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Submitted Successfully")),
          );
          selectedMapObjects.clear();
          print("Submitted Successfully $selectedMapObjects");
          // overHeadData = await DatabaseHelper.instance.getOverHeadData(
          //     selectedSubstation.toString(), selectedFeeder.toString());
          // print("Overhead rows: ${overHeadData.length}");
          Navigator.pop(context);
          showPopup = false;
          loadApiData();
        }
      } catch (e) {
        setState(() {});
        await DatabaseHelper.instance.saveOfflineMapData(mapData);
        // overHeadData = await DatabaseHelper.instance.getOverHeadData(
        //   selectedSubstation.toString(),
        //   selectedFeeder.toString(),
        // );
        loadApiData();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Saved Offline")));
        selectedMapObjects.clear();
        print("Submitted Successfully $selectedMapObjects");
        Navigator.pop(context);
        showPopup = false;
        //  loadApiData();
      }
    } else {
      setState(() {});
      await DatabaseHelper.instance.saveOfflineMapData(mapData);

      // overHeadData = await DatabaseHelper.instance.getOverHeadData(
      //   selectedSubstation.toString(),
      //   selectedFeeder.toString(),
      // );
      loadApiData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No Internet. Saved Offline")),
      );
      selectedMapObjects.clear();
      print("Submitted Successfully $selectedMapObjects");
      Navigator.pop(context);
      showPopup = false;
      // loadApiData();
    }
  }

  Future<void> updateMessageData(
    Map<String, dynamic> mapData,
    VoidCallback refreshDialog,
  ) async {
    final connectivity = await Connectivity().checkConnectivity();

    // if (connectivity.contains(ConnectivityResult.none)) {
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(const SnackBar(content: Text("No Internet Connection")));
    //   return;
    // }
    Map<String, dynamic> saveData = {
      "lineId": mapData["lineId"],
      "description": mapData["description"],
      "userId": id.toString(),
      "userName": userName, // or logged in username
      "createdDate": DateTime.now().toUtc().toIso8601String().replaceFirst(
        'Z',
        '+00:00',
      ),
      "status": 0,
    };
    if (!connectivity.contains(ConnectivityResult.none)) {
      try {
        final response = await http.post(
          Uri.parse(
            "${AppUrl.baseUrl}login_user/addChat",
          ), // <-- Replace with your API
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode(mapData),
        );

        print("Request: ${jsonEncode(mapData)}");
        print("Status Code: ${response.statusCode}");
        print("Response: ${response.body}");

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);

          print("Decoded Response: $responseData");

          final db = await DatabaseHelper.instance.database;

          await db.insert("messageTable", {
            "lineId": mapData["lineId"],
            "description": mapData["description"],
            "userId": id.toString(),
            "userName": userName, // or logged in username
            "createdDate": DateTime.now()
                .toUtc()
                .toIso8601String()
                .replaceFirst('Z', '+00:00'),
            "status": 1,
          }, conflictAlgorithm: ConflictAlgorithm.replace);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Message sent successfully")),
          );

          chatController.clear();

          // Navigator.pop(context);
          messagesData = await DatabaseHelper.instance.getMessages(
            mapData["lineId"].toString(),
          );
          refreshDialog(); // <-- rebuild dialog
          if (mounted) {
            setState(() {});
          }
        }
      } catch (e) {
        print(e);
        await DatabaseHelper.instance.saveOfflineMessage(saveData);
        messagesData = await DatabaseHelper.instance.getMessages(
          mapData["lineId"].toString(),
        );

        // Navigator.pop(context);
        refreshDialog(); // <-- rebuild dialog
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Saved Offline")));

        chatController.clear();
      }
    } else {
      await DatabaseHelper.instance.saveOfflineMessage(saveData);

      messagesData = await DatabaseHelper.instance.getMessages(
        mapData["lineId"].toString(),
      );

      // Navigator.pop(context);
      refreshDialog(); // <-- rebuild dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No Internet. Saved Offline")),
      );
      chatController.clear();
    }
  }

  void _showConnectivitySnackBar(bool online) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor: online ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            Icon(online ? Icons.wifi : Icons.wifi_off, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              online ? "Device is Online" : "Device is Offline",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatBubble({
    required bool isPlanner,
    required String userName,
    required String date,
    required String message,
  }) {
    return Align(
      alignment: isPlanner ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: isPlanner
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!isPlanner) ...[
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
            ],

            Flexible(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                decoration: BoxDecoration(
                  color: isPlanner
                      ? const Color(0xffCDEBFF)
                      : const Color.fromRGBO(241, 227, 207, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: Radius.circular(isPlanner ? 12 : 0),
                    bottomRight: Radius.circular(isPlanner ? 0 : 12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .08),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isPlanner
                            ? Colors.blue
                            : const Color.fromRGBO(241, 129, 64, 1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              userName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Message
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        message,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (isPlanner) ...[
              const SizedBox(width: 8),
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
            ],
          ],
        ),
      ),
    );
  }

  LatLng getPolylineCenter(List<LatLng> points) {
    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (final p in points) {
      minLat = min(minLat, p.latitude);
      maxLat = max(maxLat, p.latitude);
      minLng = min(minLng, p.longitude);
      maxLng = max(maxLng, p.longitude);
    }

    return LatLng((minLat + maxLat) / 2, (minLng + maxLng) / 2);
  }

  Color getColorFromName(String color, {Color? noSprayColor}) {
    switch (color.toUpperCase().trim()) {
      case "JARRAFF":
        return Colors.purple;
      // return const Color.fromARGB(255, 96, 0, 113);
      case "MINI JARRAFF":
        return const Color.fromARGB(255, 247, 19, 2);
      case "NO SPRAY":
        ///////no spray label fix
        if (noSprayColor != null) {
          return lightenColor(noSprayColor);
        }

        return const Color.fromARGB(255, 252, 199, 249);
      case "MOWING":
        return const Color.fromARGB(255, 113, 68, 1);
      case "BUCKET":
        return Colors.orange;
      case "GROUND":
        return Colors.yellow;
      case "CROSS-COUNTRY SPRAY":
        return const Color.fromARGB(255, 38, 1, 247);
      case "ROADSIDE SPRAY":
        return const Color.fromARGB(255, 1, 127, 5);
      case "BYL":
        return const Color.fromARGB(255, 2, 212, 249);

      default:
        return polylineColor;
    }
  }

  String getStatusImage(
    String status,
    String completionFlag,
    String rework,
    String maintType,
  ) {
    status = status.trim().toLowerCase();
    completionFlag = completionFlag.trim();
    rework = rework.trim().toLowerCase();

    // Final Completed
    if (status == "final completed" && completionFlag == "2") {
      return "assets/complete_stamp22_n.png";
    }

    // Approved
    if (status == "approved" && completionFlag == "2") {
      return "assets/approved_status_n.png";
    }

    // Rework / Failed / Rejected
    if ((status == "rework" || status == "failed" || status == "rejected") &&
        completionFlag == "3") {
      return "assets/reject2_n.png";
    }

    // // Pending LCP Inspection
    // if (status == "pending lcp inspection") {
    //   return "assets/pending_approval_n.png";
    // }

    // Passed
    if (status == "passed" && completionFlag == "4") {
      return "assets/passed_n.png";
    }

    // // Rework Completed
    if (status == "rework completed" && completionFlag == "1") {
      return "assets/rework_n.png";
    }

    // Default completed icon
    return "";
  }

  List<LatLng> splitLineIntoSegments(LatLng start, LatLng end, int segments) {
    final List<LatLng> points = [];

    for (int i = 0; i <= segments; i++) {
      final t = i / segments;

      points.add(
        LatLng(
          start.latitude + (end.latitude - start.latitude) * t,
          start.longitude + (end.longitude - start.longitude) * t,
        ),
      );
    }

    return points;
  }

  Widget _layerTile(String title, bool value, ValueChanged<bool?> onChanged) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Row(
          children: [
            Checkbox(
              value: value,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: onChanged,
              activeColor: const Color.fromARGB(255, 7, 59, 120),
            ),
            const SizedBox(width: 2),
            Text(title.toUpperCase()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            "$title :",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueGrey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF073B78).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 16, color: const Color(0xFF073B78)),
          ),
          const SizedBox(width: 8),

          Text(
            "$title : ",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),

          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF073B78),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSubmitProgressDialog() {
    // Copy available maintenance objects
    //availableLines = lines.map((e) => Map<String, dynamic>.from(e)).toList();
    //removed NO SPRAY objects from  availableLines
    availableLines = lines
        .where(
          (e) => e["maintTypes"].toString().trim().toUpperCase() != "NO SPRAY",
        )
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    // Selected list starts empty
    // lines.clear();

    final List<Map<String, dynamic>> allLines = availableLines;
    // Remove duplicate maintTypes for UI only
    final addedTypes = <String>{};

    final spanItems = allLines.where((item) {
      return addedTypes.add(item["maintTypes"].toString());
    }).toList();
    // Clear current selection
    lines.clear();
    // Initially everything is unchecked
    List<String> tempSelectedTypes = [];
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Header
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF3FF),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF073B78).withOpacity(0.2),
                            ),
                          ),
                          child: const Icon(
                            Icons.assignment_turned_in,
                            color: Color(0xFF073B78),
                            size: 24,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          "Submit Progress",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF073B78),
                          ),
                        ),

                        const SizedBox(height: 6),
                      ],
                    ),
                    const SizedBox(height: 18),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Which maintenance progress would you like to submit? (Select one or more)",
                        style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: spanItems.map((item) {
                        final String type = item["maintTypes"];
                        final bool isSelected = tempSelectedTypes.contains(
                          type,
                        );

                        return InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            setDialogState(() {
                              if (tempSelectedTypes.contains(type)) {
                                // Uncheck
                                tempSelectedTypes.remove(type);

                                // Remove all selected objects having this maintType
                                lines.removeWhere(
                                  (e) => e["maintTypes"] == type,
                                );
                              } else {
                                // Check
                                tempSelectedTypes.add(type);

                                // Find every object having this maintType
                                final items = availableLines.where(
                                  (e) => e["maintTypes"] == type,
                                );

                                for (final item in items) {
                                  lines.add(Map<String, dynamic>.from(item));
                                }
                              }

                              print("Available : $availableLines");
                              print("Selected : $tempSelectedTypes");
                              print("Lines : $lines");
                            });
                          },

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  color: workTypeColors[type] ?? Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.grey.shade400,
                                    width: isSelected ? 3 : 1,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          const BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 6,
                                            offset: Offset(0, 2),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 22,
                                      )
                                    : null,
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: 72,
                                child: Text(
                                  type,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },
                            child: const Text("Cancel"),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF073B78),
                              minimumSize: const Size.fromHeight(45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (tempSelectedTypes.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please select at least one maintenance type.",
                                    ),
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                selectedWorkTypesUpdate = List<String>.from(
                                  tempSelectedTypes,
                                );
                              });

                              Navigator.pop(dialogContext);

                              // Call your API here
                              submitMarkAsRead(tempSelectedTypes);
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> submitMarkAsRead(List tempSelectedTypes) async {
    if (lines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please mark the span as read first.")),
      );
      return;
    }

    final connectivity = await Connectivity().checkConnectivity();

    if (!connectivity.contains(ConnectivityResult.none)) {
      try {
        final body = {"lines": lines};

        print("========== Mark As Read Request ==========");
        print(jsonEncode(body));

        final response = await http.post(
          Uri.parse("${AppUrl.baseUrl}login_user/updateCompletionFlag"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode(body),
        );

        print("Status Code : ${response.statusCode}");
        print("Response : ${response.body}");

        if (response.statusCode == 200) {
          // await DatabaseHelper.instance.updateMarkAsReadStatus(lines, 1);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Marked ${tempSelectedTypes.length} segment(s) as complete.",
              ),
            ),
          );

          lines.clear();
          Navigator.pop(context);
          await loadApiData();
        }
      } catch (e) {
        print(jsonEncode(lines));
        await DatabaseHelper.instance.saveOfflineMarkAsRead(lines);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Saved Offline")));

        lines.clear();
        Navigator.pop(context);
        await loadApiData();
      }
    } else {
      print(jsonEncode(lines));
      await DatabaseHelper.instance.saveOfflineMarkAsRead(lines);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No Internet. Saved Offline")),
      );

      lines.clear();
      Navigator.pop(context);
      await loadApiData();
    }
  }

  //////////////rework list////////////////
  Future<void> showReworkDialogBMS(BuildContext context) async {
    List<Map<String, dynamic>> reworkList = await loadReworkData();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.65,
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Rework List",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: reworkList.length,
                  itemBuilder: (context, index) {
                    final item = reworkList[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: getCardColor(item["status"] ?? ""),
                        borderRadius: BorderRadius.circular(14),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],

                        border: Border(
                          left: BorderSide(
                            color: getBorderColor(item["status"] ?? ""),
                            width: 5,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            /// Header
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context); // optional
                                      _moveToSpan(item); // ✅ Pass the whole map
                                    },
                                    child: Text(
                                      item["spanName"] ?? "",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                _buildStatusBadge(item["status"] ?? ""),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                buildField(
                                  Icons.groups,
                                  "Crew",
                                  item["username"] ?? "",
                                ),

                                const SizedBox(width: 8),

                                buildField(
                                  Icons.handyman,
                                  "Maint Type",
                                  item["maintType"] ?? "",
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                buildField(
                                  Icons.calendar_today,
                                  "Date",
                                  formatDate(item["contractorTime"] ?? ""),
                                ),

                                const SizedBox(width: 8),

                                buildField(
                                  Icons.location_on,
                                  "Span Name",
                                  item["spanName"] ?? "",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildField(IconData icon, String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: .8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: Colors.blue),

                const SizedBox(width: 4),

                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 3),

            Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Color getCardColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return Colors.green.shade50;

      case "rework":
        return Colors.orange.shade50;

      case "passed":
        return Colors.blue.shade50;

      case "failed":
        return Colors.red.shade50;

      default:
        return Colors.grey.shade50;
    }
  }

  Color getBorderColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return Colors.green;

      case "rework":
        return Colors.orange;

      case "passed":
        return Colors.blue;

      case "failed":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    IconData icon;

    switch (status.toLowerCase()) {
      case "completed":
        color = Colors.green;
        icon = Icons.check_circle;
        break;

      case "rework":
        color = Colors.orange;
        icon = Icons.refresh;
        break;

      case "failed":
        color = Colors.red;
        icon = Icons.cancel;
        break;

      case "passed":
        color = Colors.blue;
        icon = Icons.verified;
        break;

      default:
        color = Colors.grey;
        icon = Icons.info;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),

          const SizedBox(width: 4),

          Text(
            status,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _moveToSpan(Map<String, dynamic> item) {
    final wkt = item["geometry"] ?? "";

    final points = parseLineString(wkt);

    if (points.isEmpty) return;

    final center = _calculateCenter(points);

    _mapController.move(center, 17);
  }

  LatLng _calculateCenter(List<LatLng> points) {
    double lat = 0;
    double lng = 0;

    for (final p in points) {
      lat += p.latitude;
      lng += p.longitude;
    }

    return LatLng(lat / points.length, lng / points.length);
  }

  // List<LatLng> parseWKTLineString(String wkt) {
  //   if (wkt.isEmpty) return [];

  //   // Remove LINESTRING and parentheses
  //   final coordinates = wkt
  //       .replaceFirst("LINESTRING (", "")
  //       .replaceFirst("LINESTRING(", "")
  //       .replaceAll(")", "")
  //       .trim();

  //   return coordinates.split(",").map((point) {
  //     final values = point.trim().split(RegExp(r'\s+'));

  //     return LatLng(
  //       double.parse(values[1]), // Latitude
  //       double.parse(values[0]), // Longitude
  //     );
  //   }).toList();
  // }

  Future<List<Map<String, dynamic>>> loadReworkData() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      await DatabaseHelper.instance.fetchAndSaveReworkHistory(
        token,
        id,
        widget.jobNo,
      );

      print("Fetched from API and saved to SQLite");
    } else {
      print("Offline - Loading from SQLite");
    }

    return await DatabaseHelper.instance.getReworkHistoryData();
  }

  ///////////////////////////////////////////////////////
  void showCreateChangeOrderDialog(int index) {
    double estimatedHours = 0.1;
    final TextEditingController estimatedHoursController =
        TextEditingController(text: estimatedHours.toStringAsFixed(1));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            dialogSetStateCO = setDialogState;
            return AlertDialog(
              backgroundColor: const Color(0xFFF7F9FC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),

              contentPadding: EdgeInsets.zero,
              content: SingleChildScrollView(
                child: SizedBox(
                  width: 700,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.assignment_add,
                                color: Color(0xFF2271F9),
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                "Create Change Order",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 8,
                            bottom: 8,
                            right: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _commentsCOController,
                                maxLines: 3,
                                //  maxLines: null,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  hintText: "Write Your Comments here...",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "UPLOAD IMAGES",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),

                              const SizedBox(height: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Expanded(
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.symmetric(
                                  //           horizontal: 0,
                                  //         ),
                                  //         child: InkWell(
                                  //           borderRadius: BorderRadius.circular(
                                  //             12,
                                  //           ),
                                  //           onTap: () async {
                                  //             // await ensureCameraInitialized();
                                  //             _takePictureDialogCO();
                                  //           },
                                  //           child: Container(
                                  //             //   width: 200,
                                  //             // width: double.infinity,
                                  //             padding:
                                  //                 const EdgeInsets.symmetric(
                                  //                   horizontal: 16,
                                  //                   vertical: 14,
                                  //                 ),
                                  //             decoration: BoxDecoration(
                                  //               color: Colors.white,
                                  //               border: Border.all(
                                  //                 color: Colors.grey.shade400,
                                  //                 width: 1.2,
                                  //               ),
                                  //               borderRadius:
                                  //                   BorderRadius.circular(12),
                                  //             ),
                                  //             child: Row(
                                  //               children: [
                                  //                 const Icon(
                                  //                   Icons.upload_file_outlined,
                                  //                   color: Color(0xFF073B78),
                                  //                   size: 26,
                                  //                 ),
                                  //                 const SizedBox(width: 12),
                                  //                 const Expanded(
                                  //                   child: Text(
                                  //                     "Choose Files",
                                  //                     style: TextStyle(
                                  //                       fontSize: 16,
                                  //                       fontWeight:
                                  //                           FontWeight.w600,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //                 if (imagePathsChangeOrder
                                  //                     .isNotEmpty)
                                  //                   Container(
                                  //                     padding:
                                  //                         const EdgeInsets.symmetric(
                                  //                           horizontal: 10,
                                  //                           vertical: 4,
                                  //                         ),
                                  //                     decoration: BoxDecoration(
                                  //                       color: Colors
                                  //                           .green
                                  //                           .shade100,
                                  //                       borderRadius:
                                  //                           BorderRadius.circular(
                                  //                             20,
                                  //                           ),
                                  //                     ),
                                  //                     child: Text(
                                  //                       "${imagePathsChangeOrder.length}",
                                  //                       style: TextStyle(
                                  //                         fontSize: 13,
                                  //                         fontWeight:
                                  //                             FontWeight.bold,
                                  //                         color: Colors
                                  //                             .green
                                  //                             .shade800,
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 const SizedBox(width: 8),
                                  //                 Icon(
                                  //                   Icons.chevron_right,
                                  //                   color: Colors.grey.shade600,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Padding(
                                  //       padding: const EdgeInsets.only(
                                  //         right: 8.0,
                                  //         left: 8,
                                  //       ),
                                  //       child: SizedBox(
                                  //         height: 42,
                                  //         // width: 80,
                                  //         child: ElevatedButton(
                                  //           onPressed: () async {
                                  //             await submitImage(
                                  //               imagePathsChangeOrder,
                                  //               widget.jobNo,
                                  //             );
                                  //             setState(() {
                                  //               isUploadLoading = true;
                                  //             });
                                  //           },
                                  //           style: ElevatedButton.styleFrom(
                                  //             backgroundColor: Colors.teal,
                                  //             foregroundColor: Colors.white,
                                  //             padding:
                                  //                 const EdgeInsets.symmetric(
                                  //                   horizontal: 8,
                                  //                   vertical: 6,
                                  //                 ), // Reduce padding
                                  //             // shape: RoundedRectangleBorder(
                                  //             //   borderRadius: BorderRadius.circular(
                                  //             //     4,
                                  //             //   ),
                                  //             // ),
                                  //           ),
                                  //           child: isUploadLoading
                                  //               ? progressBar()
                                  //               : Text("Upload"),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      final bool isTablet =
                                          constraints.maxWidth >= 600;

                                      final chooseFilesButton = InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () {
                                          _takePictureDialogCO();
                                        },
                                        child: Container(
                                          height: 55,
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 1.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                child: Text(
                                                  "Capture Photo",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),

                                              if (imagePathsChangeOrder
                                                  .isNotEmpty)
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.green.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    "${imagePathsChangeOrder.length}",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.green.shade800,
                                                    ),
                                                  ),
                                                ),

                                              const SizedBox(width: 8),

                                              Icon(
                                                Icons.chevron_right,
                                                color: Colors.grey.shade600,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );

                                      if (isTablet) {
                                        // TABLET — same layout as your earlier design
                                        return chooseFilesButton;
                                      }

                                      // MOBILE — stack the buttons
                                      return Column(
                                        children: [chooseFilesButton],
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 15),

                                  /// Selected Images Count
                                  if (imagePathsChangeOrder.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Text(
                                        "${imagePathsChangeOrder.length} file(s) selected",
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                  const SizedBox(height: 10),

                                  /// Image Preview
                                  if (imagePathsChangeOrder.isNotEmpty)
                                    SizedBox(
                                      height: 125,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        itemCount: imagePathsChangeOrder.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: 110,
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                            ),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors
                                                            .grey
                                                            .shade300,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    child: Image.file(
                                                      File(
                                                        imagePathsChangeOrder[index],
                                                      ),
                                                      width: 110,
                                                      height: 110,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),

                                                Positioned(
                                                  top: 6,
                                                  right: 6,
                                                  child: InkWell(
                                                    onTap: () {
                                                      dialogSetStateCO?.call(
                                                        () {
                                                          imagePathsChangeOrder
                                                              .removeAt(index);
                                                          images.removeAt(
                                                            index,
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            4,
                                                          ),
                                                      decoration:
                                                          const BoxDecoration(
                                                            color: Colors.red,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          const Text(
                                            "ESTIMATED TIME (HOURS)",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey.shade400,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: TextFormField(
                                              controller:
                                                  estimatedHoursController,
                                              keyboardType:
                                                  const TextInputType.numberWithOptions(
                                                    decimal: true,
                                                  ),
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,

                                                // contentPadding:
                                                //     const EdgeInsets.symmetric(
                                                //       vertical: 10,
                                                //     ),
                                                suffixIcon: SizedBox(
                                                  width: 30,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            setDialogState(() {
                                                              estimatedHours +=
                                                                  0.1;
                                                              estimatedHoursController
                                                                      .text =
                                                                  estimatedHours
                                                                      .toStringAsFixed(
                                                                        1,
                                                                      );
                                                            });
                                                          },
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons
                                                                  .keyboard_arrow_up,
                                                              size: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 1,
                                                        color: Colors
                                                            .grey
                                                            .shade300,
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            setDialogState(() {
                                                              if (estimatedHours >
                                                                  0.1) {
                                                                estimatedHours -=
                                                                    0.1;
                                                                estimatedHoursController
                                                                        .text =
                                                                    estimatedHours
                                                                        .toStringAsFixed(
                                                                          1,
                                                                        );
                                                              }
                                                            });
                                                          },
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons
                                                                  .keyboard_arrow_down,
                                                              size: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              onChanged: (value) {
                                                estimatedHours =
                                                    double.tryParse(value) ??
                                                    estimatedHours;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 10),

                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "CREATED BY",
                                            style: TextStyle(fontSize: 14),
                                          ),

                                          const SizedBox(height: 8),

                                          TextFormField(
                                            controller: _createdByCO,
                                            readOnly: true,
                                            //initialValue: "Crew",
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.all(
                                                10,
                                              ),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  93,
                                  91,
                                  91,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Close",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            const SizedBox(width: 10),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  34,
                                  113,
                                  249,
                                ),
                                disabledBackgroundColor: const Color.fromARGB(
                                  255,
                                  34,
                                  113,
                                  249,
                                ),
                                foregroundColor: Colors.white,
                                disabledForegroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: () async {
                                if (isUploadLoading) return;

                                print(
                                  "Estimated Hours : ${estimatedHoursController.text}",
                                );

                                setDialogState(() {
                                  isUploadLoading = true;
                                  imageSource = 'CO';
                                });

                                try {
                                  await submitChangeOrder(
                                    oid: overHeadPolylines[index].oid
                                        .toString(),
                                    userId: id,
                                    substation:
                                        overHeadPolylines[index].substation,
                                    feeder: overHeadPolylines[index].feederName,
                                    assignCrewType: "",
                                    spanName:
                                        overHeadPolylines[index].elementName,
                                    distance: currentSelectedDistanceMiles
                                        .toStringAsFixed(2),
                                    estTime: estimatedHoursController.text,
                                    year: widget.year,
                                    chatMsg: _commentsCOController.text,
                                  );
                                } catch (e) {
                                  if (context.mounted) {
                                    setDialogState(() {
                                      isUploadLoading = false;
                                    });
                                  }
                                }
                              },
                              child: isUploadLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                  : const Text(
                                      "Create",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  //////////////////////
  String jobNoCO = "";

  Future<void> submitChangeOrder({
    required String oid,
    required String userId,
    required String substation,
    required String feeder,
    required String assignCrewType,
    required String spanName,
    required String distance,
    required String estTime,
    required String year,
    required String chatMsg,
  }) async {
    final connectivity = await Connectivity().checkConnectivity();

    final body = {
      "oid": oid,
      "userId": userId,
      "substation": substation,
      "feeder": feeder,
      "assignCrewType": assignCrewType,
      "spanName": spanName,
      "distance": distance,
      "estTime": estTime,
      "year": year,
      "chatMsg": chatMsg,
    };

    if (!connectivity.contains(ConnectivityResult.none)) {
      try {
        print("========== Create Change Order Request ==========");
        print(jsonEncode(body));

        final response = await http.post(
          Uri.parse("${AppUrl.baseUrl}login_user/createChangeOrder"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode(body),
        );

        print("Status Code : ${response.statusCode}");
        print("Response : ${response.body}");

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);

          jobNoCO = responseData['change_order_created'].toString();

          print("jobNoCO : $jobNoCO");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Change Order created successfully.")),
          );
          await submitImage(
            imagePathsChangeOrder,
            jobNoCO,
            // widget.jobNo,
          );
          Navigator.pop(context);
          await loadApiData();
          showPopup = false;
          setState(() {
            isUploadLoading = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Failed to create Change Order (${response.statusCode})",
              ),
            ),
          );
        }
      } catch (e) {
        print("Create Change Order Error: $e");

        // Save offline if required
        await DatabaseHelper.instance.saveOfflineChangeOrder(body);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Saved Offline")));

        Navigator.pop(context);
        await loadApiData();
        showPopup = false;
        setState(() {
          isUploadLoading = false;
        });
      }
    } else {
      // Save offline if no internet
      await DatabaseHelper.instance.saveOfflineChangeOrder(body);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No Internet. Saved Offline")),
      );

      Navigator.pop(context);
      await loadApiData();
      showPopup = false;
      setState(() {
        isUploadLoading = false;
      });
    }
  }

  Future<void> _takePictureDialogCO() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Take Picture',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 23, 1, 88),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CameraPreview(_camerasController!),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: (() async {
                        // Take the picture first
                        XFile image = await _camerasController!.takePicture();

                        // Update the parent widget
                        refreshPathCO(image.path, image);

                        // Close only the camera dialog
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      }),
                      child: Container(
                        margin: const EdgeInsets.all(4.0),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.052,
                        decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 60, 59, 59),
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 7, 40, 97),
                              Color.fromARGB(255, 7, 40, 97),
                              Color.fromARGB(255, 7, 40, 97),
                            ],
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Take Picture",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void refreshPathCO(String path, XFile imageARG) {
    if (dialogSetStateCO != null) {
      dialogSetStateCO!(() {
        imagePathsChangeOrder.add(path);
        images.add(imageARG);
      });
    } else {
      setState(() {
        imagePathsChangeOrder.add(path);
        images.add(imageARG);
      });
    }
  }

  /////////images
  Future<void> cameraInit() async {
    _cameras = await availableCameras();
    _camerasController = CameraController(_cameras[0], ResolutionPreset.max);
    _camerasController!
        .initialize()
        .then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        })
        .catchError((Object e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                // Handle access errors here.
                break;
              default:
                // Handle other errors here.
                break;
            }
          }
        });
  }

  Future<void> _takePictureDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Take Picture',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 23, 1, 88),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CameraPreview(_camerasController!),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: (() async {
                        // Take the picture first
                        XFile image = await _camerasController!.takePicture();

                        // Update the parent widget
                        refreshPath(image.path, image);

                        // Close only the camera dialog
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      }),
                      child: Container(
                        margin: const EdgeInsets.all(4.0),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.052,
                        decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 60, 59, 59),
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 7, 40, 97),
                              Color.fromARGB(255, 7, 40, 97),
                              Color.fromARGB(255, 7, 40, 97),
                            ],
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Take Picture",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void refreshPath(String path, XFile imageARG) {
    if (dialogSetState != null) {
      dialogSetState!(() {
        imagePaths.add(path);
        images.add(imageARG);
      });
    } else {
      setState(() {
        imagePaths.add(path);
        images.add(imageARG);
      });
    }
  }

  Future<void> submitImage(List<String> imagePaths, String tokenNo) async {
    print('imagePaths: $imagePaths');
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    try {
      var uri = Uri.parse(
        "${AppUrl.baseUrl}contractorPanel/updateImageVEGETATION_CREW_FORMs",
      );
      var request = http.MultipartRequest("POST", uri);

      // Get the user token
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();

      // Set headers
      var headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
        "Authorization": 'Bearer ${data.token!}',
      };
      List<http.MultipartFile> multipartFiles = [];

      for (int i = 0; i < imagePaths.length; i++) {
        String imagePath = imagePaths[i];

        if (imagePath.isNotEmpty) {
          File img = File(imagePath);

          File file = await img.copy(
            '$tempPath/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}_$i${imagePath.contains('.pdf') ? '.pdf' : '.jpg'}',
          );

          var stream = http.ByteStream(file.openRead());
          var length = await file.length();

          var multipartFile = http.MultipartFile(
            "files",
            stream,
            length,
            filename: path.basename(file.path),
          );

          multipartFiles.add(multipartFile);
        }
      }

      if (multipartFiles.isNotEmpty) {
        request.files.addAll(multipartFiles); // Add all the selected files
      }

      request.fields['tokenNo'] = tokenNo;
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Images submitted successfully.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Uploaded Files Successfully ")),
        );
        setState(() {
          if (imageSource == 'CO') {
            imagePaths.clear();
            imageSource = '';
          }
          _commentsCOController.clear();
        });
      } else {
        print("Failed to submit images. Status code: ${response.statusCode}");
        print("Failed to submit images. response body: ${response.body}");
      }
    } catch (e, stacktrace) {
      print('Exception: $e\n$stacktrace');
    }
  }

  Future<void> fetchDataAndShowDialog(
    BuildContext ctx,
    double latitude,
    double longitude,
    String mapLocation,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      await DatabaseHelper.instance.fetchAndSaveCommentHistory(mapLocation);
    }
    commentsData = await DatabaseHelper.instance.getCommentHistory(mapLocation);
    showDialog(
      context: ctx,
      barrierDismissible: false, // Prevent dismissing while loading
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          content: const SizedBox(
            height: 120,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Colors.blue, // Customize color
                    strokeWidth: 4, // Thicker stroke
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Fetching Data...",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    final data = await fetchDataByLatLong(latitude, longitude);
    Navigator.pop(ctx);
    if (data != null && data.isNotEmpty) {
      final screenHeight = MediaQuery.of(context).size.height;
      final maxChatHeight = screenHeight * 0.30;
      bool isSendButton = false;
      showDialog(
        context: ctx,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                insetPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                contentPadding: const EdgeInsets.all(12),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.cancel_presentation_sharp,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Substation : ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: data[0]['wmUplineSo'] ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Feeder : ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    (data[0]['wmUpline_1'] != null &&
                                        data[0]['wmUpline_1'] != 'null' &&
                                        data[0]['wmUpline_1'] != '')
                                    ? 'FDR${data[0]['wmUpline_1']}'
                                    : '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Customer Name : ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: data[0]['wmBF_Name'] ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Address : ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: data[0]['wmBF_Ser_2'] ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            if (data[0]['wmBF_Phone'] != '' &&
                                data[0]['wmBF_Phone'] != null)
                              setState(() {
                                _launched = _makePhoneCall(
                                  data[0]['wmBF_Phone'],
                                );
                              });
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Phone Number : ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              children: [
                                TextSpan(
                                  text: data[0]['wmBF_Phone'] ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Phase : ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: data[0]['wmPhasing'] ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Map Location No : ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: data[0]['wmElementN'] ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Parcel : ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: data[0]['parcelNumber'] ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'LCP Comment : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),

                            const SizedBox(width: 4),
                            if (data[0]['wmBF_Comme']
                                    ?.toString()
                                    .trim()
                                    .isNotEmpty ??
                                false)
                              Expanded(
                                child: Container(
                                  height: 62,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Scrollbar(
                                    thumbVisibility: true,
                                    thickness: 4,
                                    radius: const Radius.circular(10),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Text(
                                        data[0]['wmBF_Comme']?.toString() ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          height: 1.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 8,
                            bottom: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 140,
                                child: Scrollbar(
                                  controller: chatScrollController,
                                  thumbVisibility: true,
                                  child: ListView.builder(
                                    controller: chatScrollController,
                                    reverse: true,
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                      right: 8,
                                    ),
                                    itemCount: commentsData.length,
                                    itemBuilder: (context, index) {
                                      final comment = commentsData[index];

                                      final bool isPlanner =
                                          comment["userName"]
                                              ?.toString()
                                              .toLowerCase() ==
                                          userName.toLowerCase();

                                      return _chatBubble(
                                        isPlanner: isPlanner,
                                        userName:
                                            comment["userName"]?.toString() ??
                                            "",
                                        date: "",
                                        message:
                                            comment["comment"]?.toString() ??
                                            "",
                                      );
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: chatController,
                                      minLines: 1,
                                      maxLines: 4,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        hintText: "Write Your Comments here...",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10,
                                            ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  SizedBox(
                                    height: 42,
                                    child: ElevatedButton(
                                      onPressed: isSendButton
                                          ? null
                                          : () async {
                                              setDialogState(() {
                                                isSendButton = true;
                                              });

                                              try {
                                                final comment = chatController
                                                    .text
                                                    .trim();

                                                if (comment.isEmpty) {
                                                  return;
                                                }

                                                final data = {
                                                  "mapLocation": mapLocation
                                                      .toString(),
                                                  "description": comment,
                                                  "userId": id.toString(),
                                                };

                                                await updateCommentData(
                                                  data,
                                                  () {
                                                    setDialogState(() {});
                                                  },
                                                );
                                              } finally {
                                                if (mounted) {
                                                  setDialogState(() {
                                                    isSendButton = false;
                                                  });
                                                }
                                              }
                                            },

                                      // onPressed: () async {
                                      //   final comment = chatController.text
                                      //       .trim();

                                      //   if (comment.isEmpty) {
                                      //     return;
                                      //   }

                                      //   final data = {
                                      //     "mapLocation": mapLocation.toString(),
                                      //     "description": comment,
                                      //     "userId": id.toString(),
                                      //   };

                                      //   await updateCommentData(data, () {
                                      //     setDialogState(() {});
                                      //   });
                                      // },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        foregroundColor: Colors.white,
                                        disabledBackgroundColor: Colors.teal,
                                        disabledForegroundColor: Colors.white,
                                      ),
                                      child: const Text("Send"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // actions: [
                //   TextButton(
                //     onPressed: () => Navigator.of(context).pop(),
                //     child: const Text('Close'),
                //   ),
                // ],
              );
            },
          );
        },
      );
    } else {
      _showSnackBar('No data available');
    }
  }

  Future<List<dynamic>?> fetchDataByLatLong(
    double latitude,
    double longitude,
  ) async {
    String baseUrl =
        '${AppUrl.baseUrl}supervisorLoginPanel/getDataByLatitudeLongitude';
    final Uri url = Uri.parse(
      '$baseUrl?latitude=$latitude&longitude=$longitude',
    );
    print('url consumer:: $url');
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    try {
      final http.Response response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${data.token!}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['getDataByLatitudeLongitude'] is List) {
          return jsonData['getDataByLatitudeLongitude'];
        } else {
          print('Unexpected response structure: ${response.body}');
          return null;
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  Future<List<Map<String, dynamic>>> _getLocationSuggestions(
    String query,
  ) async {
    try {
      final url =
          'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5';
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'flutter_map_app/1.0 (Flutter; Dart)'},
      );

      if (response.statusCode == 200) {
        final results = json.decode(response.body) as List;
        if (results.isEmpty) {
          // Call getDataByNameAndAccountNumber if no suggestions
          final fallbackData = await getDataByNameAndAccountNumber(query);
          if (fallbackData['getDataByNameAndAccountNumber'] != null) {
            return List<Map<String, dynamic>>.from(
              fallbackData['getDataByNameAndAccountNumber'],
            );
          }
          return [];
        }

        return results.map((result) {
          return {
            'name': result['display_name'],
            'latitude': result['lat'],
            'longitude': result['lon'],
          };
        }).toList();
      } else {
        final fallbackData = await getDataByNameAndAccountNumber(query);
        if (fallbackData['getDataByNameAndAccountNumber'] != null) {
          return List<Map<String, dynamic>>.from(
            fallbackData['getDataByNameAndAccountNumber'],
          );
        }
        return [];
      }
    } catch (e) {
      print("Error fetching location suggestions: $e");
      return [];
    }
  }

  Future<dynamic> getDataByNameAndAccountNumber(String accOrName) async {
    //102114900
    print('inside getDataByNameAndAccountNumber');
    String endpoint = "${AppUrl.baseUrl}supervisorLoginPanel/suggestions";
    final Uri url = Uri.parse(
      "$endpoint?searchTerm=$accOrName&substation=$selectedSubstation",
    );
    print('inside getDataByNameAndAccountNumber');
    print(url);
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    final headers = {'Authorization': 'Bearer ${data.token!}'};

    try {
      final response = await http.get(url, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('data: $data');
        return data;
      } else {
        print(
          'Error: Status code ${response.statusCode}, Body: ${response.body}',
        );
        return {
          "error":
              "Failed to load data. Status code: ${response.statusCode}, Body: ${response.body}",
        };
      }
    } catch (e) {
      print("Error occurred: $e");
      return {"error": "An error occurred: $e"};
    }
  }

  Future<void> _updateMapLocation(String suggestion, String? geometry) async {
    try {
      if (geometry == null || geometry.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location geometry not available')),
        );
        return;
      }

      final geometryText = geometry.trim();

      double? latitude;
      double? longitude;

      // ---------------------------------------------------------
      // POINT (longitude latitude)
      // Example:
      // POINT (-93.17011241148582 46.62905141076136)
      // ---------------------------------------------------------
      if (geometryText.toUpperCase().startsWith('POINT')) {
        final match = RegExp(
          r'POINT\s*\(\s*([-+]?\d*\.?\d+)\s+([-+]?\d*\.?\d+)\s*\)',
          caseSensitive: false,
        ).firstMatch(geometryText);

        if (match != null) {
          longitude = double.tryParse(match.group(1)!);
          latitude = double.tryParse(match.group(2)!);
        }
      }
      // ---------------------------------------------------------
      // LINESTRING (longitude latitude, longitude latitude, ...)
      //
      // Example:
      // LINESTRING (
      //   -92.68809521202394 47.849099574119286,
      //   -92.6880938141611 47.848609979915025
      // )
      //
      // We take the FIRST coordinate.
      // ---------------------------------------------------------
      else if (geometryText.toUpperCase().startsWith('LINESTRING')) {
        final match = RegExp(
          r'LINESTRING\s*\(\s*([-+]?\d*\.?\d+)\s+([-+]?\d*\.?\d+)',
          caseSensitive: false,
        ).firstMatch(geometryText);

        if (match != null) {
          longitude = double.tryParse(match.group(1)!);
          latitude = double.tryParse(match.group(2)!);
        }
      }

      // ---------------------------------------------------------
      // Validate coordinates
      // ---------------------------------------------------------
      if (latitude == null || longitude == null) {
        print('Invalid geometry: $geometryText');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid location geometry')),
        );

        return;
      }

      if (!latitude!.isFinite || !longitude!.isFinite) {
        print(
          'Invalid coordinates: '
          'latitude=$latitude, longitude=$longitude',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid location coordinates')),
        );

        return;
      }

      // ---------------------------------------------------------
      // Create LatLng
      // WKT = longitude latitude
      // LatLng = latitude longitude
      // ---------------------------------------------------------
      final newLocation = LatLng(latitude!, longitude!);

      print('Selected location: $suggestion');
      print('Geometry: $geometryText');
      print('Latitude: ${newLocation.latitude}');
      print('Longitude: ${newLocation.longitude}');

      // ---------------------------------------------------------
      // Update marker
      // ---------------------------------------------------------
      setState(() {
        _currentLocation = newLocation;

        _markerSearch = [
          Marker(
            point: newLocation,
            width: 50,
            height: 50,
            child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
          ),
        ];
      });

      // ---------------------------------------------------------
      // Move map
      // ---------------------------------------------------------
      _mapController.move(newLocation, _currentZoom);
    } catch (e) {
      print('Error locating address: $e');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error locating address')));
    }
  }

  DateTime? _parseCreateDate(dynamic value) {
    if (value == null) return null;

    final dateString = value.toString().trim();

    if (dateString.isEmpty) return null;

    try {
      // API format:
      // 2026-08-10 05:59:04.201000
      return DateTime.parse(dateString.replaceFirst(' ', 'T'));
    } catch (e) {
      print("Unable to parse createDate: $dateString");
      print("Error: $e");
      return null;
    }
  }

  Future<bool> _setLatestObjectAndZoom() async {
    if (overHeadData.isEmpty) {
      print("No overhead data available");
      return false;
    }

    Map<String, dynamic>? latestRow;
    DateTime? latestDate;

    for (final row in overHeadData) {
      final date = _parseCreateDate(row["createDate"]);

      if (date == null) {
        continue;
      }

      if (latestDate == null || date.isAfter(latestDate!)) {
        latestDate = date;
        latestRow = row;
      }
    }

    // No valid createDate found
    if (latestRow == null) {
      print("No valid createDate found");
      return false;
    }

    final latestSubstation = latestRow["substation"]?.toString().trim();

    final latestFeeder = latestRow["feederName"]?.toString().trim();

    final latestSubstationId = int.tryParse(
      latestRow["substationId"]?.toString() ?? "",
    );

    print('latest record-----------------');
    print("Latest createDate: ${latestRow["createDate"]}");
    print("Latest substation: $latestSubstation");
    print("Latest substationId: $latestSubstationId");
    print("Latest feeder: $latestFeeder");

    // Set substation and feeder
    if (mounted) {
      setState(() {
        selectedSubstation = latestSubstation;
        selectedSubstationId = latestSubstationId;
        selectedFeeder = latestFeeder;
      });
    }

    // Get latest object's WKT
    final wkt = latestRow["wkt"];

    if (wkt == null || wkt.toString().trim().isEmpty) {
      print("Latest object has no WKT");
      return false;
    }

    try {
      final points = parseLineString(wkt.toString());

      if (points.isEmpty) {
        print("Latest object has no points");
        return false;
      }

      final center = getPolylineCenter(points);

      _currentZoom = 17.0;

      // Wait until Flutter updates the UI
      await Future.delayed(const Duration(milliseconds: 100));

      if (!mounted) {
        return false;
      }

      _mapController.move(center, _currentZoom);

      print("Map moved to latest object");
      print("Center: $center");

      return true;
    } catch (e) {
      print("Error moving map to latest object: $e");
      return false;
    }
  }

  Future<void> updateCommentData(
    Map<String, dynamic> mapData,
    VoidCallback refreshDialog,
  ) async {
    final connectivity = await Connectivity().checkConnectivity();

    final Map<String, dynamic> saveData = {
      "mapLocation": mapData["mapLocation"]?.toString() ?? "",
      "comment": mapData["description"]?.toString() ?? "",
      "userId": mapData["userId"]?.toString() ?? "",
      "userName": userName,
      "status": 0,
    };

    if (!connectivity.contains(ConnectivityResult.none)) {
      try {
        final response = await http.post(
          Uri.parse("${AppUrl.baseUrl}login_user/addComment"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode(mapData),
        );

        print("Comment Request: ${jsonEncode(mapData)}");
        print("Status Code: ${response.statusCode}");
        print("Response: ${response.body}");

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);

          print("Decoded Response: $responseData");

          final db = await DatabaseHelper.instance.database;

          // Save successfully submitted comment
          await db.insert("commentHistoryTable", {
            "id": responseData["id"] ?? 0,
            "comment": mapData["description"]?.toString() ?? "",
            "userName": userName,
            "userId": mapData["userId"]?.toString() ?? "",
            "mapLocation": mapData["mapLocation"]?.toString() ?? "",
            "status": 1,
            "fetchId": DateTime.now().millisecondsSinceEpoch,
          }, conflictAlgorithm: ConflictAlgorithm.replace);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Comment sent successfully")),
          );

          chatController.clear();

          // Reload comments from DB
          commentsData = await DatabaseHelper.instance.getCommentHistory(
            mapData["mapLocation"].toString(),
          );

          refreshDialog();

          if (mounted) {
            setState(() {});
          }
        } else {
          print("Failed to send comment. Status: ${response.statusCode}");

          // Save offline if API returns failure
          await DatabaseHelper.instance.saveOfflineComment(saveData);

          commentsData = await DatabaseHelper.instance.getCommentHistory(
            mapData["mapLocation"].toString(),
          );

          refreshDialog();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Comment saved offline")),
          );

          chatController.clear();
        }
      } catch (e) {
        print("Error sending comment: $e");

        // Save offline
        await DatabaseHelper.instance.saveOfflineComment(saveData);

        commentsData = await DatabaseHelper.instance.getCommentHistory(
          mapData["mapLocation"].toString(),
        );

        refreshDialog();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to send. Comment saved offline"),
          ),
        );

        chatController.clear();
      }
    } else {
      // No internet
      await DatabaseHelper.instance.saveOfflineComment(saveData);

      commentsData = await DatabaseHelper.instance.getCommentHistory(
        mapData["mapLocation"].toString(),
      );

      refreshDialog();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No Internet. Comment saved offline")),
      );

      chatController.clear();
    }
  }

  Widget _buildImageGrid() {
    final images = imageViewModel.imageData.data?.images ?? [];

    final imageLocations = images
        .map((e) => e.imageLocation ?? '')
        .where((e) => e.isNotEmpty)
        .toList();

    return NetworkImageGallery(imageLocations: imageLocations);
  }
  // Widget _buildImageGrid() {
  //   final images = imageViewModel.imageData.data?.images ?? [];

  //   if (images.isEmpty) {
  //     return const Center(
  //       child: Text(
  //         "No images found",
  //         style: TextStyle(fontWeight: FontWeight.bold),
  //       ),
  //     );
  //   }

  //   return SizedBox(
  //     height: 120,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: images.length,
  //       itemBuilder: (context, index) {
  //         final fileLocation = images[index].imageLocation;

  //         if (fileLocation == null || fileLocation.isEmpty) {
  //           return const SizedBox();
  //         }

  //         return Padding(
  //           padding: const EdgeInsets.only(right: 10),
  //           child: InkWell(
  //             onTap: () {
  //               openFullSizeImageDialog(fileLocation);
  //             },
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(10),
  //               child: Image.network(
  //                 'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
  //                 fit: BoxFit.cover,
  //                 width: 120,
  //                 height: 120,
  //                 loadingBuilder: (context, child, loadingProgress) {
  //                   if (loadingProgress == null) {
  //                     return child;
  //                   }

  //                   return const SizedBox(
  //                     width: 120,
  //                     height: 120,
  //                     child: Center(child: CircularProgressIndicator()),
  //                   );
  //                 },
  //                 errorBuilder: (context, error, stackTrace) {
  //                   return Container(
  //                     width: 120,
  //                     height: 120,
  //                     color: Colors.grey.shade200,
  //                     child: const Icon(
  //                       Icons.broken_image_outlined,
  //                       size: 40,
  //                       color: Colors.grey,
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // void openFullSizeImageDialog(String imageUrl) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         insetPadding: EdgeInsets.zero,
  //         child: Stack(
  //           children: [
  //             PhotoViewGallery(
  //               pageController: PageController(),
  //               backgroundDecoration: const BoxDecoration(color: Colors.black),
  //               onPageChanged: (index) {},
  //               scrollPhysics: const BouncingScrollPhysics(),
  //               pageOptions: [
  //                 PhotoViewGalleryPageOptions(
  //                   imageProvider: NetworkImage(
  //                     'https://civm.ariespro.com/assets/clientuploads/$imageUrl',
  //                   ),
  //                   minScale: PhotoViewComputedScale.contained * 0.5,
  //                   maxScale: PhotoViewComputedScale.covered * 0.5,
  //                 ),
  //               ],
  //             ),
  //             Positioned(
  //               top: 30,
  //               right: 20,
  //               child: IconButton(
  //                 icon: const Icon(Icons.close, color: Colors.white, size: 30),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  //////////
}

class Substation {
  final int subId;
  final String subName;

  Substation({required this.subId, required this.subName});
}

//polyline ontap---------
class OverHeadPolylineData {
  final String phase;

  final String vegetationColor;
  final String maintType;
  final String jobNo;
  final String feederName;
  final int oid;
  final String substationFeederId;

  final String wkt;
  final List<LatLng> points;
  final Color originalColor;
  final String substation;
  final String elementName;
  final double distanceMiles;
  final String totalMilesApi;
  final String spanDistanceApi;
  final String contractorId;
  final String substationId;
  final bool hasChat;
  final String createDate;
  final String maintStatus;
  final String rework;
  final String completedByCrewName;
  final String completedByCrewId;
  final String assignedCrewName;
  final String assignedCrewId;
  final String coordinateIds;
  final String completionFlag;
  final String service;

  OverHeadPolylineData({
    required this.phase,
    required this.vegetationColor,
    required this.maintType,
    required this.jobNo,
    required this.feederName,
    required this.oid,
    required this.substationFeederId,
    required this.wkt,
    required this.points,
    required this.originalColor,
    required this.substation,
    required this.elementName,
    required this.distanceMiles,
    required this.totalMilesApi,
    required this.spanDistanceApi,
    required this.contractorId,
    required this.substationId,
    required this.hasChat,
    required this.createDate,
    required this.maintStatus,
    required this.rework,
    required this.completedByCrewName,
    required this.completedByCrewId,
    required this.assignedCrewName,
    required this.assignedCrewId,
    required this.coordinateIds,
    required this.completionFlag,
    required this.service,
  });
}

//-----------------------
