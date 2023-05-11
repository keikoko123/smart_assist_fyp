import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// It's getting all data from collection
  Stream<QuerySnapshot> getData({required String collection}) {
    return _firestore.collection(collection).snapshots();
  }

  /// It's getting document from collection
  Future<DocumentSnapshot> getDocument({required String collection, required String documentId}) {
    return _firestore.collection(collection).doc(documentId).get();
  }

  /// Its creating data to collection
  Future<void> createData({required String collection, required Map<String, dynamic> data}) async {
    await _firestore.collection(collection).add(data);
  }

  /// Its creating document to collection
  Future<void> createDocument({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collection).doc(documentId).set(data);
  }

  /// Its updating data to collection
  Future<void> updateData({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collection).doc(documentId).update(data);
  }

  ///Its deleting data from collection"
  Future<void> deleteData({required String collection, required String documentId}) async {
    await _firestore.collection(collection).doc(documentId).delete();
  }
}