import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/chat_room.dart';

final chatRoomViewModelProvider =
    ChangeNotifierProvider((ref) => ChatRoomViewModel());

class ChatRoomViewModel extends ChangeNotifier {
  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('chat_rooms');
  String? latestRoomId;

  Future<String?> createRoom(String name) async {
    try {
      log('Creating room with name: $name');
      final snapshot =
          await _database.orderByChild('name').equalTo(name).once();
      log('Snapshot: ${snapshot.snapshot.value}');
      if (snapshot.snapshot.value != null) {
        return 'Room name already exists';
      } else {
        final newRoomRef = _database.push();
        final chatRoom = ChatRoom(id: newRoomRef.key!, name: name);
        await newRoomRef.set(chatRoom.toMap());
        latestRoomId = newRoomRef.key;
        return null;
      }
    } catch (e) {
      log('Error creating room: $e');
      return 'An error occurred while creating the room';
    }
  }

  Future<String?> joinRoom(String roomId) async {
    try {
      final snapshot = await _database.child(roomId).once();
      if (snapshot.snapshot.value == null) {
        return 'Invalid room ID';
      } else {
        return null; // Successfully joined
      }
    } catch (e) {
      log('Error joining room: $e');
      return 'An error occurred while joining the room';
    }
  }
}
