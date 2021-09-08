import 'package:ensa/models/chat_model.dart';
import 'package:ensa/models/message_model.dart';
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

const kUsers = [
  User(
    id: '1',
    firstName: 'Ayoub',
    lastName: 'Taouarda',
    fullName: 'Ayoub Taouarda',
    profilePicture: 'https://picsum.photos/100/100',
  ),
  User(
    id: '2',
    firstName: 'John',
    lastName: 'Smith',
    fullName: 'John Smith',
    profilePicture: 'https://picsum.photos/100/100',
  ),
  User(
    id: '3',
    firstName: 'Loeuf',
    lastName: 'Artificiel',
    fullName: 'Loeuf Artificiel',
    profilePicture: 'https://picsum.photos/100/100',
  ),
  User(
    id: '4',
    firstName: 'Abd Lhakim',
    lastName: 'Loeuf',
    fullName: 'Abd Lhakim Loeuf',
    profilePicture: 'https://picsum.photos/100/100',
  ),
  User(
    id: '5',
    firstName: 'Ayoub',
    lastName: 'Taouarda',
    fullName: 'Ayoub Taouarda',
    profilePicture: 'https://picsum.photos/100/100',
  ),
  User(
    id: '6',
    firstName: 'John',
    lastName: 'Smith',
    fullName: 'Ayoub Taouarda',
    profilePicture: 'https://picsum.photos/100/100',
  ),
  User(
    id: '7',
    firstName: 'Howard',
    lastName: 'The coward',
    fullName: 'Ayoub Taouarda',
    profilePicture: 'https://picsum.photos/100/100',
  ),
];

List<Story> kStories = kUsers.map((e) => Story(user: e, images: [])).toList();

List<Post> kPosts = [
  Post(
    id: '2',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas dapibus in felis ac aliquam. Praesent urna leo, elementum id arcu finibus, maximus pharetra ligula. Donec sapien dolor, euismod pretium laoreet id, mattis congue nulla. Maecenas varius maximus condimentum. Donec dictum id ante vel congue. Proin consectetur sodales leo, eget gravida dolor pharetra ut. Vestibulum vitae venenatis nisl, a egestas turpis. Morbi sagittis tellus magna, vitae bibendum nulla rhoncus quis. Donec scelerisque ornare leo ut viverra. Quisque imperdiet egestas lectus, sit amet faucibus diam ultrices in. Ut eget tellus porttitor, pulvinar turpis at, cursus leo. Cras dapibus nunc risus, eget dictum ex porttitor sit amet. Cras ornare, arcu eu dignissim cursus, purus metus laoreet nulla, vitae finibus massa ligula vel enim. Donec fringilla pharetra auctor. Donec malesuada, mi nec accumsan scelerisque, justo augue egestas dui, eget tempor erat nisi ut elit.',
    user: kUsers[1],
    isBookmarked: true,
    isLiked: false,
    reactionsCount: 165,
    commentsCount: 13,
    images: [],
    videos: [],
    videoThumbnails: [],
    createdAt: '2021-09-01T23:21:31.326Z',
  ),
  Post(
    id: '3',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas dapibus in felis ac aliquam. Praesent urna leo, elementum id arcu finibus, maximus pharetra ligula. Donec sapien dolor, euismod pretium laoreet id, mattis congue nulla. Maecenas varius maximus condimentum. Donec dictum id ante vel congue. Proin consectetur sodales leo, eget gravida dolor pharetra ut. Vestibulum vitae venenatis nisl, a egestas turpis. Morbi sagittis tellus magna, vitae bibendum nulla rhoncus quis. Donec scelerisque ornare leo ut viverra. Quisque imperdiet egestas lectus, sit amet faucibus diam ultrices in. Ut eget tellus porttitor, pulvinar turpis at, cursus leo. Cras dapibus nunc risus, eget dictum ex porttitor sit amet. Cras ornare, arcu eu dignissim cursus, purus metus laoreet nulla, vitae finibus massa ligula vel enim. Donec fringilla pharetra auctor. Donec malesuada, mi nec accumsan scelerisque, justo augue egestas dui, eget tempor erat nisi ut elit.',
    user: kUsers[2],
    isBookmarked: false,
    isLiked: true,
    reactionsCount: 165,
    commentsCount: 13,
    images: [
      'https://images.unsplash.com/photo-1630484174453-fc1d0211ed71?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
      'https://images.unsplash.com/photo-1630484174453-fc1d0211ed71?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'
    ],
    videos: [],
    videoThumbnails: [],
    createdAt: '2021-09-01T23:21:31.326Z',
  ),
  Post(
    id: '1',
    user: kUsers[0],
    isBookmarked: false,
    isLiked: false,
    reactionsCount: 165,
    commentsCount: 13,
    images: [
      'https://images.unsplash.com/photo-1630484174453-fc1d0211ed71?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'
    ],
    videos: [
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
    ],
    videoThumbnails: [
      'https://images.unsplash.com/photo-1593352612961-cb75bd854415?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'
    ],
    createdAt: '2021-09-01T23:21:31.326Z',
  ),
];

final List<Message> kMessages = [
  Message(
      id: '1',
      user: kUsers[1],
      text: 'Hello my world',
      createdAt: '2021-09-01T23:21:31.326Z'),
  Message(
      id: '6',
      user: kUsers[1],
      text: 'Hello my world',
      createdAt: '2021-09-01T23:21:31.326Z'),
  Message(
      id: '7',
      user: kUsers[1],
      text: 'Hello my world',
      createdAt: '2021-09-01T23:21:31.326Z'),
  Message(
      id: '5',
      user: kUsers[0],
      text: 'I wish you a happy birthday my friend <3',
      createdAt: '2021-09-01T23:21:31.326Z'),
  Message(
      id: '2',
      user: kUsers[0],
      text: 'I wish you a happy birthday my friend ',
      createdAt: '2021-09-01T23:21:31.326Z'),
  Message(
      id: '3',
      user: kUsers[2],
      text: 'Whats your name?',
      createdAt: '2021-09-06T23:21:31.326Z'),
];

final List<Chat> kChats = [
  Chat(
    id: '1',
    users: [kUsers[1]],
    messages: [kMessages[0], kMessages[5]],
  ),
  Chat(
    id: '2',
    users: [kUsers[0]],
    messages: [kMessages[3], kMessages[4]],
  ),
  Chat(
    id: '3',
    users: [kUsers[2]],
    messages: [kMessages[5]],
  ),
];
