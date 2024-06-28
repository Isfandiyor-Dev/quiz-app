import 'package:cloud_firestore/cloud_firestore.dart';

class Variant {
  String id;
  String variant;

  Variant({
    required this.id,
    required this.variant,
  });

  factory Variant.fromJson(QueryDocumentSnapshot query) {
    return Variant(id: query.id, variant: query["variant"]);
  }
}
