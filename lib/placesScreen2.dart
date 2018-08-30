import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

const GooglePlacesApiKey = "AIzaSyB38vBKUFlmheuGFv67HdH92WWPO7OpQMs";

String storedLocations = "";
String enteredLocation = "";

class PlacesScreen extends StatefulWidget
{
	@override
	_PlacesScreenState createState()
	=> _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen>
{
	//List containing all locations as ListTiles
	List<Widget> widgetList = new List<Widget>();

	String storedLocationsString;
	//String storedLocationsString = "test1;;test2;;";

	@override
	void initState()
	{
		super.initState();

		storedLocationsString = "initCall";

		//Pulls the stored locations as a future and then stores the value of it for later use
		Future<String> storedLocationsFuture = _getStoredLocations();
		storedLocationsFuture.then((storedLocationsStringFromFuture) => storedLocationsString = storedLocationsStringFromFuture + "");

		//storedLocationsString = "test1;;test2;;";
	}

	@override
	Widget build(BuildContext context)
	{
		return new Scaffold(
			body: new Center(
					child: new ListTile(title: Text(storedLocationsString))
			),
			floatingActionButton: new FloatingActionButton(
				onPressed: ()
				//=> _addNewPlace(context),
				=> _tempAddLocationsToStorage,
				tooltip: 'Add Place',
				child: new Icon(Icons.add),
			),
		);
	}

	//The main build function of the class
	@override
	Widget build2(BuildContext context)
	{
		//TODO: There is probably a better way to do this, found here: https://stackoverflow.com/questions/50441168/iterating-through-a-list-to-render-multiple-widgets-in-flutter
		List<Widget> widgetList = new List<Widget>();

		widgetList.add(new ListTile(
				title: Text(storedLocationsString + "")));
				//title: Text("test")));

		/*
		//Adds a title to the list before doing anything
		widgetList.add(new ListTile(
			title: Text('Current Locations:'),
		));

		//Checks if the user has locations stored from either previous uses
		if (storedLocationsString != null && storedLocationsString.trim() != "")
		{
			//Splits storedLocationsString into a list so the widgets can be made easily
			List<String> locationsList = storedLocationsString.split(';;');

			//Goes through each location stored and converts it to a widget in a list
			for (int i = 0; i < locationsList.length; i++)
			{
				widgetList.add(new ListTile(
					leading: Icon(Icons.place),
					title: Text(locationsList[i]),
					trailing: new FloatingActionButton(
						mini: true,
						onPressed: ()
						//=> _tempAddLocationsToStorage,
						=> _removePlace(context, i + 1),
						tooltip: 'Remove Location',
						child: new Icon(Icons.remove),
					),
				),);
			}
		}
		else
		{
			widgetList.add(new ListTile(
					title: Text('No Locations found!\nAdd one using the button below.')));
		}
		*/

		//Once the locations are turned into widgets, they are formatted nicely into one place.
		return new Scaffold(
			body: new Center(
					child: new ListView(
							//children: widgetList
							children: <Widget>[new ListTile(title: Text(storedLocationsString))],
					)
			),
			floatingActionButton: new FloatingActionButton(
				onPressed: (){
					//_addNewPlace(context);
					_tempAddLocationsToStorage();
				},
				tooltip: 'Add Place',
				child: new Icon(Icons.add),
			),
		);
	}

	//Pulls the stored locations as a Future<String>
	Future<String> _getStoredLocations()
	async
	{
		SharedPreferences preferences = await SharedPreferences.getInstance();
		storedLocations = preferences.getString('locationsAsString');
		return storedLocations;
	}

	//Contains the code for the pop-up screen that appears when the button in the lower right is pressed
	Future<Null> _addNewPlace(context)
	{
		return showDialog<Null>(
			context: context,
			barrierDismissible: false, // user must tap button!
			builder: (BuildContext context)
			{
				return new AlertDialog(
					content: new SingleChildScrollView(
						child: new ListBody(
							children: <Widget>[
								new TextField(
										decoration: InputDecoration(
												border: InputBorder.none,
												hintText: 'Enter a Location',
										),
										onChanged: (mostRecentEntry)
											=> enteredLocation = mostRecentEntry,
								),
								new CheckboxListTile(
									value: false,
									onChanged: null,
									title: new Text(
										'Save as Favorite?',
										style: new TextStyle(
												color: Colors.black.withOpacity(0.8)
										),
									),
								),
							],
						),
					),
					actions: <Widget>[
						buildCancelButton(),
						buildSaveButton()
					],
				);
			},
		);
	}

	Future<Null> _removePlace(context, int placeListPosition)
	async
	{
		SharedPreferences preferences = await SharedPreferences.getInstance();

		String locationsAsString = "";
		List<String> locationsAsList = storedLocations.split(";;");
		for (int i = 0; i < locationsAsList.length; i ++)
		{
			if (i != placeListPosition && locationsAsList[i] != "")
			{
				locationsAsString += locationsAsList[i];
			}
		}

		await preferences.setString('locationsAsString', locationsAsString);
		setState(()
		{
		});
	}

	FlatButton buildSaveButton()
	{
		return new FlatButton(
			child: new Text('Save'),
			onPressed: ()
			{
				//Add the location and restart here
				setState(()
				{
				});
				Navigator.of(context).pop();
			},
		);
	}

	FlatButton buildCancelButton()
	{
		return new FlatButton(
			child: new Text('Cancel'),
			onPressed: ()
			{
				Navigator.of(context).pop();
			},
		);
	}

	void _tempAddLocationsToStorage()
	{
		exit(0);
	}

	void _tempAddLocationsToStorage2()
	async
	{
		SharedPreferences preferences = await SharedPreferences.getInstance();
		String temp = preferences.getString('locationsAsString');

		setState(()
		{
			storedLocationsString = "testLocation;;";
		});
	}
}

/*
void _checkForUpToDateLocations(String storedLocationsAsString)
	{
		if(storedLocations != storedLocationsAsString)
		{
			setState(() {
				widgetList = _locationStringToWidgetList(storedLocationsAsString);
				storedLocations = storedLocationsAsString;
			});
		}
	}

void _tempAddLocationsToStorage()
async
{
	SharedPreferences preferences = await SharedPreferences.getInstance();
	String temp = preferences.getString('locationsAsString');

	setState(()
	{
		widgetList = _locationStringToWidgetList(preferences.getString("locationsAsString") + "");
	});
}

void _tempAddLocationsAndRestart()
async
{
	SharedPreferences preferences = await SharedPreferences.getInstance();
	await preferences.setString('locationsAsString', "place1;;place2");

	//Updating the screen with the new locations that are saved
	setState(()
	{
		widgetList = _locationStringToWidgetList(preferences.getString("locationsAsString") + "");
	});
}
*/

/*
//Converts a string of stored locations into a list
List<Widget> _locationStringToWidgetList(String locationsString)
{
	List<Widget> tempWidgetList = new List<Widget>();

	tempWidgetList.add(new ListTile(
		title: Text('Current Locations:'),
	));

	List<String> locationsList = locationsString.split(';;');

	//Checks if the user has locations stored from either previous uses
	if (locationsList.length != 0 && locationsList[0] != '')
	{
		//Goes through each location stored and converts it to a widget in a list
		for (int i = 0; i < locationsList.length; i++)
		{
			widgetList.add(new ListTile(
				leading: Icon(Icons.place),
				title: Text(locationsList[i]),
				trailing: new FloatingActionButton(
					mini: true,
					onPressed: ()
					=> _removePlace(context, i + 1),
					tooltip: 'Remove Location',
					child: new Icon(Icons.remove),
				),
			),);
		}
	}
	else
	{
		//If the user has no locations stored, display text saying so.
		widgetList.add(new ListTile(
			title: Text('No Locations found!\nAdd one using the button below.'),
		));
	}
	return widgetList;
}
*/
