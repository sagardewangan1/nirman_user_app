import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactFeatures {
  // String message = "Hello! Sir, ";

  Future<void> launchWhatsapp(
      BuildContext context, String number, String message) async {
    try {
      var storeURL = Platform.isIOS
          ? "whatsapp://send?phone=$number&text=${Uri.encodeComponent(message)}"
          //     ? "https://play.google.com/store/apps"
          //     : "https://www.apple.com/in/app-store/";
          : "whatsapp://send?phone=$number&text=${Uri.encodeFull(message)}";

      if (!await launchUrl(Uri.parse(storeURL))) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid URL"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Opening WhatsApp"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please install Whatsapp first"),
        ),
      );
    }
  }

  Future<void> launchCalling(BuildContext context, String callNumber) async {
    var storeURL = Platform.isIOS
        ? 'tel:+91$callNumber'
        //     ? "https://play.google.com/store/apps"
        //     : "https://www.apple.com/in/app-store/";
        : 'tel:+91$callNumber';

    if (!await launchUrl(Uri.parse(storeURL))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid URL"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Calling..."),
        ),
      );
    }
  }

  Future<void> launchEmail(BuildContext context, String email) async {
    // String email = 'raipurhomes8@gmail.com';
    String title = 'Enquiry For - ';
    String message = '';

    final Uri params = Uri(
      scheme: 'mailto',
      path: email.toString(),
      query: 'subject=$title&body=$message',
    );
    var url = params.toString();
    if (!await launchUrl(Uri.parse(url))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid URL"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Opening Mail..."),
        ),
      );
    }
  }

  Future<void> launchInstagram(BuildContext context, String idLink) async {
    String instagramUrl = Platform.isAndroid
        ? "instagram://user?username=$idLink"
        : Platform.isMacOS || Platform.isWindows
            ? "https://www.instagram.com/$idLink/?hl=en"
            : "https://www.instagram.com/raipurhomes_/?hl=en";
    try {
      if (!await launchUrl(Uri.parse(instagramUrl))) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid URL"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Opening Instagram..."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You don't have Instagram app"),
        ),
      );
    }
  }

  Future<void> launchFacebook(BuildContext context, String pageName) async {
    String facebookUrl = Platform.isAndroid
        ? "https://www.facebook.com/$pageName"
        : Platform.isMacOS || Platform.isWindows
            ? "https://www.facebook.com/$pageName"
            : "https://www.facebook.com/$pageName";
    try {
      if (!await launchUrl(Uri.parse(facebookUrl))) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid URL"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Opening Facebook..."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You don't have Facebook app"),
        ),
      );
    }
  }

  Future<void> launchYoutube(BuildContext context, String youtubeLink) async {
    String youtubeURL = Platform.isAndroid
        ? "https://m.youtube.com/$youtubeLink"
        : Platform.isMacOS || Platform.isWindows
            ? "'https://m.youtube.com/$youtubeLink"
            : "'https://www.youtube.com/$youtubeLink";
    try {
      if (!await launchUrl(Uri.parse(youtubeURL))) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid URL"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Opening Youtube..."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You don't have Youtube app"),
        ),
      );
    }
  }

  Future<void> gotoRaipurBuilder(
      BuildContext context, String url, String urlName) async {
    try {
      if (!await launchUrl(Uri.parse(url))) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid URL"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Opening $urlName..."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error opening $urlName"),
        ),
      );
    }
  }
}
