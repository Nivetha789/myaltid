// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myaltid/views/congratulation.dart';
import 'package:myaltid/views/profile/currentplan.dart';
import 'package:myaltid/views/profile/enablednd.dart';
import 'package:myaltid/views/profile/referfriend.dart';
import 'package:myaltid/views/reasuable/theme.dart';

void Dialogbox(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black38,
    barrierLabel: 'Label',
    barrierDismissible: true,
    pageBuilder: (_, __, ___) => Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 50),
        color: Colors.black.withOpacity(0.3),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: (() {
              Navigator.pop(context);
            }),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: ClipOval(
                    child: Material(
                      color: blackcolor, // Button color
                      child: InkWell(
                        splashColor: Colors.red, // Splash color
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.person,
                            color: buttoncolor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const Congratulations()),
                    );
                  },
                  child: Text(
                    "My Profile",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: whitecolor,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                  ),
                ),
                const Divider(
                  color: goldcolor,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const CurrentplanScreen()),
                    );
                  },
                  child: Text(
                    "Current Plan",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: whitecolor,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                  ),
                ),
                const Divider(
                  color: goldcolor,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const EnableDndScreen()),
                    );
                  },
                  child: Text(
                    "Enable DND",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: whitecolor,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                  ),
                ),
                const Divider(
                  color: goldcolor,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const ReferafriendScreen()),
                    );
                  },
                  child: Text(
                    "Refer a Friend",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: whitecolor,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                  ),
                ),
                const Divider(
                  color: goldcolor,
                ),
                const Spacer(),
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset("assets/images/myaltidlogo.png"),
                        Text(
                          "Privacy Matters",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: buttoncolor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About Us",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: whitecolor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Contact Us",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: whitecolor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
