import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListExample extends StatefulWidget {
  ShimmerListExample({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShimmerListExampleState createState() => _ShimmerListExampleState();
}

class _ShimmerListExampleState extends State<ShimmerListExample> {
  Future<List<String>> _future = Future.delayed(
    Duration(seconds: 3),
        () => List.generate(20, (i) => 'Item $i'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: FutureBuilder<List<String>>(
        future: _future,
        builder: (context, snapshot) {
          Widget child;

          if (snapshot.hasData) {
            child = ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Item(color: Colors.lightGreen);
              },
            );
          } else if (snapshot.hasError) {
            // Return an error message or retry button if it errors, not handled
            // for this example
          } else {
            child = ShimmerList();
          }

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: child,
          );
        },
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  final int itemCount;

  const ShimmerList({Key key, this.itemCount = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ShimmerItem();
      },
    );
  }
}

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Item(color: Colors.grey.shade300),
    );
  }
}

class Item extends StatelessWidget {
  final Color color;

  const Item({
    Key key,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 140,
            color: color,
            margin: EdgeInsets.only(bottom: 10),

            child : Text('1111')
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 8.0,
                  color: color,
                  margin: EdgeInsets.only(bottom: 5),
                  child : Text('22222')

                ),
                Container(
                  width: 40.0,
                  height: 8.0,
                  color: color,
                    child : Text('33333')
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}