import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/servies/database.dart';
import 'package:medtrack/utils/colors.dart';

class GroupInfoScreen extends StatefulWidget {
  const GroupInfoScreen({
    super.key,
    required this.groupId,
    required this.groupName,
    required this.adminName,
  });

  final String groupId;
  final String groupName;
  final String adminName;

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  Stream<DocumentSnapshot>? members;

  @override
  void initState() {
    // TODO: implement initState
    getGroupMembers();
    super.initState();
  }

  getGroupMembers() {
    setState(() {
      members = Database().getGroupMembers(widget.groupId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Info"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: kprimaryLightColor,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: kprimaryColor,
                    child: Text(
                      widget.groupName[0],
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Group : ${widget.groupName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Admin : ${widget.adminName}",
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              color: kprimaryColor,
              height: 2,
            ),
            const SizedBox(
              height: 16,
            ),
            memberList(),
          ],
        ),
      ),
    );
  }

Widget memberList() {
  return StreamBuilder(
    stream: members,
    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data!['members'] != null) {
          if (snapshot.data!['members'].length != 0) {
            return ListView.builder(
              itemCount: snapshot.data!['members'].length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final memberData = snapshot.data!['members'][index];
                if (memberData is String && memberData.contains('_')) {
                  final parts = memberData.split("_");
                  final String userId = parts[0];
                  // final String username = parts.length > 1 ? parts[1] : '';
                  final String username = parts[1];
                  print("thidssss daaa nameeee$username");
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: kprimaryColor,
                        child: Text(username[0]),
                      ),
                      title: Text(username),
                      subtitle: Text(userId),
                    ),
                  );
                } else {
                  // handle the case where memberData is not a string or doesn't contain '_'
                  return ListTile(
                    title: Text('Invalid member data'),
                    subtitle: Text(memberData.toString()),
                    );
                }
              },
            );
          } else {
            return const Center(
              child: Text("No Members Found"),
            );
          }
        } else {
          return const Center(
            child: Text("No Members Found"),
          );
        }
      } else {
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: kprimaryColor,
            color: Colors.transparent,
          ),
        );
      }
    },
  );
}
}
