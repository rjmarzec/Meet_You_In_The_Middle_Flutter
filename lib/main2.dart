import 'package:flutter/material.dart';

import 'favoritesScreen2.dart';
import 'placesScreen2.dart';
import 'mapScreen2.dart';

const GooglePlacesApiKey = "AIzaSyB38vBKUFlmheuGFv67HdH92WWPO7OpQMs";

void main2()
{
	runApp(MainScreen());
}

class MainScreen extends StatefulWidget
{
	@override
	MainScreenState createState()
	=> MainScreenState();
}

class MainScreenState extends State<MainScreen>
{
	@override
	Widget build(BuildContext context)
	{
		return MaterialApp(
				home: new PlacesScreen()
		);
	}
}

class MainScreen2 extends StatelessWidget
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
							new FavoritesScreen(),
							new PlacesScreen(),
							new MapScreen(),
						],
					),
				),
			),
		);
	}
}
