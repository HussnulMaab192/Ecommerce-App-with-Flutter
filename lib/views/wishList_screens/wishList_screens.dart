import 'package:cloud_firestore/cloud_firestore.dart';

import '../../consts/consts.dart';
import '../../services/firestore.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          title: "My Wish List"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getWishList(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                    child: Text(
                  'No orders Yet',
                  style: TextStyle(
                      color: redColor, fontFamily: bold, fontSize: 28),
                ));
              } else {
                var data = snapshot.data!.docs;

                return Container();
              }
            }));
  }
}
