import 'package:ensa/models/post_model.dart';
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

List<Post> posts = [
  Post(
    id: '2',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas dapibus in felis ac aliquam. Praesent urna leo, elementum id arcu finibus, maximus pharetra ligula. Donec sapien dolor, euismod pretium laoreet id, mattis congue nulla. Maecenas varius maximus condimentum. Donec dictum id ante vel congue. Proin consectetur sodales leo, eget gravida dolor pharetra ut. Vestibulum vitae venenatis nisl, a egestas turpis. Morbi sagittis tellus magna, vitae bibendum nulla rhoncus quis. Donec scelerisque ornare leo ut viverra. Quisque imperdiet egestas lectus, sit amet faucibus diam ultrices in. Ut eget tellus porttitor, pulvinar turpis at, cursus leo. Cras dapibus nunc risus, eget dictum ex porttitor sit amet. Cras ornare, arcu eu dignissim cursus, purus metus laoreet nulla, vitae finibus massa ligula vel enim. Donec fringilla pharetra auctor. Donec malesuada, mi nec accumsan scelerisque, justo augue egestas dui, eget tempor erat nisi ut elit.',
    user: users[1],
    isBookmarked: true,
    isLiked: false,
    reactionsCount: 165,
    commentsCount: 13,
    images: [],
    videos: [],
    createdAt: '2021-09-01T23:21:31.326Z',
  ),
  Post(
    id: '3',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas dapibus in felis ac aliquam. Praesent urna leo, elementum id arcu finibus, maximus pharetra ligula. Donec sapien dolor, euismod pretium laoreet id, mattis congue nulla. Maecenas varius maximus condimentum. Donec dictum id ante vel congue. Proin consectetur sodales leo, eget gravida dolor pharetra ut. Vestibulum vitae venenatis nisl, a egestas turpis. Morbi sagittis tellus magna, vitae bibendum nulla rhoncus quis. Donec scelerisque ornare leo ut viverra. Quisque imperdiet egestas lectus, sit amet faucibus diam ultrices in. Ut eget tellus porttitor, pulvinar turpis at, cursus leo. Cras dapibus nunc risus, eget dictum ex porttitor sit amet. Cras ornare, arcu eu dignissim cursus, purus metus laoreet nulla, vitae finibus massa ligula vel enim. Donec fringilla pharetra auctor. Donec malesuada, mi nec accumsan scelerisque, justo augue egestas dui, eget tempor erat nisi ut elit.',
    user: users[2],
    isBookmarked: false,
    isLiked: true,
    reactionsCount: 165,
    commentsCount: 13,
    images: [
      'https://images.unsplash.com/photo-1630484174453-fc1d0211ed71?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'
    ],
    videos: [],
    createdAt: '2021-09-01T23:21:31.326Z',
  ),
  Post(
    id: '1',
    user: users[0],
    isBookmarked: false,
    isLiked: false,
    reactionsCount: 165,
    commentsCount: 13,
    images: [
      'https://images.unsplash.com/photo-1630484174453-fc1d0211ed71?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'
    ],
    videos: [],
    createdAt: '2021-09-01T23:21:31.326Z',
  ),
];
