import 'package:animated_search/animated_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
    List<HelpItem> helpItems = [
    HelpItem('Elder Mode', 'This is a short description of the functionality.', 'This is a long description of the functionality.'),
    HelpItem('Medicine Reminder', 'This is a short description of the functionality.', 'This is a long description of the functionality.'),
    HelpItem('Medicine History', 'This is a short description of the functionality.', 'This is a long description of the functionality.'),
    HelpItem('Reports', 'This is a short description of the functionality.', 'This is a long description of the functionality.'),
    HelpItem('Communities', 'This is a short description of the functionality.', 'This is a long description of the functionality.'),
    HelpItem('Progress Bar', 'This is a short description of the functionality.', 'This is a long description of the functionality.'),
    HelpItem('Gemini AI', 'This is a short description of the functionality.', 'This is a long description of the functionality.'),
    HelpItem('Expense Tracker', 'This is a short description of the functionality.', 'This is a long description of the functionality.'),
    HelpItem('SOS', 'This is a short description of the functionality.', 'This is a long description of the functionality.'),
    // Add more HelpItems here
  ];
  List<HelpItem> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  bool isSearchOpen = false; 
  
  @override
  void initState() {
    super.initState();
    filteredItems = helpItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Function Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Enter your query',
                      style: TextStyle(color: Colors.blue[100]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
       Padding(
  padding: const EdgeInsets.all(16.0),
  child: AnimatedSearch(
    iconColor: Colors.blue[600],
    cursorColor: Colors.black,
    decoration: InputDecoration( // Custom decoration for the search query text field
    hintText: 'Search',
    hintStyle: TextStyle(color: Colors.grey[300]),
    border: InputBorder.none,
  ),
    textEditingController: searchController,
    onChanged: (String value) {
      setState(() {
        isSearchOpen = value.isNotEmpty;
        filteredItems = helpItems
            .where((item) =>
                item.title.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    },
  ),
),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  padding: EdgeInsets.all(25),
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(filteredItems[index].title),
                              content: SingleChildScrollView(
                                child: Text(filteredItems[index].longDescription),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(
                              filteredItems[index].title,
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text(
                              filteredItems[index].shortDescription,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpItem {
  final String title;
  final String shortDescription;
  final String longDescription;

  HelpItem(this.title, this.shortDescription, this.longDescription);
}