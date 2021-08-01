import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthMethods {
    final FirebaseAuth _firebaseAuth;

    FirebaseAuthMethods({FirebaseAuth firebaseAuth}) :
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
}

class FirebaseFirestoreMethods {
    final FirebaseFirestore _firestore;

    FirebaseFirestoreMethods({FirebaseFirestore firestore}) :
        _firestore = firestore ?? FirebaseFirestore.instance;


    Future<QuerySnapshot> getCollectionSnapshot(String collection) async {
        return await FirebaseFirestore.instance
            .collection(collection)
            .get();
    }

    Future<QuerySnapshot> getSubCollectionSnapshot(String collection, String document, String subCollection) async {
        return await FirebaseFirestore.instance
            .collection(collection)
            .doc(document)
            .collection(subCollection)
            .get();
    }

    Future<QuerySnapshot> getSecondarySubCollectionSnapshot(String collection, String document, String subCollection, String secondDocument, String secondSubCollection) async {
        return await FirebaseFirestore.instance
            .collection(collection)
            .doc(document)
            .collection(subCollection)
            .doc(secondDocument)
            .collection(secondSubCollection)
            .get();
    }

}