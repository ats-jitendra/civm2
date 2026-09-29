import 'dart:convert';

import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/offline_map/custom_widgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('mapApidata.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 21,
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        // Future database migrations go here.
        if (oldVersion < 2) {
          await db.execute(
            "ALTER TABLE overHeadTable ADD COLUMN completedByCrewName TEXT",
          );

          await db.execute(
            "ALTER TABLE overHeadTable ADD COLUMN completedByCrewId TEXT",
          );

          await db.execute(
            "ALTER TABLE overHeadTable ADD COLUMN assignedCrewName TEXT",
          );

          await db.execute(
            "ALTER TABLE overHeadTable ADD COLUMN assignedCrewId TEXT",
          );

          await db.execute(
            "ALTER TABLE overHeadTable ADD COLUMN maintStatus TEXT",
          );
        }
        if (oldVersion < 3) {
          await db.execute(
            "ALTER TABLE overHeadTable ADD COLUMN coordinateIds TEXT",
          );
        }
        if (oldVersion < 4) {
          await db.execute(
            "ALTER TABLE overHeadTable ADD COLUMN completionStatus INTEGER DEFAULT 1",
          );
        }
        if (oldVersion < 5) {
          await db.execute(
            "ALTER TABLE overHeadTable ADD COLUMN completionFlag TEXT",
          );
        }
        if (oldVersion < 6) {
          await db.execute('''
    CREATE TABLE IF NOT EXISTS crewTable (
      id INTEGER PRIMARY KEY,
      maintType TEXT,
      crewType TEXT,
      name TEXT
    )
  ''');
        }
        if (oldVersion < 7) {
          try {
            await db.execute("ALTER TABLE crewTable ADD COLUMN maintType TEXT");
          } catch (e) {
            print(e);
          }
        }
        if (oldVersion < 8) {
          await db.execute('''
    CREATE TABLE IF NOT EXISTS reworkHistoryTable(
      id INTEGER PRIMARY KEY,
      loginId TEXT,
      lineId TEXT,
      maintType TEXT,
      contractorTime TEXT,
      spanName TEXT,
      supervisorTime TEXT,
      adminTime TEXT,
      status TEXT,
      username TEXT,
      geometry TEXT,
      fetchId INTEGER
    )
  ''');
        }
        if (oldVersion < 9) {
          await db.execute("ALTER TABLE overHeadTable ADD COLUMN rework TEXT");
        }
        if (oldVersion < 10) {
          await db.execute('''
  CREATE TABLE changeOrderTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    oid TEXT,
    userId TEXT,
    substation TEXT,
    feeder TEXT,
    assignCrewType TEXT,
    spanName TEXT,
    distance TEXT,
    estTime TEXT,
    year TEXT,
    chatMsg TEXT,
    status INTEGER DEFAULT 0, 
    createdAt INTEGER
  )
  ''');
        }
        if (oldVersion < 11) {
          await db.execute('''
      CREATE TABLE IF NOT EXISTS reworkCompletedTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        lineId TEXT,
        crewId TEXT,
        maintType TEXT,
        status TEXT,
        tokenNo TEXT,
        userId TEXT,
        syncStatus INTEGER DEFAULT 0,
        createdAt INTEGER
      )
    ''');
        }
        if (oldVersion < 12) {
          await db.execute('''
      CREATE TABLE IF NOT EXISTS reworkDetailsTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
  dateTime TEXT,
  substationName TEXT,
  maintType TEXT,
  jobNo TEXT,
  crewId TEXT,
  crewName TEXT,
  geometry TEXT,
  feederName TEXT,
  spanName TEXT,
  status TEXT,
  fetchId INTEGER
      )
    ''');
          await db.execute('''
    CREATE TABLE IF NOT EXISTS inspectionListTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      dateTime TEXT,
      substationName TEXT,
      maintType TEXT,
      jobNo TEXT,
      crewId TEXT,
      crewName TEXT,
      geometry TEXT,
      feederName TEXT,
      spanName TEXT,
      status TEXT,
      fetchId INTEGER
    )
  ''');
        }
        if (oldVersion < 13) {
          await db.execute('''
      CREATE TABLE commentHistoryTable (
        id INTEGER,
        comment TEXT,
        userName TEXT,
        userId TEXT,
        mapLocation TEXT,
        status INTEGER DEFAULT 1,
        fetchId INTEGER
      )
    ''');
        }
        if (oldVersion < 14) {
          await db.execute(
            "ALTER TABLE consumerTable ADD COLUMN hasComment TEXT",
          );
          await db.execute(
            "ALTER TABLE consumerTable ADD COLUMN mapLocation TEXT",
          );
        }
        if (oldVersion < 15) {
          await db.execute('''
      CREATE TABLE overHeadChangeOrderTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
      phase TEXT,
      wkt TEXT,
      color TEXT,
      vegetationColor TEXT,
      contractorId TEXT,
      weight TEXT,
      oId INTEGER UNIQUE,
      totalMiles TEXT,
      substationFeederId TEXT,
      elementName TEXT,
      substationId TEXT,
      maintType TEXT,
      substation TEXT,
      jobNo TEXT,
      feederName TEXT,
      opacity TEXT,
      spanDistance TEXT,
      createdById TEXT,
      hasChat TEXT,
      createDate TEXT,
      completedByCrewName TEXT,
      completedByCrewId TEXT,
      assignedCrewName TEXT,
      assignedCrewId TEXT,
      maintStatus TEXT,
      rework TEXT,
      coordinateIds TEXT,
      completionFlag TEXT,
      status INTEGER DEFAULT 1,
      completionStatus INTEGER DEFAULT 1,
      createdAt INTEGER,
      fetchId INTEGER
      )
    ''');
          await db.execute(
            "CREATE INDEX idx_overheadchangeorder_sub_feeder ON overHeadChangeOrderTable(substation, feederName)",
          );
        }
        if (oldVersion < 16) {
          await db.execute("ALTER TABLE overHeadTable ADD COLUMN type TEXT");
          await db.execute(
            "ALTER TABLE overHeadChangeOrderTable ADD COLUMN type TEXT",
          );
        }
        if (oldVersion < 17) {
          await db.execute(
            "ALTER TABLE overHeadChangeOrderTable ADD COLUMN estTime TEXT",
          );
          //  await db.execute(
          //   "ALTER TABLE overHeadTable ADD COLUMN estTime TEXT",
          // );
        }
        if (oldVersion < 18) {
          await db.execute("ALTER TABLE overHeadTable ADD COLUMN estTime TEXT");
        }
        if (oldVersion < 19) {
          try {
            await db.execute(
              "ALTER TABLE overHeadTable ADD COLUMN service TEXT",
            );
          } on DatabaseException catch (e) {
            if (!e.toString().contains('duplicate column name')) {
              rethrow;
            }
            print("service already exists in overHeadTable");
          }

          try {
            await db.execute(
              "ALTER TABLE overHeadChangeOrderTable ADD COLUMN service TEXT",
            );
          } on DatabaseException catch (e) {
            if (!e.toString().contains('duplicate column name')) {
              rethrow;
            }
            print("service already exists in overHeadChangeOrderTable");
          }
        }
        if (oldVersion < 20) {
          await db.execute(
            "ALTER TABLE underGroundTable ADD COLUMN service TEXT",
          );
        }
          if (oldVersion < 21) {
          await db.execute(
            "ALTER TABLE commentHistoryTable ADD COLUMN flag TEXT",
          );
        }
         
      },
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE overHeadTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
      phase TEXT,
      wkt TEXT,
      color TEXT,
      vegetationColor TEXT,
      contractorId TEXT,
      weight TEXT,
      oId INTEGER UNIQUE,
      totalMiles TEXT,
      substationFeederId TEXT,
      elementName TEXT,
      substationId TEXT,
      maintType TEXT,
      type TEXT,
      estTime TEXT,
      substation TEXT,
      jobNo TEXT,
      feederName TEXT,
      opacity TEXT,
      spanDistance TEXT,
      createdById TEXT,
      hasChat TEXT,
      createDate TEXT,
      completedByCrewName TEXT,
      completedByCrewId TEXT,
      assignedCrewName TEXT,
      assignedCrewId TEXT,
      maintStatus TEXT,
      rework TEXT,
      coordinateIds TEXT,
      completionFlag TEXT,
      service TEXT,
      status INTEGER DEFAULT 1,
      completionStatus INTEGER DEFAULT 1,
      createdAt INTEGER,
      fetchId INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE overHeadChangeOrderTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
      phase TEXT,
      wkt TEXT,
      color TEXT,
      vegetationColor TEXT,
      contractorId TEXT,
      weight TEXT,
      oId INTEGER UNIQUE,
      totalMiles TEXT,
      substationFeederId TEXT,
      elementName TEXT,
      substationId TEXT,
      maintType TEXT,
      type TEXT,
       estTime TEXT,
      substation TEXT,
      jobNo TEXT,
      feederName TEXT,
      opacity TEXT,
      spanDistance TEXT,
      createdById TEXT,
      hasChat TEXT,
      createDate TEXT,
      completedByCrewName TEXT,
      completedByCrewId TEXT,
      assignedCrewName TEXT,
      assignedCrewId TEXT,
      maintStatus TEXT,
      rework TEXT,
      coordinateIds TEXT,
      completionFlag TEXT,
      service TEXT,
      status INTEGER DEFAULT 1,
      completionStatus INTEGER DEFAULT 1,
      createdAt INTEGER,
      fetchId INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE polesTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        wmSubBou_1 TEXT,
        wmSubBound TEXT,
        geometry TEXT UNIQUE,
        elementName TEXT,
        substation TEXT,
  feederName TEXT,
          createdAt INTEGER,
          fetchId INTEGER
      )
    ''');
    await db.execute('''
CREATE TABLE yearTable(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  year INTEGER UNIQUE
)
''');

    await db.execute('''
CREATE TABLE substationTable(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  subId INTEGER UNIQUE,
  subName TEXT,
  year TEXT
)
''');

    await db.execute('''
CREATE TABLE feederTable(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  feederId INTEGER UNIQUE,
  feederName TEXT,
  substation TEXT
)
''');
    await db.execute('''
CREATE TABLE substationBoundaryTable(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  substation TEXT UNIQUE,
  geometry TEXT,
  feederName TEXT,
    createdAt INTEGER,
    fetchId INTEGER
)
''');
    await db.execute('''
CREATE TABLE consumerTable(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  consumerId INTEGER,
  uplineSource TEXT,
  phone TEXT,
  phasing TEXT,
  meter TEXT,
  name TEXT,
  account TEXT,
  accountStatus TEXT,
  geometry TEXT UNIQUE,
  substation TEXT,
  feederName TEXT,
  hasComment TEXT,
  mapLocation TEXT,
    createdAt INTEGER,
    fetchId INTEGER
)
''');
    await db.execute('''
CREATE TABLE underGroundTable(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  phase TEXT,
  wkt TEXT,
  substation TEXT,
  feederName TEXT,
  oId INTEGER UNIQUE,
  substationFeederId TEXT,
  elementName TEXT,
  service TEXT,
    createdAt INTEGER,
    fetchId INTEGER
)
''');
    await db.execute('''
CREATE TABLE contractorTable(
  id INTEGER PRIMARY KEY,
  contractorId INTEGER,
  fName TEXT,
  lName TEXT,
  supervisorId INTEGER
)
''');
    await db.execute('''
CREATE TABLE messageTable(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  lineId TEXT,
  createdDate TEXT,
  messageType TEXT,
  description TEXT,
  userName TEXT,
  userId TEXT,
  status INTEGER DEFAULT 1,
   fetchId INTEGER
)
''');
    await db.execute('''
CREATE TABLE crewTable (
    id INTEGER PRIMARY KEY,
    maintType TEXT,
    crewType TEXT,
    name TEXT
);
''');
    await db.execute('''
CREATE TABLE reworkHistoryTable(
  id INTEGER PRIMARY KEY,
  loginId TEXT,
  lineId TEXT,
  maintType TEXT,
  contractorTime TEXT,
  spanName TEXT,
  supervisorTime TEXT,
  adminTime TEXT,
  status TEXT,
  username TEXT,
  geometry TEXT,
  
  fetchId INTEGER
)
''');
    // Create indexes
    await db.execute(
      "CREATE INDEX idx_overhead_sub_feeder ON overHeadTable(substation, feederName)",
    );
    await db.execute(
      "CREATE INDEX idx_overheadchangeorder_sub_feeder ON overHeadChangeOrderTable(substation, feederName)",
    );
    await db.execute(
      "CREATE INDEX idx_poles_sub_feeder ON polesTable(substation, feederName)",
    );

    await db.execute(
      "CREATE INDEX idx_consumer_sub_feeder ON consumerTable(substation, feederName)",
    );

    await db.execute(
      "CREATE INDEX idx_boundary_sub_feeder ON substationBoundaryTable(substation, feederName)",
    );

    await db.execute(
      "CREATE INDEX idx_underground_sub_feeder ON underGroundTable(substation, feederName)",
    );

    await db.execute('''
CREATE TABLE changeOrderTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  oid TEXT,
  userId TEXT,
  substation TEXT,
  feeder TEXT,
  assignCrewType TEXT,
  spanName TEXT,
  distance TEXT,
  estTime TEXT,
  year TEXT,
  chatMsg TEXT,
  status INTEGER DEFAULT 0,
  createdAt INTEGER
  
)
''');
    await db.execute('''
CREATE TABLE IF NOT EXISTS reworkCompletedTable(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  lineId TEXT,
  crewId TEXT,
  maintType TEXT,
  status TEXT,
  tokenNo TEXT,
  userId TEXT,
  syncStatus INTEGER DEFAULT 0,
  createdAt INTEGER
)
''');
    await db.execute('''
CREATE TABLE reworkDetailsTable(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  dateTime TEXT,
  substationName TEXT,
  maintType TEXT,
  jobNo TEXT,
  crewId TEXT,
  crewName TEXT,
  geometry TEXT,
  feederName TEXT,
  spanName TEXT,
  status TEXT,
  fetchId INTEGER
)
''');
    await db.execute('''
CREATE TABLE inspectionListTable(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  dateTime TEXT,
  substationName TEXT,
  maintType TEXT,
  jobNo TEXT,
  crewId TEXT,
  crewName TEXT,
  geometry TEXT,
  feederName TEXT,
  spanName TEXT,
  status TEXT,
  fetchId INTEGER
)
''');
    await db.execute('''
  CREATE TABLE commentHistoryTable (
    id INTEGER,
    comment TEXT,
    userName TEXT,
    userId TEXT,
    mapLocation TEXT,
    flag TEXT,
    status INTEGER DEFAULT 1,
    fetchId INTEGER
  )
''');
  }

  // String token =
  //     "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJTdXBlcnZpc29yIiwiZXhwIjoxNzg1NjczMDY0LCJpYXQiOjE3ODQzNzcwNjR9.0_0isQ_C_sh-Mz8rmpS7kSr9tjtbbt3XlgQGa1Ob6XY";
  /////fetch and save methods----------------------------------------------
  /// Fetch API and Save into SQLite
  Future<void> fetchAndSaveMapData(
    String substationName,
    String feederName,
    String token, {
    String? recordType = "",
    String? jobNo = "",
  }) async {
    final db = await database;
    if (substationName == "null") {
      substationName = "";
    }
    if (feederName == "null") {
      feederName = "";
    }
    var url =
        "${AppUrl.baseUrl}login_user/getMapLayerData?substationName=$substationName&feeder=$feederName&recordType=$recordType&jobNo=$jobNo";
    print('map Url $url');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    print('sf token---$token');
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      // ADD HERE
      final int fetchId = DateTime.now().millisecondsSinceEpoch;
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      final List<dynamic> overHeadList = jsonData["overHead"] ?? [];
      final List<dynamic> polesList = jsonData["poles"] ?? [];
      final List<dynamic> boundaryList = jsonData["substationBoundary"] ?? [];
      print("Boundary API Count: ${boundaryList.length}");

      if (boundaryList.isNotEmpty) {
        print(boundaryList.first);
      }
      final List<dynamic> consumerList = jsonData["consumer"] ?? [];
      final List<dynamic> underGroundList = jsonData["underGround"] ?? [];
      Batch batch = db.batch();

      ///overhead
      // Remove old records
      // batch.delete("overHeadTable");
      final String overHeadTableName = recordType == "changeOrder"
          ? "overHeadChangeOrderTable"
          : "overHeadTable";
      for (var item in overHeadList) {
        batch.insert(overHeadTableName, {
          "phase": item["phase"] ?? "",
          "wkt": item["wkt"] ?? "",
          "color": item["color"] ?? "",
          "vegetationColor": item["vegetationColor"] ?? "",
          "contractorId": item["contractorId"] ?? "",
          "weight": item["weight"] ?? "",
          "oId": item["oId"] ?? 0,
          "totalMiles": item["totalMiles"] ?? "",
          "substationFeederId": item["substationFeederId"] ?? "",
          "elementName": item["elementName"] ?? "",
          "substationId": item["substationId"] ?? "",
          "maintType": item["maintType"] ?? "",
          "type": item["type"] ?? "",
          "estTime": item["estTime"] ?? "",
          "substation": item["substation"] ?? "",
          "jobNo": item["jobNo"] ?? "",
          "feederName": item["feederName"] ?? "",
          "opacity": item["opacity"] ?? "",
          "spanDistance": item["spanDistance"] ?? "",
          "createdById": item["createdById"] ?? "",
          "hasChat": item["hasChat"] ?? "",
          "createDate": item["createDate"] ?? "",
          "completedByCrewName": item["completedByCrewName"] ?? "",
          "completedByCrewId": item["completedByCrewId"] ?? "",
          "assignedCrewName": item["assignedCrewName"] ?? "",
          "assignedCrewId": item["assignedCrewId"] ?? "",
          "maintStatus": item["maintStatus"] ?? "",
          "rework": item["rework"] ?? "",
          "coordinateIds": item["coordinateIds"] ?? "",
          "completionFlag": item["completionFlag"] ?? "",
          "service": item["service"] ?? "",
          "status": 1,
          "completionStatus": 1,
          "createdAt": DateTime.now().millisecondsSinceEpoch,
          "fetchId": fetchId,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      //Poles
      //  batch.delete("polesTable");

      for (var item in polesList) {
        batch.insert("polesTable", {
          "wmSubBou_1": item["wmSubBou_1"] ?? "",
          "wmSubBound": item["wmSubBound"] ?? "",
          "geometry": item["geometry"] ?? "",
          "elementName": item["elementName"] ?? "",
          "substation": item["substation"] ?? "",
          "feederName": item["feederName"] ?? "",
          "createdAt": DateTime.now().millisecondsSinceEpoch,
          "fetchId": fetchId,
          //DateTime.now().toIso8601String(),
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      ////boundary
      // batch.delete("substationBoundaryTable");

      for (var item in boundaryList) {
        batch.insert("substationBoundaryTable", {
          "substation": item["substation"] ?? "",
          "feederName": item["feederName"] ?? "",
          "geometry": item["geometry"] ?? "",
          "createdAt": DateTime.now().millisecondsSinceEpoch,
          "fetchId": fetchId,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      ////consumer
      //  batch.delete("consumerTable");

      for (var item in consumerList) {
        batch.insert("consumerTable", {
          "consumerId": item["id"] ?? 0,
          "uplineSource": item["uplineSource"] ?? "",
          "phone": item["phone"] ?? "",
          "phasing": item["phasing"] ?? "",
          "meter": item["meter"] ?? "",
          "name": item["name"] ?? "",
          "account": item["account"] ?? "",
          "accountStatus": item["account1"] ?? "",
          "geometry": item["geometry"] ?? "",
          "substation": item["substation"] ?? "",
          "feederName": item["feederName"] ?? "",
          "hasComment": item["hasComment"] ?? "",
          "mapLocation": item["mapLocation"] ?? "",
          "createdAt": DateTime.now().millisecondsSinceEpoch,
          "fetchId": fetchId,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      //////underground
      //  batch.delete("underGroundTable");

      for (var item in underGroundList) {
        batch.insert("underGroundTable", {
          "phase": item["phase"] ?? "",
          "wkt": item["wkt"] ?? "",
          "substation": item["substation"] ?? "",
          "feederName": item["feederName"] ?? "",
          "oId": item["oId"] ?? 0,
          "substationFeederId": item["substationFeederId"] ?? "",
          "elementName": item["elementName"] ?? "",
          "service": item["service"] ?? "",
          "createdAt": DateTime.now().millisecondsSinceEpoch,
          "fetchId": fetchId,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);
      //////debugging code
      //       final rows = await db.rawQuery("""
      // SELECT fetchId, COUNT(*) count
      // FROM overHeadTable
      // GROUP BY fetchId
      // ORDER BY fetchId DESC
      // """);
      //       print("---rows-------");
      //       print(rows);
      // Delete old downloads and keep only the latest 10
      await deleteOldFetches(keepLatest: 10);
      //////debugging code
      // // Print first 2 rows from overHeadTable
      // final overHeadRows = await db.query("overHeadTable", limit: 2);
      // print("===== overHeadTable =====");
      // for (var row in overHeadRows) {
      //   print(row);
      // }
      ///////////------------------
      // final boundaryRows = await db.query("substationBoundaryTable");

      // print("Boundary table total rows: ${boundaryRows.length}");

      // for (var row in boundaryRows.take(5)) {
      //   print(row);
      // }
    }
  }

  // Future<List<Map<String, dynamic>>> getOverHeadData() async {
  //   final db = await database;
  //   return await db.query("overHeadTable");
  // }
  Future<List<Map<String, dynamic>>> getOverHeadData(
    String substation,
    String feeder,
  ) async {
    final db = await database;
    // Print total rows in substationTable
    // final allRows = await db.query("overHeadTable");
    // print("Total overHeadTable records in DB: ${allRows.length}");
    final count = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM overHeadTable"),
    );
    print("Total overHeadTable records in DB: $count");
    return await db.query(
      "overHeadTable",
      where: "substation = ? AND feederName = ?",
      whereArgs: [substation, feeder],
    );
  }

  Future<List<Map<String, dynamic>>> getOverHeadChangeOrderData(
    String substation,
    String feeder,
  ) async {
    final db = await database;
    // Print total rows in substationTable
    // final allRows = await db.query("overHeadTable");
    // print("Total overHeadTable records in DB: ${allRows.length}");
    final count = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM overHeadChangeOrderTable"),
    );
    print("Total overHeadChangeOrderTable records in DB: $count");
    return await db.query(
      "overHeadChangeOrderTable",
      where: "substation = ? AND feederName = ?",
      whereArgs: [substation, feeder],
    );
  }

  // Future<List<Map<String, dynamic>>> getPolesData() async {
  //   final db = await database;
  //   return await db.query("polesTable");
  // }
  Future<List<Map<String, dynamic>>> getPolesData(String substation) async {
    final db = await database;
    print('substation $substation');
    return await db.query(
      "polesTable",
      where: "substation = ?",
      whereArgs: [substation],
    );
  }

  // Future<List<Map<String, dynamic>>> getBoundaryData() async {
  //   final db = await database;
  //   return await db.query("substationBoundaryTable");
  // }
  Future<List<Map<String, dynamic>>> getBoundaryData(String substation) async {
    final db = await database;
    //ddebug

    return await db.query(
      "substationBoundaryTable",
      where: "substation = ?",
      whereArgs: [substation],
    );
  }

  // Future<List<Map<String, dynamic>>> getConsumerData() async {
  //   final db = await database;
  //   return await db.query("consumerTable");
  // }
  Future<List<Map<String, dynamic>>> getConsumerData(String substation) async {
    final db = await database;

    return await db.query(
      "consumerTable",
      where: "substation = ?",
      whereArgs: [substation],
    );
  }

  // Future<List<Map<String, dynamic>>> getUnderGroundData() async {
  //   final db = await database;
  //   return await db.query("underGroundTable");
  // }
  Future<List<Map<String, dynamic>>> getUnderGroundData(
    String substation,
    String feeder,
  ) async {
    final db = await database;

    return await db.query(
      "underGroundTable",
      where: "substation = ? AND feederName = ?",
      whereArgs: [substation, feeder],
    );
  }

  ////////////
  Future<void> fetchAndSaveDropdownData(
    String year,
    String substationId,
  ) async {
    final db = await database;
    if (substationId == "null") {
      substationId = "";
    }
    if (year == "null") {
      year = "";
    }
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    var url =
        "${AppUrl.baseUrl}login_user/getMapDropdownData?year=$year&substationId=$substationId";
    print('filter Url $url');
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      final dropdownData = jsonData["DropdownData"];

      final List<dynamic> years = dropdownData["year"] ?? [];
      final List<dynamic> substations = dropdownData["substation"] ?? [];
      final List<dynamic> feeders = dropdownData["feeder"] ?? [];

      Batch batch = db.batch();

      // Delete old data
      // batch.delete("yearTable");
      // batch.delete("substationTable");
      // batch.delete("feederTable");
      print('print delete data list $substationId');
      // Insert Years
      for (var year in years) {
        batch.insert("yearTable", {
          "year": year,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      // Insert Substations
      for (var item in substations) {
        batch.insert("substationTable", {
          "subId": item["subId"],
          "subName": item["subName"],
          "year": item["year"],
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      // Insert Feeders
      for (var item in feeders) {
        batch.insert("feederTable", {
          "feederId": item["feederId"],
          "feederName": item["feederName"],
          "substation": item['substation'],
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);
    }
  }

  Future<List<Map<String, dynamic>>> getYears() async {
    final db = await database;
    return await db.query("yearTable");
  }

  // Future<List<Map<String, dynamic>>> getSubstations() async {
  //   final db = await database;
  //   return await db.query("substationTable");
  // }
  Future<List<Map<String, dynamic>>> getSubstations(String year) async {
    final db = await database;

    // Print total rows in substationTable
    // final allRows = await db.query("substationTable");
    // print("Total Substations in DB: ${allRows.length}");
    final count = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM substationTable"),
    );
    print("Total Substations in DB: $count");

    final result = await db.query(
      "substationTable",
      where: "year = ?",
      whereArgs: [year],
    );

    print("Substations for year $year : ${result.length}");

    return result;
  }

  // Future<List<Map<String, dynamic>>> getFeeders() async {
  //   final db = await database;
  //   return await db.query("feederTable");
  // }
  Future<List<Map<String, dynamic>>> getFeeders(String substation) async {
    final db = await database;

    return await db.query(
      "feederTable",
      where: "substation = ?",
      whereArgs: [substation],
    );
  }

  ///////////
  Future<void> fetchAndSaveContractors() async {
    final db = await database;

    final url =
        "${AppUrl.baseUrl}login_user/getAllContractors";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      final List<dynamic> contractorList =
          jsonData["findAllContractorList"] ?? [];

      Batch batch = db.batch();

      // Delete old data
      batch.delete("contractorTable");

      // Insert new data
      for (var item in contractorList) {
        batch.insert("contractorTable", {
          "contractorId": item["id"],
          "fName": item["fName"],
          "lName": item["lName"],
          "supervisorId": item["SupervisorId"],
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);
    }
  }

  Future<List<Map<String, dynamic>>> getContractors() async {
    final db = await database;
    return await db.query("contractorTable");
  }

  /////////////////////////
  Future<void> fetchAndSaveMessages(String lineId) async {
    final db = await database;

    final url =
        "${AppUrl.baseUrl}login_user/getChatHistory?oId=$lineId";
    print('chat url $url');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);

      // Generate fetchId for this download
      final int fetchId = DateTime.now().millisecondsSinceEpoch;

      Batch batch = db.batch();

      // Delete old messages for this line
      batch.delete(
        "messageTable",
        where: "lineId = ? AND status = ?",
        whereArgs: [lineId, 1],
      );

      for (var item in jsonData) {
        batch.insert("messageTable", {
          "lineId": item["lineId"] ?? "",
          "createdDate": item["createdDate"] ?? "",
          "messageType": item["messageType"] ?? "",
          "description": item["description"] ?? "",
          "userName": item["userName"] ?? "",
          "userId": item["userId"] ?? "",
          "status": 1,
          "fetchId": fetchId,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);
      //await deleteOldMessageFetches(keepLatest: 10);
    } else {
      throw Exception("Failed to load messages");
    }
  }

  Future<List<Map<String, dynamic>>> getMessages(String lineId) async {
    final db = await database;

    return await db.query(
      "messageTable",
      where: "lineId = ?",
      whereArgs: [lineId],
      orderBy: "createdDate DESC",
    );
  }

  // Future<void> close() async {
  //   final db = await database;
  //   db.close();
  // }
  ////////////////////
  Future<void> fetchAndSaveCommentHistory(String mapLocation) async {
    final db = await database;

    final url =
        "${AppUrl.baseUrl}login_user/getCommentHistory?mapLocation=$mapLocation";

    print("Comment History URL: $url");

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        final int fetchId = DateTime.now().millisecondsSinceEpoch;

        final Batch batch = db.batch();

        // Delete old records for this mapLocation
        batch.delete(
          "commentHistoryTable",
          where: "mapLocation = ? AND status = ?",
          whereArgs: [mapLocation, 1],
        );

        for (final item in jsonData) {
          batch.insert("commentHistoryTable", {
            "id": item["id"] ?? 0,
            "comment": item["comment"] ?? "",
            "userName": item["userName"] ?? "",
            "userId": item["userId"]?.toString() ?? "",
            "mapLocation": item["mapLocation"]?.toString() ?? mapLocation,
            "flag":"1",
            //item["flag"] ?? "",
            "status": 1,
            "fetchId": fetchId,
          }, conflictAlgorithm: ConflictAlgorithm.replace);
        }

        await batch.commit(noResult: true);

        print("Comment history saved successfully: ${jsonData.length} records");
      } else {
        throw Exception(
          "Failed to load comment history. Status: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error fetching comment history: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getCommentHistory(
    String mapLocation,
  ) async {
    final db = await database;

    return await db.query(
      "commentHistoryTable",
      where: "mapLocation = ?",
      whereArgs: [mapLocation],
      orderBy: "id DESC",
    );
  }

  /////////////////////
  Future<void> fetchAndSaveReworkHistory(
    String token,
    String id,
    String jobNo,
  ) async {
    final db = await database;

    final url =
        "${AppUrl.baseUrl}login_user/getCrewReworkData?loginId=$id&tokenNo=$jobNo";

    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final int fetchId = DateTime.now().millisecondsSinceEpoch;

      final List<dynamic> jsonData = jsonDecode(response.body);

      Batch batch = db.batch();

      // Remove this if you want to keep old records
      // batch.delete("reworkHistoryTable");

      for (var item in jsonData) {
        batch.insert("reworkHistoryTable", {
          "id": item["ID"],

          "loginId": item["login_id"] ?? "",

          "lineId": item["LINE_ID"] ?? "",

          "maintType": item["MAINT_TYPE"] ?? "",

          "contractorTime": item["CONTRACTOR_TIME"] ?? "",

          "spanName": item["SPAN_NAME"] ?? "",

          "supervisorTime": item["SUPERVISOR_TIME"] ?? "",

          "adminTime": item["ADMIN_TIME"] ?? "",

          "status": item["status"].toString(),

          "username": item["username"] ?? "",

          "geometry": item["GEOMETRY"] ?? "",

          "fetchId": fetchId,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);

      await deleteOldReworkFetches(keepLatest: 10);
    }
  }

  Future<List<Map<String, dynamic>>> getReworkHistoryData() async {
    final db = await database;

    return await db.query("reworkHistoryTable", orderBy: "id DESC");
  }

  ///////////////////////
  Future<void> fetchAndSaveReworkDetails(String token, String jobNo) async {
    final db = await database;

    final url =
        "${AppUrl.baseUrl}login_user/getReworkList?token=$jobNo";

    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final int fetchId = DateTime.now().millisecondsSinceEpoch;

      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      final List<dynamic> reworkList = jsonData["reworkDetails"] ?? [];

      Batch batch = db.batch();

      // Clear old data
      batch.delete("reworkDetailsTable");
      for (var item in reworkList) {
        batch.insert("reworkDetailsTable", {
          "dateTime": item["dateTime"] ?? "",
          "substationName": item["substationName"] ?? "",
          "maintType": item["maintType"] ?? "",
          "jobNo": item["jobNo"] ?? "",
          "crewId": item["crewId"] ?? "",
          "crewName": item["crewName"] ?? "",
          "geometry": item["geometry"] ?? "",
          "feederName": item["feederName"] ?? "",
          "spanName": item["spanName"] ?? "",
          "status": item["status"] ?? "",
          "fetchId": fetchId,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);

      await deleteOldReworkDetailsFetches(keepLatest: 10);
    }
  }

  Future<List<Map<String, dynamic>>> getReworkDetailsData() async {
    final db = await database;

    return await db.query("reworkDetailsTable", orderBy: "dateTime DESC");
  }

  ///////////////////
  Future<void> fetchAndSaveInspectionList(String token, String jobNo) async {
    final db = await database;

    final url =
        "${AppUrl.baseUrl}login_user/getInspectionFaildList?token=$jobNo";

    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final int fetchId = DateTime.now().millisecondsSinceEpoch;

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> inspectionList = jsonData["reworkDetails"] ?? [];

      Batch batch = db.batch();
      batch.delete("inspectionListTable");
      for (var item in inspectionList) {
        batch.insert("inspectionListTable", {
          "dateTime": item["dateTime"] ?? "",
          "substationName": item["substationName"] ?? "",
          "maintType": item["maintType"] ?? "",
          "jobNo": item["jobNo"] ?? "",
          "crewId": item["crewId"] ?? "",
          "crewName": item["crewName"] ?? "",
          "geometry": item["geometry"] ?? "",
          "feederName": item["feederName"] ?? "",
          "spanName": item["spanName"] ?? "",
          "status": item["status"] ?? "",
          "fetchId": fetchId,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);

      await deleteOldInspectionListFetches(keepLatest: 10);
    } else {
      throw Exception("Failed to fetch inspection list");
    }
  }

  Future<List<Map<String, dynamic>>> getInspectionListData() async {
    final db = await database;

    return await db.query("inspectionListTable", orderBy: "dateTime DESC");
  }

  //////////////
  Future<void> fetchAndSaveCrew(String maintType) async {
    final db = await database;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final uri = Uri.parse(
      "${AppUrl.baseUrl}/maintenanceReportView/getCrewBySpanName",
    ).replace(queryParameters: {"maintType": maintType});

    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      final List<dynamic> crewList = jsonData["crewList"] ?? [];

      Batch batch = db.batch();

      // Delete previous crews for this maint type
      batch.delete("crewTable", where: "maintType=?", whereArgs: [maintType]);

      for (var item in crewList) {
        batch.insert("crewTable", {
          "id": item["id"],
          "maintType": maintType,
          "crewType": item["crewType"],
          "name": item["name"],
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);
    }
  }

  Future<List<Map<String, dynamic>>> getCrewList(String maintType) async {
    final db = await database;

    return await db.query(
      "crewTable",
      where: "maintType=?",
      whereArgs: [maintType],
    );
  }

  ///save offline methods---------------------
  Future<void> saveOfflineMapData(List<Map<String, dynamic>> data) async {
    final db = await database;

    Batch batch = db.batch();

    for (var item in data) {
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
          "jobNo": item["jobNo"],
          "createDate": formatDateTime(DateTime.now()),
          "status": 0,

          // "maintType": item["maintType"],
          // "jobNo": item["jobNo"],
          // "status": 0,
        },
        where: "oId = ?",
        whereArgs: [item["oId"]],
      );
      print("Saving OID: ${item["oId"]}");
      print("Saving MaintType: ${item["maintType"]}");
    }

    await batch.commit(noResult: true);
    // Print the updated rows
    for (var item in data) {
      final rows = await db.query(
        "overHeadTable",
        where: "oId = ?",
        whereArgs: [item["oId"]],
      );
      print(rows);
      if (rows.isNotEmpty) {
        print("Updated Row: ${rows.first}");
      } else {
        print("No row found for oId: ${item["oId"]}");
      }
    }
  }

  Future<List<Map<String, dynamic>>> getPendingMapData() async {
    final db = await database;

    return await db.query(
      "overHeadTable",
      columns: [
        "createdById",
        "contractorId",
        "substationId",
        "feederName",
        "totalMiles",
        "maintType",
        "wkt",
        "elementName",
        "opacity",
        "spanDistance",
        "oId",
        "jobNo",
      ],
      where: "status=?",
      whereArgs: [0],
    );
  }

  Future<int> syncPendingMapData() async {
    print("========== Map Sync Started ==========");
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity.contains(ConnectivityResult.none)) {
      print("No Internet");
      return 0;
    }

    print("Internet Available");
    final pending = await getPendingMapData();
    print("Pending Records Count: ${pending.length}");

    for (var row in pending) {
      print(const JsonEncoder.withIndent('  ').convert(row));
    }
    final requestBody = pending.map((row) {
      return {
        "createdById": row["createdById"],
        "contractorId": row["contractorId"],
        "substationId": row["substationId"],
        "feederName": row["feederName"],
        "totalMiles": row["totalMiles"],
        "maintType": row["maintType"],
        "wkt": row["wkt"],
        "elementName": row["elementName"],
        "opacity": row["opacity"],
        "spanDistance": row["spanDistance"],
        "oId": row["oId"],
        "jobNo": "",
      };
    }).toList();

    // print(jsonEncode(requestBody));
    // If there are no pending records
    if (pending.isEmpty) {
      print("No pending records found");
      return 0;
    }
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    int syncedCount = 0;
    final response = await http.post(
      Uri.parse("${AppUrl.baseUrl}login_user/createMap"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(requestBody),
      // body: jsonEncode(pending),
    );
    print("========== Request Body ==========");
    print(const JsonEncoder.withIndent("  ").convert(requestBody));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print("response from syncPendingMapData");
      print(const JsonEncoder.withIndent("  ").convert(responseData));
      final db = await database;

      Batch batch = db.batch();

      for (var item in pending) {
        batch.update(
          "overHeadTable",
          {"status": 1},
          where: "oId=?",
          whereArgs: [item["oId"]],
        );
        // Increment synced count
        syncedCount++;
      }

      await batch.commit(noResult: true);
      print("========== Map Sync Finished ==========");
      print("Synced Records: $syncedCount");
      return syncedCount;
    }
    print("Map Sync Failed. Status Code: ${response.statusCode}");
    return 0;
  }

  //////////////////////
  Future<void> saveOfflineMessage(Map<String, dynamic> message) async {
    final db = await database;
    print("===== Saving Offline Message =====");
    print(message);
    final id = await db.insert("messageTable", {
      "lineId": message["lineId"],
      "createdDate": DateTime.now().toIso8601String(),
      "messageType": "text",
      "description": message["description"],
      "userName": message["userName"],
      "userId": message["userId"],
      "status": 0, // pending
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    print("Inserted Row Id: $id");
  }

  Future<List<Map<String, dynamic>>> getPendingMessages() async {
    final db = await database;

    return await db.query(
      "messageTable",
      columns: [
        "id", // Needed to update status after sync
        "lineId",
        "description",
        "userId",
        "status",
      ],
      where: "status=?",
      whereArgs: [0],
    );
  }

  Future<int> syncPendingMessages() async {
    print("========== Message Sync Started ==========");

    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity.contains(ConnectivityResult.none)) {
      print("No Internet Connection");
      return 0;
    }

    print("Internet Available");

    final pending = await getPendingMessages();

    print("Pending Messages Count: ${pending.length}");

    if (pending.isEmpty) {
      print("No pending messages found.");
      return 0;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    final db = await database;

    int syncedCount = 0;

    for (var msg in pending) {
      final body = {
        "lineId": msg["lineId"],
        "description": msg["description"],
        "userId": msg["userId"],
      };

      print("--------------------------------------");
      print("Syncing Message ID : ${msg["id"]}");
      print("Request Body:");
      print(const JsonEncoder.withIndent("  ").convert(body));

      try {
        final response = await http.post(
          Uri.parse("${AppUrl.baseUrl}login_user/addChat"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode(body),
        );

        print("Status Code : ${response.statusCode}");
        print("Response : ${response.body}");

        if (response.statusCode == 200) {
          await db.update(
            "messageTable",
            {"status": 1},
            where: "id = ?",
            whereArgs: [msg["id"]],
          );

          print("Message Synced Successfully. ID: ${msg["id"]}");

          syncedCount++;
        } else {
          print("Failed to sync message ID ${msg["id"]}");
        }
      } catch (e) {
        print("Exception while syncing message ID ${msg["id"]}");
        print(e);
      }
    }

    print("========== Message Sync Finished ==========");
    print("Total Synced Messages: $syncedCount");

    return syncedCount;
  }

  //////////////////////////////
  Future<void> saveOfflineComment(Map<String, dynamic> comment) async {
    final db = await database;

    print("===== Saving Offline Comment =====");
    print(comment);

    final id = await db.insert("commentHistoryTable", {
      "comment": comment["comment"],
      "userName": comment["userName"],
      "userId": comment["userId"]?.toString() ?? "",
      "mapLocation": comment["mapLocation"]?.toString() ?? "",
      "status": 0, // Pending
      "fetchId": DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    print("Inserted Row Id: $id");
  }

  Future<List<Map<String, dynamic>>> getPendingComments() async {
    final db = await database;

    return await db.query(
      "commentHistoryTable",
      columns: ["id", "mapLocation", "comment", "userId", "status"],
      where: "status = ?",
      whereArgs: [0],
    );
  }

  Future<int> syncPendingComments() async {
    print("========== Comment Sync Started ==========");

    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity.contains(ConnectivityResult.none)) {
      print("No Internet Connection");
      return 0;
    }

    print("Internet Available");

    final pending = await getPendingComments();

    print("Pending Comments Count: ${pending.length}");

    if (pending.isEmpty) {
      print("No pending comments found.");
      return 0;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    final db = await database;

    int syncedCount = 0;

    for (var comment in pending) {
      final body = {
        "mapLocation": comment["mapLocation"],
        "description": comment["comment"],
        "userId": comment["userId"],
      };

      print("--------------------------------------");
      print("Syncing Comment ID : ${comment["id"]}");
      print("Request Body:");
      print(const JsonEncoder.withIndent("  ").convert(body));

      try {
        final response = await http.post(
          Uri.parse(
            "${AppUrl.baseUrl}login_user/addComment",
          ),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode(body),
        );

        print("Status Code : ${response.statusCode}");
        print("Response : ${response.body}");

        if (response.statusCode == 200) {
          await db.update(
            "commentHistoryTable",
            {"status": 1},
            where: "id = ?",
            whereArgs: [comment["id"]],
          );

          print("Comment Synced Successfully. ID: ${comment["id"]}");

          syncedCount++;
        } else {
          print("Failed to sync comment ID ${comment["id"]}");
        }
      } catch (e) {
        print("Exception while syncing comment ID ${comment["id"]}");
        print(e);
      }
    }

    print("========== Comment Sync Finished ==========");
    print("Total Synced Comments: $syncedCount");

    return syncedCount;
  }
Future<int> updateCommentHistoryFlag(
  String mapLocation,
  String flag,
) async {
  final db = await database;

  // 1. Update flag in commentHistoryTable
  final result = await db.update(
    'commentHistoryTable',
    {
      'flag': flag,
    },
    where: 'mapLocation = ?',
    whereArgs: [mapLocation],
  );

  // 2. Convert flag to hasComment value
  final String hasComment = flag == "1" ? "true" : "false";

  // 3. Update hasComment in consumerTable
  await db.update(
    'consumerTable',
    {
      'hasComment': hasComment,
    },
    where: 'mapLocation = ?',
    whereArgs: [mapLocation],
  );

  print(
    "Comment flag updated: mapLocation=$mapLocation, flag=$flag",
  );

  print(
    "Consumer hasComment updated: mapLocation=$mapLocation, hasComment=$hasComment",
  );

  return result;
}
  ///////////////////////////////////////////
  Future<void> saveOfflineMarkAsRead(List<Map<String, dynamic>> lines) async {
    final db = await database;

    // final Map<int, List<Map<String, dynamic>>> grouped = {};

    // for (final item in lines) {
    //   final int mapId = item["mapId"];
    //   grouped.putIfAbsent(mapId, () => []).add(item);
    // }
    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (final item in lines) {
      final String mapId = item["mapId"].toString();
      grouped.putIfAbsent(mapId, () => []).add(item);
    }
    Batch batch = db.batch();

    grouped.forEach((mapId, items) {
      batch.update(
        "overHeadTable",
        {
          "coordinateIds": items.map((e) => e["parentFeatureId"]).join(","),

          "assignedCrewId": items.map((e) => e["crewId"]).join(","),

          "maintType": items.map((e) => e["maintTypes"]).join(","),

          "maintStatus": List.filled(items.length, "Pending").join(","),

          "jobNo": items.first["tokenNo"].toString(),

          "completionStatus": 0,
        },
        where: "oId=?",
        whereArgs: [int.parse(mapId)],
        // whereArgs: [mapId],
      );
    });

    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getPendingMarkAsRead() async {
    final db = await database;

    return db.query(
      "overHeadTable",
      columns: ["oId", "coordinateIds", "assignedCrewId", "maintType", "jobNo"],
      where: "completionStatus=?",
      whereArgs: [0],
    );
  }

  Future<int> syncPendingMarkAsRead() async {
    print("========== Mark As Read Sync ==========");

    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity.contains(ConnectivityResult.none)) {
      print("No Internet");
      return 0;
    }

    final pending = await getPendingMarkAsRead();

    List<Map<String, String>> requestBody = [];
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";
    for (final row in pending) {
      final coordinateIds = row["coordinateIds"].toString().split(",");

      final crewIds = row["assignedCrewId"].toString().split(",");

      final maintTypes = row["maintType"].toString().split(",");

      final tokenNo = row["jobNo"].toString();

      for (int i = 0; i < coordinateIds.length; i++) {
        requestBody.add({
          "mapId": row["oId"].toString(),
          "crewId": crewIds[i].trim(),
          "parentFeatureId": coordinateIds[i].trim(),
          "maintTypes": maintTypes[i].trim(),
          "tokenNo": tokenNo,
        });
      }
    }
    final body = {"lines": requestBody};
    print("offline requestBody ${jsonEncode(requestBody)}");

    final response = await http.post(
      Uri.parse(
        "${AppUrl.baseUrl}login_user/updateCompletionFlag",
      ),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );
    print('response.statusCode ${response.statusCode}');
    if (response.statusCode == 200) {
      final db = await database;

      Batch batch = db.batch();

      for (var item in pending) {
        batch.update(
          "overHeadTable",
          {"completionStatus": 1},
          where: "oId=?",
          whereArgs: [item["oId"]],
        );
      }

      await batch.commit(noResult: true);

      print("Mark As Read Sync Completed");

      return pending.length;
    }

    print("Sync Failed");

    return 0;
  }

  // Future<void> updateMarkAsReadData(List<Map<String, dynamic>> lines) async {
  //   final db = await database;

  //   // Group by mapId (oId)
  //   final Map<int, List<Map<String, dynamic>>> grouped = {};

  //   for (final item in lines) {
  //     final int oId = item["mapId"];
  //     grouped.putIfAbsent(oId, () => []).add(item);
  //   }

  //   Batch batch = db.batch();

  //   grouped.forEach((oId, items) {
  //     final coordinateIds = items
  //         .map((e) => e["parentFeatureId"].toString())
  //         .join(",");

  //     final maintType = items.map((e) => e["maintType"].toString()).join(",");

  //     final maintStatus = items
  //         .map((e) => e["maintStatus"].toString())
  //         .join(",");

  //     batch.update(
  //       "overHeadTable",
  //       {
  //         "coordinateIds": coordinateIds,
  //         "maintType": maintType,
  //         "maintStatus": maintStatus,
  //         "completionStatus": 1,
  //       },
  //       where: "oId = ?",
  //       whereArgs: [oId],
  //     );
  //   });

  //   await batch.commit(noResult: true);
  // }

  //////////////////////
  Future<void> saveOfflineChangeOrder(
    Map<String, dynamic> data,
    // List<String> imagePaths,
  ) async {
    final db = await database;

    await db.insert('changeOrderTable', {
      "oid": data["oid"],
      "userId": data["userId"],
      "substation": data["substation"],
      "feeder": data["feeder"],
      "assignCrewType": data["assignCrewType"],
      "spanName": data["spanName"],
      "distance": data["distance"],
      "estTime": data["estTime"],
      "year": data["year"],
      "chatMsg": data["chatMsg"],
      // "imagePaths": jsonEncode(imagePaths), // Store image paths as JSON
      "status": 0,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getPendingChangeOrders() async {
    final db = await database;

    return await db.query(
      'changeOrderTable',
      where: 'status = ?',
      whereArgs: [0],
      orderBy: 'createdAt ASC',
    );
  }

  Future<void> syncPendingChangeOrder() async {
    final db = await DatabaseHelper.instance.database;

    final pendingOrders = await db.query(
      'changeOrderTable',
      where: 'status = ?',
      whereArgs: [0],
    );

    if (pendingOrders.isEmpty) {
      print("No pending Change Orders to sync.");
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";
    for (final order in pendingOrders) {
      try {
        final body = {
          "oid": order["oid"],
          "userId": order["userId"],
          "substation": order["substation"],
          "feeder": order["feeder"],
          "assignCrewType": order["assignCrewType"],
          "spanName": order["spanName"],
          "distance": order["distance"],
          "estTime": order["estTime"],
          "year": order["year"],
          "chatMsg": order["chatMsg"],
        };

        print("========== Sync Change Order ==========");
        print("sync pending change Order Body ${jsonEncode(body)}");

        final response = await http.post(
          Uri.parse(
            "${AppUrl.baseUrl}login_user/createChangeOrder",
          ),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode(body),
        );

        print("Status Code : ${response.statusCode}");
        print("Response : ${response.body}");

        if (response.statusCode == 200) {
          // Mark as synced
          await db.update(
            "changeOrderTable",
            {"status": 1},
            where: "id = ?",
            whereArgs: [order["id"]],
          );

          print("Change Order ${order["id"]} synced successfully.");
          // After syncing all pending records
          await DatabaseHelper.instance.deleteOldSyncedChangeOrders();
        }
      } catch (e) {
        print("Error syncing Change Order ${order["id"]}: $e");
      }
    }
  }

  /////////////////////////////////
  Future<void> saveOfflineReworkCompleted(
    List<Map<String, dynamic>> mapData,
  ) async {
    final db = await database;

    Batch batch = db.batch();

    for (final item in mapData) {
      batch.insert("reworkCompletedTable", {
        "lineId": item["lineId"].toString(),
        "crewId": item["crewId"].toString(),
        "maintType": item["maintType"].toString(),
        "status": item["status"].toString(), // REWORK / COMPLETED
        "tokenNo": item["tokenNo"].toString(),
        "userId": item["userId"].toString(),
        "syncStatus": 0,
        "createdAt": DateTime.now().millisecondsSinceEpoch,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getPendingReworkCompleted() async {
    final db = await database;

    return await db.query(
      "reworkCompletedTable",
      where: "syncStatus=?",
      whereArgs: [0],
      orderBy: "createdAt ASC",
    );
  }

  Future<int> syncPendingReworkCompleted() async {
    print("========== Rework/Completed Sync ==========");

    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity.contains(ConnectivityResult.none)) {
      print("No Internet");
      return 0;
    }

    final pending = await getPendingReworkCompleted();

    if (pending.isEmpty) {
      print("Nothing to sync");
      return 0;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    List<Map<String, dynamic>> requestBody = [];

    for (final row in pending) {
      requestBody.add({
        "status": row["status"],
        "tokenNo": row["tokenNo"],
        "userId": row["userId"],
        "lineId": row["lineId"],
        "crewId": row["crewId"],
        "maintType": row["maintType"],
      });
    }

    print("sync reworkcompleted ${jsonEncode(requestBody)}");

    final response = await http.post(
      Uri.parse(
        "${AppUrl.baseUrl}login_user/updateJobStatus",
      ),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(requestBody),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      final db = await database;

      Batch batch = db.batch();

      for (final row in pending) {
        batch.update(
          "reworkCompletedTable",
          {"syncStatus": 1},
          where: "id=?",
          whereArgs: [row["id"]],
        );
      }

      await batch.commit(noResult: true);
      // Delete old synced records (keep latest 10 if using that method)
      await deleteOldSyncedReworkCompleted();

      print("Rework/Completed Sync Successful");

      return pending.length;
    }

    print("Rework/Completed Sync Failed");

    return 0;
  }

  ///
  //delete methods-------------------------------------------
  Future<void> deleteOldFetches({int keepLatest = 10}) async {
    final db = await database;

    final result = await db.rawQuery("""
    SELECT DISTINCT fetchId
    FROM overHeadTable
    ORDER BY fetchId DESC
  """);

    print("All FetchIds: $result");

    if (result.length <= keepLatest) {
      print("Nothing to delete");
      return;
    }

    final oldestFetchId = result[keepLatest - 1]["fetchId"] as int;

    print("Keeping FetchId >= $oldestFetchId");

    Batch batch = db.batch();

    batch.delete(
      "overHeadTable",
      where: "fetchId < ? AND status = ?",
      whereArgs: [oldestFetchId, 1],
      // where: "fetchId < ?",
      // whereArgs: [oldestFetchId],
    );
    batch.delete(
      "overHeadChangeOrderTable",
      where: "fetchId < ? AND status = ?",
      whereArgs: [oldestFetchId, 1],
      // where: "fetchId < ?",
      // whereArgs: [oldestFetchId],
    );
    batch.delete(
      "polesTable",
      where: "fetchId < ?",
      whereArgs: [oldestFetchId],
    );

    batch.delete(
      "consumerTable",
      where: "fetchId < ?",
      whereArgs: [oldestFetchId],
    );

    batch.delete(
      "underGroundTable",
      where: "fetchId < ?",
      whereArgs: [oldestFetchId],
    );

    batch.delete(
      "substationBoundaryTable",
      where: "fetchId < ?",
      whereArgs: [oldestFetchId],
    );

    await batch.commit(noResult: true);

    print("Old fetches deleted successfully");
  }

  Future<void> deleteOldMessageFetches({int keepLatest = 10}) async {
    final db = await database;

    final result = await db.rawQuery("""
    SELECT DISTINCT fetchId
    FROM messageTable
    WHERE fetchId IS NOT NULL
    ORDER BY fetchId DESC
  """);

    print("Message FetchIds: $result");

    if (result.length <= keepLatest) {
      print("No old message fetches to delete");
      return;
    }

    final oldestFetchId = result[keepLatest - 1]["fetchId"] as int;

    print("Keeping message fetchId >= $oldestFetchId");

    await db.delete(
      "messageTable",
      where: "fetchId < ? AND status = ?",
      whereArgs: [oldestFetchId, 1],
    );

    print("Old message fetches deleted successfully");
  }

  Future<void> deleteOldReworkFetches({int keepLatest = 10}) async {
    final db = await database;

    final fetches = await db.rawQuery('''
      SELECT DISTINCT fetchId
      FROM reworkHistoryTable
      ORDER BY fetchId DESC
  ''');

    if (fetches.length <= keepLatest) return;

    final idsToDelete = fetches
        .skip(keepLatest)
        .map((e) => e["fetchId"])
        .toList();

    for (final id in idsToDelete) {
      await db.delete(
        "reworkHistoryTable",
        where: "fetchId = ?",
        whereArgs: [id],
      );
    }
  }

  Future<void> deleteOldSyncedChangeOrders({int keepLatest = 10}) async {
    final db = await database;

    await db.rawDelete(
      '''
    DELETE FROM changeOrderTable
    WHERE status = 1
      AND id NOT IN (
        SELECT id
        FROM changeOrderTable
        WHERE status = 1
        ORDER BY createdAt DESC
        LIMIT ?
      )
  ''',
      [keepLatest],
    );
  }

  //  Future<void> deleteOldSyncedReworkCompleted() async {
  //   final db = await database;

  //   await db.delete(
  //     "reworkCompletedTable",
  //     where: "syncStatus=?",
  //     whereArgs: [1],
  //   );
  // }
  Future<void> deleteOldSyncedReworkCompleted() async {
    final db = await database;

    await db.delete(
      "reworkCompletedTable",
      where: '''
      syncStatus=1
      AND id NOT IN (
        SELECT id
        FROM reworkCompletedTable
        WHERE syncStatus=1
        ORDER BY createdAt DESC
        LIMIT 10
      )
    ''',
    );
  }

  Future<void> deleteOldReworkDetailsFetches({int keepLatest = 10}) async {
    final db = await database;

    final fetches = await db.rawQuery('''
    SELECT DISTINCT fetchId
    FROM reworkDetailsTable
    ORDER BY fetchId DESC
  ''');

    if (fetches.length <= keepLatest) return;

    final idsToDelete = fetches
        .skip(keepLatest)
        .map((e) => e["fetchId"])
        .toList();

    for (var fetchId in idsToDelete) {
      await db.delete(
        "reworkDetailsTable",
        where: "fetchId = ?",
        whereArgs: [fetchId],
      );
    }
  }

  Future<void> deleteOldInspectionListFetches({int keepLatest = 10}) async {
    final db = await database;

    final fetchIds = await db.rawQuery('''
    SELECT DISTINCT fetchId
    FROM inspectionListTable
    ORDER BY fetchId DESC
  ''');

    if (fetchIds.length <= keepLatest) return;

    final idsToDelete = fetchIds
        .skip(keepLatest)
        .map((e) => e["fetchId"])
        .toList();

    for (var fetchId in idsToDelete) {
      await db.delete(
        "inspectionListTable",
        where: "fetchId = ?",
        whereArgs: [fetchId],
      );
    }
  }

  ////////////
}
