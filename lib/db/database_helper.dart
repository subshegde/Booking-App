// import 'dart:async';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   DatabaseHelper._internal();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'user_database.db');
//     return await openDatabase(
//       path,
//       version: 2,
//       onCreate: (db, version) {
//         return db.execute('''
//           CREATE TABLE users(
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             fullName TEXT,
//             photo TEXT,
//             gender TEXT,
//             username TEXT UNIQUE,
//             address TEXT,
//             email TEXT UNIQUE,
//             phone TEXT,  -- Added phone column
//             password TEXT,
//             role TEXT DEFAULT 'normal'
//           )
//         ''');
//       },
//       onUpgrade: (db, oldVersion, newVersion) async {
//         if (oldVersion < 2) {
//           await db.execute('ALTER TABLE users ADD COLUMN phone TEXT');
//         }
//       },
//     );
//   }

//   Future<int> insertUser(Map<String, dynamic> user) async {
//   final db = await database;

//   String email = user['email'];
//   String role = email.contains('admin.com') ? 'admin' : 'normal';

//   user['role'] = role;
//   return await db.insert('users', user);
// }

//   Future<Map<String, dynamic>?> getUser(String usernameOrEmail, String password) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'users',
//       where: '(username = ? OR email = ?) AND password = ?',
//       whereArgs: [usernameOrEmail, usernameOrEmail, password],
//     );

//     if (maps.isNotEmpty) {
//       return maps.first;
//     }
//     return null;
//   }

//  Future<bool> doesEmailOrUsernameExist(String value) async {
//   final db = await database;
//   final result = await db.query(
//     'users',
//     where: 'email = ? OR username = ?',
//     whereArgs: [value, value],
//   );
//   return result.isNotEmpty;
// }

//   Future<Map<String, dynamic>?> verifyUserCredentials(String email, String password) async {
//     final db = await database;
//     final result = await db.query(
//       'users',
//       where: 'email = ? AND password = ?',
//       whereArgs: [email, password],
//     );

//     if (result.isNotEmpty) {
//       return result.first;
//     } else {
//       return null;
//     }
//   }

//  Future<bool> updateProfileImageInDB(String? photo, String? username) async {
//   final db = await database;

//   try {
//     int count = await db.update(
//       'users',
//       {'photo': photo},
//       where: 'username = ?',
//       whereArgs: [username],
//     );

//     return count > 0;
//   } catch (e) {
//     print('Error updating profile image: $e');
//     return false;
//   }
// }

// }
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
    return await openDatabase(path, version: 5, onCreate: (db, version) {
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
    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 5) {
        // Check if hotelbookings table exists
        final result = await db.rawQuery(
            "SELECT name FROM sqlite_master WHERE type='table' AND name='hotelbookings'");
        if (result.isEmpty) {
          // Create the table if it doesn't exist
          await db.execute('''
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
        } else {
          // Add missing columns if not present
          await db.execute('''
        ALTER TABLE hotelbookings ADD COLUMN isPaymentDone INTEGER DEFAULT 0
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

  // Insert Booking
  Future<int> insertBooking(Map<String, dynamic> booking) async {
    final db = await database;
    try {
      return await db.insert('hotelbookings', booking);
    } catch (e) {
      print('Error inserting booking: $e');
      return -1; // Return -1 if insertion fails
    }
  }

// Database Helper - Get Bookings by User ID
  Future<List<Map<String, dynamic>>> getAllBookings(int userId) async {
    final db = await database;
    return await db.query(
      'hotelbookings',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  // Remove Booking by ID
  Future<int> removeBookingById(int id) async {
    final db = await database;
    return await db.delete('hotelbookings', where: 'id = ?', whereArgs: [id]);
  }

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
