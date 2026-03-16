import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/movie_provider.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  MovieDetailScreen({required this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _typeController;
  late TextEditingController _statusController;
  late TextEditingController _ratingController;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.movie.title);
    _typeController = TextEditingController(text: widget.movie.type);
    _statusController = TextEditingController(text: widget.movie.status);
    _ratingController = TextEditingController(text: widget.movie.rating.toString());
    _noteController = TextEditingController(text: widget.movie.note);
  }

  void _saveMovie() {
    // อัปเดตข้อมูลใน Object
    widget.movie.title = _titleController.text;
    widget.movie.type = _typeController.text;
    widget.movie.status = _statusController.text;
    widget.movie.rating = double.tryParse(_ratingController.text) ?? 0.0;
    widget.movie.note = _noteController.text;

    final provider = Provider.of<MovieProvider>(context, listen: false);

    if (widget.movie.id == null) {
      provider.addMovie(widget.movie); // ถ้าไม่มี ID ให้เพิ่มใหม่
    } else {
      provider.updateMovie(widget.movie); // ถ้ามี ID ให้แก้ไข
    }

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('บันทึกสำเร็จ')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movie.id == null ? "เพิ่มเรื่องใหม่" : "แก้ไขข้อมูล")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: "ชื่อเรื่อง")),
            TextField(controller: _typeController, decoration: InputDecoration(labelText: "ประเภท")),
            TextField(controller: _statusController, decoration: InputDecoration(labelText: "สถานะ")),
            TextField(controller: _ratingController, decoration: InputDecoration(labelText: "คะแนน"), keyboardType: TextInputType.number),
            TextField(controller: _noteController, decoration: InputDecoration(labelText: "บันทึก"), maxLines: 3),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveMovie, child: Text("บันทึกข้อมูล"), style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50))),
          ],
        ),
      ),
    );
  }
}