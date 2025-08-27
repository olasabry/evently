import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventsCollection() =>
      FirebaseFirestore.instance
          .collection("events")
          .withConverter<EventModel>(
            fromFirestore: (docSnapshot, _) =>
                EventModel.fromJson(docSnapshot.data()!),

            toFirestore: (event, _) => event.toJson(),
          );

  static Future<void> createEvent(EventModel event) {
    CollectionReference<EventModel> eventsCollection = getEventsCollection();
    DocumentReference<EventModel> doc = eventsCollection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<void> updateEvent(EventModel event) {
    CollectionReference<EventModel> eventsCollection = getEventsCollection();

    return eventsCollection.doc(event.id).update(event.toJson());
  }

  static Future<void> deleteEvent(String id) {
    CollectionReference<EventModel> eventsCollection = getEventsCollection();
    return eventsCollection.doc(id).delete();
  }

  static Future<List<EventModel>> getEvents() async {
    CollectionReference<EventModel> eventsCollection = getEventsCollection();

    QuerySnapshot<EventModel> querySnapshot = await eventsCollection
        .orderBy("timestamp")
        .get();

    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance
          .collection("users")
          .withConverter<UserModel>(
            fromFirestore: (docSnapshot, _) =>
                UserModel.fromJson(docSnapshot.data()!),

            toFirestore: (user, _) => user.toJson(),
          );

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    UserModel user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
    );

    CollectionReference<UserModel> userCollection = getUsersCollection();

    await userCollection.doc(user.id).set(user);

    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    CollectionReference<UserModel> userCollection = getUsersCollection();
    DocumentSnapshot<UserModel> docSnapshot = await userCollection
        .doc(credential.user!.uid)
        .get();

    return docSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();
}
