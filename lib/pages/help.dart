import 'package:animated_search/animated_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medtrack/screens/main_settings_screen.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  List<HelpItem> helpItems = [
    HelpItem(
      'Elder Mode',
      'Set up dual modes',
      HelpDetail([
        'This functionality allows you to provide a better and elder-friendly interface. The person will only be able to access the important and emergency features of the application. To keep it secure and trusted, We implemented a pin security, without which you can not switch out of the Elder mode.\n To set up the Elder mode, you need to go to the settings and click on "Mode Pin", you will be asked to set a pin for the Elder mode. Once you set the pin, you can switch to the Elder mode.',
        ImageContent(
          imagePaths: [
            "screenShots/elderMode/settings_icon_img.png",
            "screenShots/elderMode/mode_pin_img.png",
            "screenShots/elderMode/pin_set_img.png",
            "screenShots/elderMode/switch_in_img.png",
            "screenShots/elderMode/elder_page_img.png",
          ],
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
      ]),
    ),
    HelpItem(
      'Medicine Reminder',
      'Never miss a dose again!',
      HelpDetail([
        'Click on the Medicine Reminder option in the main functionality, after being redirected, click on the add icon on the page which will pop up with several options. Set up the type, time, repeatation and other details as required. After taking medicine, double tap on the medicine card to turned it into "Taken", if not then double tap again to set it as "not taken". Long press the card for deleting it or all the medicines.',
        ImageContent(
          imagePaths: [
            "screenShots/medicineReminder/medicine_reminder_img.png",
            "screenShots/medicineReminder/medicine_reminder_layout_img.png",
            "screenShots/medicineReminder/medicine_add_img.png",
            "screenShots/medicineReminder/medicine_creation_img.png",
            "screenShots/medicineReminder/medicine_card_not_taken_img.png",
            "screenShots/medicineReminder/medicine_taken_card_img.png",
            "screenShots/medicineReminder/medicine_delete_img.png",
          ],
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
      ]),
    ),
    HelpItem(
      'Reports',
      'View medicine analytics',
      HelpDetail([
        'Have a look at graphs for better understanding with your medicine history. Go to View Reports which will display bar graph and pie chart shwoing your taken medicine distribution. The graphs are distribute between values "ml" and "mg"',
        ImageContent(
          imagePaths: [
            "screenShots/medicineReports/report_button_img.png",
            "screenShots/medicineReports/report_layout_img.png",
            "screenShots/medicineReports/report_bar_chart_img.png",
            "screenShots/medicineReports/report_pie_chart_img.png",
          ],
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
      ]),
    ),
    HelpItem(
      'Communities',
      'Connect with others and share your thoughts',
      HelpDetail([
        'Join different communtites to share information and help others regarding elderly care. Click on communities button and then you will be directed to communitites layout. You can create your own community by pressing "add" button or search for any existing community to be a part of by giving its name.',
        ImageContent(
          imagePaths: [
            "screenShots/communityGroups/communities_button_img.png",
            "screenShots/communityGroups/group_layout_img.png",
            "screenShots/communityGroups/group_creation_img.png",
            "screenShots/communityGroups/in_group_layout_img.png",
            "screenShots/communityGroups/group_info_img.png",
            "screenShots/communityGroups/group_search_img.png",
          ],
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
      ]),
    ),
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
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
    preferredSize: Size.fromHeight(70),
    child: Container(
      decoration: BoxDecoration(
        // color: Colors.blue[600],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => AccountScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Help Center',
          style: TextStyle(
          
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
         centerTitle: true,
      ),
    ),
  ),
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: screenSize.height * 0.02),
          child: Column(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const Text(
                    //   'Function Details',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 24,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: screenSize.height * 0.01,
                    // ),
                    Text(
                      'Enter your query',
                      style: TextStyle(color: Colors.blue[100]),
                    ),
                  ],
                ),
              ),
              
              Padding(
                padding: EdgeInsets.all(screenSize.height * 0.05),
                child: AnimatedSearch(
                  iconColor: Colors.blue[600],
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
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
              // SizedBox(
              //   height: screenSize.height * 0.01,
              // ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  padding: EdgeInsets.all(screenSize.width * 0.06),
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return HelpCard(
                        item: filteredItems[index],
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return HelpCardDetail(item: filteredItems[index]);
                            },
                          );
                        },
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

class HelpCard extends StatelessWidget {
  final HelpItem item;
  final VoidCallback onTap;

  HelpCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: ListTile(
          title: Text(
            item.title,
            style: TextStyle(color: Colors.blue),
          ),
          subtitle: Text(
            item.shortDescription,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class HelpCardDetail extends StatelessWidget {
  final HelpItem item;

  HelpCardDetail({required this.item});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.close, color: Colors.white),
              ),
            ),
            Text(
              item.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 10),
            ...item.detail.content.map((contentItem) {
              if (contentItem is String)
                return Text(contentItem);
              else if (contentItem is ImageContent)
                return contentItem;
              else
                return Container(); // return an empty container if the type is not recognized
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class HelpItem {
  final String title;
  final String shortDescription;
  final HelpDetail detail;

  HelpItem(this.title, this.shortDescription, this.detail);
}

class HelpDetail {
  final List<dynamic> content;

  HelpDetail(this.content);
}

class ImageContent extends StatelessWidget {
  final List<String> imagePaths;
  final BoxDecoration decoration;

  ImageContent({required this.imagePaths, required this.decoration});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
      child: Column(
        children: [
          for (String imagePath in imagePaths)
            Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: decoration,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: screenSize.height * 0.25,
                      child: Image.asset(
                        imagePath,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}