import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class Expense {
  final int id;
  final String name;
  final double amount;
  final DateTime date;
  final String docId;

Expense({
  required this.id,
  required this.name,
  required this.amount,
  required this.date,
  required this.docId
});
}