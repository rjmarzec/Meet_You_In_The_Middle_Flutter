import 'package:flutter/material.dart';

//import 'favoritesScreen.dart';
import 'placesScreen.dart';
//import 'mapScreen.dart';

void main()
{
	runApp(MainScreen());
}

class MainScreen extends StatefulWidget
{
	@override
	_MainScreenState createState()
	=> _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
{
	@override
	Widget build(BuildContext context)
	{
		return MaterialApp(
			home: DefaultTabController(
				length: 3,
				initialIndex: 1,
				child: Scaffold(
					appBar: AppBar(
						bottom: TabBar(
							tabs: [
								Tab(icon: Icon(Icons.star)),
								Tab(icon: Icon(Icons.place)),
								Tab(icon: Icon(Icons.map)),
							],
						),
						title: Text('Meet You In The Middle'),
					),
					body: TabBarView(
						children: [
							new Icon(Icons.star),
							new PlacesScreen(),
							new Icon(Icons.map),
						],
					),
				),
			),
		);
	}
}
