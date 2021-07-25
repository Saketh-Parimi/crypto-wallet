import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currencies'),
        actions: [
          IconButton(onPressed: () {
            controller.signOut();
            Get.offAllNamed(Routes.AUTHENTICATION);
          }, icon: Icon(Icons.logout))
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        width: Get.size.width,
        height: Get.size.height,
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('Coins')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: Text('No Data is added, pls add some'),
                );
              }

              return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Obx( () => Container(
                          width: Get.size.width / 1.3,
                          height: Get.size.height / 12,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 5.0,),
                              Text(
                                "Coin: ${document.id}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "\$${controller.getValues(document.id, (document.data() as Map)['Amount']).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () async {
                                  await controller.removeCoin(document.id);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
