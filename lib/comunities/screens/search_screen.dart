import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medtrack/components/primary_input.dart';
import 'package:medtrack/components/search_group_tile.dart';
import 'package:medtrack/helper/helper_function.dart';
import 'package:medtrack/provider/theme_provider.dart';
import 'package:medtrack/servies/database.dart';
import 'package:medtrack/utils/colors.dart';
import 'package:medtrack/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
 final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? user = _auth.currentUser;
class _SearchScreenState extends State<SearchScreen> {
 
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot? groupLists;
  bool hasGroupList = false;
  String? username = "";
  bool isJoined = false;
  
  @override
  void initState() {
    // getCurrentusernameAndId();
    getUserData();
    super.initState();
  }

  String getName(String value) {
    return value.split("_")[1];
  }
  void getUserData() async {

    final events =
        await _firestore.collection('users').doc(user?.uid).get();
    if (events != null) {
      
      setState(() {
        username = events['fullName'];
      });
    }
   }

  void getCurrentusernameAndId() {
    setState(() {
      HelperFunction.getUsernameFromSharedPreferences().then((value) {
        username = value;
      });
    });
  }

  void getSearchGroups() async {
    if (_searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      Database().searchGroupByName(_searchController.text).then((value) {
        setState(() {
          groupLists = value;
          // print(value.docs);
          // print(groupLists!.docs);
          hasGroupList = true;
          isLoading = false;
        });
      });
    }
  }

  Widget groupList() {
    if (hasGroupList && groupLists!.docs.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: groupLists!.docs.length,
        itemBuilder: (context, index) {
          Database(uid: FirebaseAuth.instance.currentUser!.uid)
              .isUserJoined(groupLists!.docs[index]['groupId'],
                  groupLists!.docs[index]['groupName'], username!)  
              .then((value) {
            setState(() {
              isJoined = value;
            });
          });
          print("Is Joined $isJoined");
          return SearchGroupTile(
            onTap: () async {
              final Map groupJoiningStatus =
                  await Database(uid: FirebaseAuth.instance.currentUser!.uid)
                      .toggleGroupJoin(groupLists!.docs[index]['groupId'],
                          groupLists!.docs[index]['groupName'], username!);
              if (groupJoiningStatus['success']) {
                showSnackBar(context, kprimaryColor, kWhiteColor,
                    groupJoiningStatus['msg']);
              } else {
                print(groupJoiningStatus['err']);
              }
            },
            isJoined: isJoined,
            adminName: getName(groupLists!.docs[index]['admin']),
            groupName: groupLists!.docs[index]['groupName'],
            groupId: groupLists!.docs[index]['groupId'],
            username: username!,
          );
        },
      );
    } else if (hasGroupList && groupLists!.docs.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: const Text(
          "No Group Found",
          style: TextStyle(
            fontSize: 20,
            color: kprimaryColor,
          ),
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: kWhiteColor,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Provider.of<ThemeProvider>(context).mode == ThemeMode.dark
                ? Colors.grey.shade800
                : kprimaryColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryInput(
                    underlineInputBorder: false,
                    textColor: kWhiteColor,
                    placeholder: "Search",
                    controller: _searchController,
                  ),
                ),
                IconButton(
                    onPressed: getSearchGroups,
                    icon: const Icon(
                      Icons.search,
                      color: kWhiteColor,
                      size: 25,
                    ))
              ],
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: kprimaryColor,
                    backgroundColor: Colors.transparent,
                  ),
                )
              : groupList(),
        ],
      ),
    );
  }
}
