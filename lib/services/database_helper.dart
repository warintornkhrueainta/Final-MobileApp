import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/movie.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {

    if(_database != null) return _database!;

    final path = join(await getDatabasesPath(),'movies.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db,version) async {

        await db.execute('''
        CREATE TABLE movies(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        genre TEXT,
        length INTEGER,
        status TEXT,
        rating REAL,
        note TEXT
        )
        ''');

      }
    );

    return _database!;
  }

  Future<List<Movie>> getMovies() async {

    final db = await instance.database;
    final result = await db.query('movies');

    return result.map((e)=>Movie.fromMap(e)).toList();
  }

  Future insertMovie(Movie movie) async {
    final db = await instance.database;
    await db.insert('movies', movie.toMap());
  }

  Future updateMovie(Movie movie) async {
    final db = await instance.database;

    await db.update(
      'movies',
      movie.toMap(),
      where: 'id=?',
      whereArgs: [movie.id],
    );
  }

  Future deleteMovie(int id) async {
    final db = await instance.database;

    await db.delete(
      'movies',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}