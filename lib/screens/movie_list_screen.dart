import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/movie.dart'; // ตรวจสอบ path นี้ให้ถูกต้อง
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'movie_detail_screen.dart'; 

class MovieListScreen extends StatefulWidget {
  final String? search;
  const MovieListScreen({super.key, this.search});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  String filterStatus = "ทั้งหมด";

  @override
  void initState() {
    super.initState();
    // โหลดข้อมูลจาก Database ทันทีเมื่อเปิดหน้า
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().loadMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("รายการหนัง / ซีรีส์", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade200,
        elevation: 0,
      ),
      body: Column(
        children: [
          /// SECTION: SEARCH + FILTER
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "ค้นหาชื่อเรื่อง...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) => provider.searchMovies(value),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: filterStatus,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: ['ทั้งหมด', 'อยากดู', 'กำลังดู', 'ดูจบ']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status, style: const TextStyle(fontSize: 14)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => filterStatus = value);
                        provider.filterByStatus(value);
                      }
                    },
                  ),
                )
              ],
            ),
          ),

          /// SECTION: MOVIE LIST
          Expanded(
            child: provider.movies.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: provider.movies.length,
                    itemBuilder: (context, index) {
                      final movie = provider.movies[index];
                      return _buildMovieItem(context, provider, movie);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                movie: Movie(
                  id: null,
                  title: '',
                  type: 'Movie',
                  status: 'อยากดู',
                  rating: 0.0,
                  note: '',
                  // ปรับตาม Model: ถ้า episodes ต้องเป็น int ให้ใส่ 0 แทน null
                  episodes: 0, 
                  category: 'ทั่วไป', // เพิ่ม category ถ้าใน model กำหนดไว้
                ),
              ),
            ),
          );
        },
        label: const Text("เพิ่มเรื่องใหม่"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue.shade700,
      ),
    );
  }

  // --- Widget ตัวช่วยสร้าง UI (Helper Widgets) ---

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.movie_filter, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 10),
          Text("ไม่พบรายการข้อมูล", style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildMovieItem(BuildContext context, MovieProvider provider, Movie movie) {
    return Dismissible(
      key: Key(movie.id.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("ยืนยันการลบ"),
            content: Text("คุณต้องการลบเรื่อง '${movie.title}' ใช่หรือไม่?"),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("ยกเลิก")),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("ลบ", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        provider.deleteMovie(movie.id!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ลบ "${movie.title}" เรียบร้อยแล้ว')),
        );
      },
      background: Container(
        color: Colors.red.shade400,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete_sweep, color: Colors.white, size: 30),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: const Icon(Icons.movie, color: Colors.blue),
          ),
          title: Text(movie.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("หมวดหมู่: ${movie.type}\nสถานะ: ${movie.status}"),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              Text(movie.rating > 0 ? movie.rating.toStringAsFixed(1) : "-"),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie)),
            );
          },
        ),
      ),
    );
  }
}