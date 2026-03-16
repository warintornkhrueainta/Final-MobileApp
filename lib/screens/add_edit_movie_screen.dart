import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'movie_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  String search = "";

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<MovieProvider>(context);

    int total = provider.movies.length;

    int watching =
        provider.movies.where((m)=>m.status=="กำลังดู").length;

    int finished =
        provider.movies.where((m)=>m.status=="ดูจบแล้ว").length;

    int plan =
        provider.movies.where((m)=>m.status=="อยากดู").length;

    return Scaffold(

      appBar: AppBar(
        title: Text("Movie Dashboard"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [

            /// SEARCH
            TextField(
              decoration: InputDecoration(
                hintText: "Search movie...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              onChanged: (value){
                setState(() {
                  search = value;
                });
              },
            ),

            SizedBox(height:20),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,

              children: [

                dashboardCard("ทั้งหมด", total, Icons.movie, Colors.blue),

                dashboardCard("กำลังดู", watching, Icons.visibility, Colors.orange),

                dashboardCard("ดูจบแล้ว", finished, Icons.check_circle, Colors.green),

                dashboardCard("อยากดู", plan, Icons.bookmark, Colors.purple),

              ],
            ),

            SizedBox(height:20),

            ElevatedButton.icon(

              icon: Icon(Icons.list),
              label: Text("Open Movie List"),

              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieListScreen(
                      search: search,
                    ),
                  ),
                );
              },
            )

          ],
        ),
      ),
    );
  }

  Widget dashboardCard(
      String title,
      int value,
      IconData icon,
      Color color
      ){

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Icon(icon,size:40,color:color),

          SizedBox(height:10),

          Text(
            value.toString(),
            style: TextStyle(
              fontSize:22,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(title)

        ],
      ),
    );
  }
}