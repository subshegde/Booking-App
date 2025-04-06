import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(path, version: 7, onCreate: (db, version) {
      // Create Users Table
      db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fullName TEXT,
            photo TEXT,
            gender TEXT,
            username TEXT UNIQUE,
            address TEXT,
            email TEXT UNIQUE,
            phone TEXT,
            password TEXT,
            role TEXT DEFAULT 'normal'
          )
        ''');
      // Create Hotel Bookings Table
      db.execute('''
          CREATE TABLE hotelbookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            gender TEXT,
            address TEXT,
            phone TEXT,
            email TEXT,
            numberOfPerson INTEGER,
            hotelId INTEGER,
            userId INTEGER,
            date TEXT,
            isPaymentDone INTEGER DEFAULT 0,
            totalPrice REAL,
            FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
          )
        ''');

        db.execute('''
          CREATE TABLE travelbookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            gender TEXT,
            address TEXT,
            phone TEXT,
            email TEXT,
            numberOfPerson INTEGER,
            travelId INTEGER,
            userId INTEGER,
            date TEXT,
            isPaymentDone INTEGER DEFAULT 0,
            totalPrice REAL,
            FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
          )
        ''');

         db.execute('''
          CREATE TABLE vehiclebookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            gender TEXT,
            address TEXT,
            phone TEXT,
            email TEXT,
            numberOfPerson INTEGER,
            vehicleId INTEGER,
            userId INTEGER,
            date TEXT,
            isPaymentDone INTEGER DEFAULT 0,
            totalPrice REAL,
            FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
          )
        ''');


    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 7) {
        // Check if vehiclebookings table exists
        final result = await db.rawQuery(
            "SELECT name FROM sqlite_master WHERE type='table' AND name='vehiclebookings'");
        if (result.isEmpty) {
          // Create the table if it doesn't exist
          await db.execute('''
        CREATE TABLE vehiclebookings (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          gender TEXT,
          address TEXT,
          phone TEXT,
          email TEXT,
          numberOfPerson INTEGER,
          vehicleId INTEGER,
          userId INTEGER,
          date TEXT,
          isPaymentDone INTEGER DEFAULT 0,
          totalPrice REAL,
          FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
        )
      ''');
        } 
      }
    });
  }

  // Insert User
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    String email = user['email'];
    String role = email.contains('admin.com') ? 'admin' : 'normal';
    user['role'] = role;
    return await db.insert('users', user);
  }
  // hotel bookings
  // Insert Booking
  Future<int> insertHotelBooking(Map<String, dynamic> booking) async {
    final db = await database;
    try {
      return await db.insert('hotelbookings', booking);
    } catch (e) {
      print('Error inserting booking: $e');
      return -1; // Return -1 if insertion fails
    }
  }

// Database Helper - Get Bookings by User ID
  Future<List<Map<String, dynamic>>> getAllHotelBookings(int userId) async {
    final db = await database;
    return await db.query(
      'hotelbookings',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  // Remove Booking by ID
  Future<int> removeHotelBookingById(int id) async {
    final db = await database;
    return await db.delete('hotelbookings', where: 'id = ?', whereArgs: [id]);
  }

  // Make payment as done
  Future<int> markPaymentAsDoneForHotelBooking({
    required int isPaymentDone,
    required int userId,
    required int hotelId,
    required int bookingId,
  }) async {
    final db = await database;

    try {
      return await db.update(
        'hotelbookings',
        {'isPaymentDone': isPaymentDone},
        where: 'id = ? AND userId = ? AND hotelId = ?',
        whereArgs: [bookingId, userId, hotelId],
      );
    } catch (e) {
      print('Error updating payment status: $e');
      return -1; // Return -1 if update fails
    }
  }

  // hotel booking completed----------------------------------------------

  // Travel Bookings
    // Insert Booking
  Future<int> insertTravelBooking(Map<String, dynamic> booking) async {
    final db = await database;
    try {
      return await db.insert('travelbookings', booking);
    } catch (e) {
      print('Error inserting booking: $e');
      return -1; // Return -1 if insertion fails
    }
  }

// Database Helper - Get Bookings by User ID
  Future<List<Map<String, dynamic>>> getAllTravelBookings(int userId) async {
    final db = await database;
    return await db.query(
      'travelbookings',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  // Remove Booking by ID
  Future<int> removeTravelBookingById(int id) async {
    final db = await database;
    return await db.delete('travelbookings', where: 'id = ?', whereArgs: [id]);
  }

  // Make payment as done
  Future<int> markPaymentAsDoneForTravelBooking({
    required int isPaymentDone,
    required int userId,
    required int travelId,
    required int bookingId,
  }) async {
    final db = await database;

    try {
      return await db.update(
        'travelbookings',
        {'isPaymentDone': isPaymentDone},
        where: 'id = ? AND userId = ? AND travelId = ?',
        whereArgs: [bookingId, userId, travelId],
      );
    } catch (e) {
      print('Error updating payment status: $e');
      return -1; // Return -1 if update fails
    }
  }
  // Travel booking completed----------------------------------------------

  // Vehicle Bookings
    // Insert Booking

    Future<int> insertVehicleBooking(Map<String, dynamic> booking) async {
    final db = await database;
    try {
      return await db.insert('vehiclebookings', booking);
    } catch (e) {
      print('Error inserting booking: $e');
      return -1; // Return -1 if insertion fails
    }
  }

// Database Helper - Get Bookings by User ID
  Future<List<Map<String, dynamic>>> getAllVehicleBookings(int userId) async {
    final db = await database;
    return await db.query(
      'vehiclebookings',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  // Remove Booking by ID
  Future<int> removeVehicleBookingById(int id) async {
    final db = await database;
    return await db.delete('vehiclebookings', where: 'id = ?', whereArgs: [id]);
  }

  // Make payment as done
  Future<int> markPaymentAsDoneForVehicleBooking({
    required int isPaymentDone,
    required int userId,
    required int vehicleId,
    required int bookingId,
  }) async {
    final db = await database;

    try {
      return await db.update(
        'vehiclebookings',
        {'isPaymentDone': isPaymentDone},
        where: 'id = ? AND userId = ? AND vehicleId = ?',
        whereArgs: [bookingId, userId, vehicleId],
      );
    } catch (e) {
      print('Error updating payment status: $e');
      return -1; // Return -1 if update fails
    }
  }
  // Vehicle booking completed----------------------------------------------

  // Verify User Credentials
  Future<Map<String, dynamic>?> verifyUserCredentials(
      String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  // Update Profile Image
  Future<bool> updateProfileImageInDB(String? photo, String? username) async {
    final db = await database;
    try {
      int count = await db.update(
        'users',
        {'photo': photo},
        where: 'username = ?',
        whereArgs: [username],
      );
      return count > 0;
    } catch (e) {
      print('Error updating profile image: $e');
      return false;
    }
  }

  // Check if Email or Username Exists
  Future<bool> doesEmailOrUsernameExist(String value) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? OR username = ?',
      whereArgs: [value, value],
    );
    return result.isNotEmpty;
  }
}
