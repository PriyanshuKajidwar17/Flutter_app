import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

//import 'package:flutter/material.dart';
import 'nevigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
      ),
      home: const MyHomePage(title: 'My App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<String> _images = [
    'assets/images/one-peace.jpg',
    'assets/images/Pri1.png',
    'assets/images/pri2.png',
    'assets/images/pri4.jpg',
  ];


  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  /*
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Go to Next Page',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NextPage(),
                ),
              );
            },
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,// doubt part when i comment out then also same result showing
        children: [
          const SizedBox(height: 30), // space from top

          const SizedBox(
            width: double.infinity,
            child: Text(
              'Buddy you have pushed button',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),//one-peace.jpg
            ),
          ),

          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          // Centered Image
          // Centered Image
          Expanded(
            child: Center(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                ),
                items: _images.map((imagePath) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),





          // Text(
          //   '$_counter',
          //   style: Theme.of(context).textTheme.headlineMedium,
          // ),
        ],
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
              onPressed: _counter == 0 ? null : _decrementCounter,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
