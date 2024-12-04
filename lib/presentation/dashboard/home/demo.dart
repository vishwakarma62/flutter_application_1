import 'package:flutter/material.dart';


class ReorderLisst extends StatefulWidget {


ReorderLisst({Key? key}) : super(key: key);
@override
_ReorderLisstState createState() => _ReorderLisstState();
}

class _ReorderLisstState extends State<ReorderLisst> {
// list of items that are needed
// to the reorderlistview widget.
List<String> item = [
	"GeeksforGeeks",
	"Flutter",
	"Developer",
	"Android",
	"Programming",
	"CplusPlus",
	"Python",
	"javascript"
];

// this method sort the item.
void sorting() {
	setState(() {
	item.sort();
	});
}

// This method set the new index to the element.
void reorderData(int oldindex, int newindex) {
	setState(() {
	if (newindex > oldindex) {
		newindex -= 1;
	}
	final items = item.removeAt(oldindex);
		item.insert(newindex, items);
	});
}

@override
Widget build(BuildContext context) {
	// materialApp with 
	// debugShowCheckedModeBanner false and home
	return MaterialApp( 
	debugShowCheckedModeBanner: false,
	home: Scaffold(
	backgroundColor: Colors.green[400],
	// appbar with title
	appBar: AppBar( 
		title: Text(
		"Reorderable ListView",
		
		),
	),
	// This widget creates the 
	// reorderable list of item.
	body: ReorderableListView( 
		onReorder: reorderData,
		children: [
		for (final items in item)
			Card(
			color: Colors.white,
			key: ValueKey(items),
			elevation: 2,
			child: ListTile(
				title: Text(items),
				
			),
			),
		],
		),
	)
	);
}
}
