import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg2_10/controller/auth_controller.dart';
import 'package:pas_mobile_11pplg2_10/widget/myButton.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 6,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(
                    "https://i.pinimg.com/474x/f3/72/72/f3727228f29cdad9b4744e2c91e2eb04.jpg",
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Banyu Bening Tegar Pangestu",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "banyubening@gmail.com",
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
                Mybutton(text: "LogOut", onPressed: controller.logout)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
