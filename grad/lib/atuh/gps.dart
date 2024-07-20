import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Gps extends StatefulWidget {
  const Gps({super.key});

  @override
  State<Gps> createState() => _GpsState();
}

class _GpsState extends State<Gps> {
  final Stream<QuerySnapshot> usersstream =
      FirebaseFirestore.instance.collection('control').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
            stream: usersstream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Erorr");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading ....");
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, Index) {
                    return Card(
                      child: ListTile(
                        subtitle: Text("${snapshot.data!.docs[Index]['age']}"),
                        title:
                            Text("${snapshot.data!.docs[Index]['usersname']}"),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
