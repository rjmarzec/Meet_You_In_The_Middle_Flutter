import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class PlacesScreen extends StatefulWidget
{
	@override
	_PlacesScreenState createState()
	=> _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen>
{
	String testText;

	@override
	void initState()
	{
		super.initState();

		testText = "test location 1;;test location 2";
	}

	@override
	Widget build(BuildContext context)
	{
		//Converts the stored location String to a list of widgets
		List<Widget> locationWidgetList = buildLocationListFromString(testText);
		addListLabelWidget(locationWidgetList);

		return new Scaffold(
			body: new Center(
					child: new ListView(
						children: locationWidgetList,
					)
			),
			floatingActionButton: new FloatingActionButton(
				onPressed: ()
				{
					setState(()
					{
						//testText += " adding more text;;";
					});
				},
				tooltip: 'Add Place',
				child: new Icon(Icons.add),
			),
		);
	}

	List<Widget> buildLocationListFromString(String inputString)
	{
		List<Widget> resultWidgetList = new List<Widget>();

		List<String> locationList = inputString.split(";;");

		//Cleans out any locations that are empty
		for(int i = 0; i < locationList.length; i ++)
		{

		}

		for(int i = 0; i < locationList.length; i ++)
		{
			resultWidgetList.add(new ListTile(
				leading: Icon(Icons.place),
				title: Text(locationList[i] + " (" + (i + 1).toString() + ")"),
				trailing: new FloatingActionButton(
					mini: true,
					onPressed: ()
					{
						//_removePlace(context, i + 1)
					},
					tooltip: 'Remove Location',
					child: new Icon(Icons.remove),
				),
			),);
		}

		return resultWidgetList;
	}

	void addListLabelWidget(List<Widget> inputList)
	{
		ListTile labelWidget = new ListTile(title: Text("Current Locations:"));
		inputList.insert(0, labelWidget);
	}
}
