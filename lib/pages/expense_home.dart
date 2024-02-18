import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/pages/dash.dart';
import 'package:medtrack/pages/expense_helper/expense_help.dart';
import 'package:medtrack/pages/expense_models/expense.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:provider/provider.dart';
import 'package:medtrack/servies/database.dart';
import 'dart:math' as math;

import 'expense_components/my_list_tile.dart';


int counter = 0;

class ExpenseHomePage extends StatefulWidget {
  final String fullname;

  const ExpenseHomePage({Key? key, required this.fullname}) : super(key: key);

  @override
  State<ExpenseHomePage> createState() => _ExpenseHomePageState();
}

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;

class _ExpenseHomeScreenState extends State<ExpenseHomePage> {
  
  int selectedYear = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses',
         style: TextStyle(
          
            color: Color.fromARGB(255, 255, 72, 72),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

}


class _ExpenseHomePageState extends State<ExpenseHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void openNewExpenseBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Expense Name'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(hintText: 'Expense Amount'),
            ),
          ],
        ),
        actions: [
          _cancelButton(),
          _createNewExpenseButton(),
        ],
      ),
    );
  }

  void openEditBox(Expense expense) {
    String existingName = expense.name;
    String existingAmount = expense.amount.toString();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: existingName),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(hintText: existingAmount),
            ),
          ],
        ),
        actions: [
          _cancelButton(),
          _editExpenseButton(expense),
        ],
      ),
    );
  }

  void openDeleteBox(Expense expense) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete expense'),
        actions: [
          _cancelButton(),
          _deleteExpenseButton(expense),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: PreferredSize(
    preferredSize: Size.fromHeight(70),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => DashPage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Expenses',
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
      floatingActionButton: FloatingActionButton(
        onPressed: openNewExpenseBox,
        child: const Icon(Icons.add),
      ),
      body: 
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Expenses').doc(user!.email).collection('userExpenses').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
      
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Stack(
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
      
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            double totalExpense = 0;
  List<Expense> expenses = [];
for (var doc in snapshot.data!.docs) {
    var docData = doc.data() as Map<String, dynamic>;
    totalExpense += docData['amount'];

    expenses.add(
      Expense(
        docId: doc.id,
        id: docData['id'],
        name: docData['name'],
        amount: docData['amount'],
        date: (docData['date'] as Timestamp).toDate(),
      ),
    );
  }

  return SafeArea(
    child: Column(
      children: [
         Text(
          'Total Expense: \$${totalExpense.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data!.docs.length,
           // Inside the ListView.builder
itemBuilder: (BuildContext context, int index) {
  var doc = snapshot.data!.docs[index];
  var docData = doc.data() as Map<String, dynamic>;
  return Card(
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.grey, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    
    child: MyListTile(
      title: docData['name'],
      trailing: formatAmount(docData['amount']),
      onEditPressed: (context) => openEditBox(Expense(
        docId: doc.id,
        id: docData['id'],
        name: docData['name'],
        amount: docData['amount'],
        date: (docData['date'] as Timestamp).toDate(),
      )),
      onDelPressed: (context) => openDeleteBox(
        Expense(
          docId: doc.id,
          id: docData['id'],
          name: docData['name'],
          amount: docData['amount'],
          date: (docData['date'] as Timestamp).toDate(),
        ),
      ),
    ),
  );
},
          ),
        ),
      ],
    ),
  );
} else {
  return const Text('No data');
}
        },
      ),
    );
  }

  Widget _cancelButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(context);
        nameController.clear();
        amountController.clear();
      },
      child: const Text('Cancel'),
    );
  }

  Widget _createNewExpenseButton() {
    return MaterialButton(
      onPressed: () async {
        if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
          Navigator.pop(context);

          Expense newExpense = Expense(
            id: counter + 1,
            name: nameController.text,
            amount: convertStringToDouble(amountController.text),
            date: DateTime.now(),
            docId: '',
          );
          counter++;

          CollectionReference expenses = FirebaseFirestore.instance.collection('Expenses').doc(user!.email).collection('userExpenses');
          DocumentReference docRef = await expenses.add({
            'id': newExpense.id,
            'name': newExpense.name,
            'amount': newExpense.amount,
            'date': newExpense.date,
            'user_name': widget.fullname,
          });

          await docRef.update({
            'docId': docRef.id,
          });
          nameController.clear();
          amountController.clear();
        }
      },
      child: const Text('Save'),
    );
  }

  Widget _editExpenseButton(Expense expense) {
    return MaterialButton(
      onPressed: () async {
        if (nameController.text.isNotEmpty || amountController.text.isNotEmpty) {
          Navigator.pop(context);

          Expense updatedExpense = Expense(
            id: expense.id,
            name: nameController.text.isNotEmpty ? nameController.text : expense.name,
            amount: amountController.text.isNotEmpty ? convertStringToDouble(amountController.text) : expense.amount,
            date: DateTime.now(),
            docId: expense.docId,
          );

          CollectionReference expenses = FirebaseFirestore.instance.collection('Expenses').doc(user!.email).collection('userExpenses');
          await expenses.doc(updatedExpense.docId).update({
            'id': updatedExpense.id,
            'name': updatedExpense.name,
            'amount': updatedExpense.amount,
            'date': updatedExpense.date,
            'user_name': widget.fullname,
          });
        }
      },
      child: const Text('Save'),
    );
  }

  Widget _deleteExpenseButton(Expense expense) {
    return MaterialButton(
      onPressed: () async {
        Navigator.pop(context);

        CollectionReference expenses = FirebaseFirestore.instance.collection('Expenses').doc(user!.email).collection('userExpenses');
        await expenses.doc(expense.docId).delete();
      },
      child: const Text("Delete"),
    );
  }
}

