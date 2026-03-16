import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/database_helper.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _allMovies = [];
  List<Movie> _filteredMovies = [];

  List<Movie> get movies => _filteredMovies;

  Future<void> loadMovies() async {
    _allMovies = await DatabaseHelper.instance.getMovies();
    _filteredMovies = _allMovies;
    notifyListeners();
  }

  Future<void> addMovie(Movie movie) async {
    await DatabaseHelper.instance.insertMovie(movie);
    await loadMovies();
  }

  Future<void> updateMovie(Movie movie) async {
    await DatabaseHelper.instance.updateMovie(movie);
    await loadMovies();
  }

  Future<void> deleteMovie(int id) async {
    await DatabaseHelper.instance.deleteMovie(id);
    await loadMovies();
  }

  void searchMovies(String query) {
    _filteredMovies = _allMovies.where((m) => m.title.toLowerCase().contains(query.toLowerCase())).toList();
    notifyListeners();
  }

  void filterByStatus(String status) {
    _filteredMovies = (status == "ทั้งหมด") ? _allMovies : _allMovies.where((m) => m.status == status).toList();
    notifyListeners();
  }

  // Dashboard Stats
  int get total => _allMovies.length;
  int get watched => _allMovies.where((e) => e.status == "ดูจบ").length;
  int get watching => _allMovies.where((e) => e.status == "กำลังดู").length;
  int get plan => _allMovies.where((e) => e.status == "อยากดู").length;
}