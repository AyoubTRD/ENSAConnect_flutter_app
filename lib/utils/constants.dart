import 'package:ensa/models/story_model.dart';
import 'package:ensa/models/user_model.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF4C68DA);
const kAccentColor = Color(0xFF40BADF);

// Text colors
const kTextPrimary = Color(0xFF1A2552);
const kTextSecondary = Color(0xFF767D90);
const kAppBarText = Color(0xFF382E32);
const kTitleText = Color(0xFF2A355E);

const kDefaultPadding = 20.0;

const users = [
  User(
    firstName: 'Ayoub',
    lastName: 'Taouarda',
    fullName: 'Ayoub Taouarda',
    profilePicture: 'https://picsum.photos/100/100',
  ),
  User(
    firstName: 'John',
    lastName: 'Smith',
    fullName: 'John Smith',
    profilePicture: 'https://picsum.photos/100/100',
  ),
  User(
    firstName: 'Loeuf',
    lastName: 'Artificiel',
    fullName: 'Loeuf Artificiel',
    profilePicture: 'https://picsum.photos/100/100',
  ),
  User(
    firstName: 'Abd Lhakim',
    lastName: 'Loeuf',
    fullName: 'Abd Lhakim Loeuf',
    profilePicture: 'https://picsum.photos/100/100',
  ),
  User(
    firstName: 'Ayoub',
    lastName: 'Taouarda',
    fullName: 'Ayoub Taouarda',
    profilePicture: 'https://picsum.photos/100/100',
  ),
  User(
    firstName: 'John',
    lastName: 'Smith',
    fullName: 'Ayoub Taouarda',
    profilePicture: 'https://picsum.photos/100/100',
  ),
  User(
    firstName: 'Howard',
    lastName: 'The coward',
    fullName: 'Ayoub Taouarda',
    profilePicture: 'https://picsum.photos/100/100',
  ),
];

List<Story> stories = users.map((e) => Story(user: e, images: [])).toList();
