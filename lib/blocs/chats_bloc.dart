import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/artemis_client.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

class GetChatsError extends Error {}

class CreateChatError extends Error {}

class ChatsBloc {
  late BehaviorSubject<List<ChatMixin>> _chatsBS =
      BehaviorSubject<List<ChatMixin>>();
  late BehaviorSubject<Map<String, List<MessageMixin>>> _chatMessagesBS =
      BehaviorSubject.seeded(Map());

  ValueStream<List<ChatMixin>> get chats => _chatsBS.stream;
  ValueStream<Map<String, List<MessageMixin>>> get chatMessages =>
      _chatMessagesBS.stream;

  Future<List<ChatMixin>> getAllChats() async {
    final query = GetChatsQuery();

    final response = await apiClient.execute(query);

    if (response.hasErrors) {
      print(response.errors);
      throw GetChatsError();
    }

    final List<ChatMixin> chats = response.data!.getChats;
    _chatsBS.sink.add(chats);

    return chats;
  }

  Future<List<MessageMixin>> getMessagesForChat(String chatId) async {
    final query = GetMessagesForChatQuery(
      variables: GetMessagesForChatArguments(chatId: chatId),
    );
    final response = await apiClient.execute(query);

    if (response.hasErrors) {
      print(response.errors);
      throw Error();
    }

    final List<MessageMixin> messages = response.data!.getChatMessages;

    final messagesCache = chatMessages.value;
    messagesCache[chatId] = messages.map((e) => e as MessageMixin).toList();
    _chatMessagesBS.sink.add(messagesCache);

    return messages;
  }

  Future<ChatMixin> getChatById(String chatId) async {
    if (chats.hasValue) {
      final cachedChat =
          chats.value.firstWhereOrNull((element) => element.id == chatId);
      if (cachedChat != null) return cachedChat;
    }

    final query = GetChatByIdQuery(
      variables: GetChatByIdArguments(chatId: chatId),
    );
    final response = await apiClient.execute(query);
    return response.data!.getChatById;
  }

  Future<ChatMixin> createChat(CreateChatInput input) async {
    final mutation = CreateChatMutation(
      variables: CreateChatArguments(input: input),
    );

    final response = await apiClient.execute(mutation);

    if (response.hasErrors) {
      print(response.errors);
      throw CreateChatError();
    }

    final ChatMixin chat = response.data!.createChat;
    if (_chatsBS.hasValue) {
      final List<ChatMixin> newChats = List.from(_chatsBS.value);
      newChats.add(chat);
      _chatsBS.sink.add(newChats);
    }

    return chat;
  }

  Future<MessageMixin> sendMessage(CreateMessageInput input) async {
    final mutation = CreateMessageMutation(
      variables: CreateMessageArguments(input: input),
    );
    final response = await apiClient.execute(mutation);

    if (response.hasErrors) {
      throw ErrorDescription(response.errors![0].message);
    }

    final MessageMixin message = response.data!.createMessage;

    final chatsMap = chatMessages.value;
    final chat = chatsMap[input.chatId];
    if (chat != null) {
      chat.add(message as MessageMixin);
      _chatMessagesBS.sink.add(chatsMap);
    }

    return message;
  }

  void dispose() {
    _chatsBS.close();
    _chatMessagesBS.close();
  }
}

final chatsBloc = ChatsBloc();
