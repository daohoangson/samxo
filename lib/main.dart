import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum Cell {
  dad,
  sam,
}

class _MyHomePageState extends State<MyHomePage> {
  final size = 3;
  late final List<Cell?> cells;

  Cell whosNext = Cell.sam;

  _MyHomePageState() {
    cells = List<Cell?>.filled(size * size, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Next: ${whosNext.name}'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  cells.fillRange(0, cells.length, null);
                  whosNext = Cell.sam;
                });
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: size,
          ),
          itemBuilder: (context, index) {
            final cell = cells[index];
            switch (cell) {
              case Cell.dad:
                return Image.asset('assets/dad.jpg');
              case Cell.sam:
                return Image.asset('assets/sam.jpg');
              default:
                return InkWell(
                  onTap: () {
                    setState(() {
                      cells[index] = whosNext;
                      whosNext = Cell.values.firstWhere((v) => v != whosNext);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                  ),
                );
            }
          },
          itemCount: cells.length,
        ));
  }
}
