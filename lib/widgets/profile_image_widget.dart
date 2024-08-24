import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_logins/constants.dart';
import 'package:social_logins/providers/user_data.dart';
import 'package:social_logins/services/update_profile_photo.dart';

class ProfileImageWidget extends ConsumerWidget {
  const ProfileImageWidget({
    super.key,
    // required this.context,
  });
  // final BuildContext context;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ImagePicker picker = ImagePicker();
    Future getImage(ImageSource media) async {
      var img = await picker.pickImage(source: media);
      File? profileimage = File(img!.path);
      await UpdateProfilePhoto.setProfilePhoto(profileimage!, context, ref);
    }

    final userData = ref.watch(userDataProvider);
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.camera,
                        color: kDarkGreyColor,
                      ),
                      title: Text(
                        "Capture from Camera",
                        style: TextStyle(
                            color: kDarkGreyColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () async {
                        await getImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.images,
                        color: kDarkGreyColor,
                      ),
                      title: Text(
                        "Select from Gallery",
                        style: TextStyle(
                            color: kDarkGreyColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () async {
                        await getImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Hero(
        tag: 'profile-image',
        child: CircleAvatar(
          child: ClipOval(
            child: userData.photoUrl.isNotEmpty
                ? Image.memory(
                    base64Decode(userData.photoUrl),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : Placeholder(),
          ),
          backgroundColor: kDarkGreyColor,
          radius: 25,
        ),
      ),
    );
  }
}
