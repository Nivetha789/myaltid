import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/dialogbox.dart';
import 'package:myaltid/views/reasuable/theme.dart';

class WhatsappScreen extends StatefulWidget {
  const WhatsappScreen({super.key});

  @override
  State<WhatsappScreen> createState() => _WhatsappScreenState();
}

class _WhatsappScreenState extends State<WhatsappScreen> {
  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: ClipOval(
                  child: Material(
                    color: blackcolor, // Button color
                    child: InkWell(
                      splashColor: Colors.red, // Splash color
                      onTap: () {
                        Dialogbox(context);
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
                height: 150,
              ),
              Text(
                "Whats app will be open with a pre set messages and referral code",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                      color: whitecolor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Back",
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        color: whitecolor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
