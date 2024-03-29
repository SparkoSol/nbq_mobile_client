import 'package:cloud_firestore/cloud_firestore.dart';

import '_model.dart';

abstract class NBQService<T extends Model> {
  String get collectionName;

  T parseModel(DocumentSnapshot document);

  Stream<List<T>> fetchAllFirestore() => FirebaseFirestore.instance
      .collection(collectionName)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((document) => parseModel(document)).toList());

  Stream<List<T>> fetchAllSortedFirestore() => FirebaseFirestore.instance
      .collection(collectionName)
      .orderBy("timestamp", descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((document) => parseModel(document)).toList());

  Future<T> fetchOneFirestore(String id) async =>
      parseModel(await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .get());

  insertFirestore(T model) async {
    try {
      final document = await FirebaseFirestore.instance
          .collection(collectionName)
          .add(model.toJson());
      model.id = document.id;
      return model;
    } catch (e) {
      print("exception");
      throw e;
      print(e);
      return null;
    }
  }

  updateFirestore(T model) async {
    print(model.id);
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(model.id)
        .set(model.toJson());
  }

  deleteFirestore(String documentId) async {
    print(collectionName);
    print(documentId);
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentId)
        .delete();
  }
}
