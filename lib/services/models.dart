import 'package:cloud_firestore/cloud_firestore.dart';

class TopicsData{

  String id;
  String title;
  CollectionReference ref;

  TopicsData({ this.id, this.title });
  TopicsData.fromMap(Map data) {
    id = data['id'];
    title = data['title'];
  }

}

class SoundTrack{

  String url;
  String uid;
  String username;
  String photo;
  String country;

  SoundTrack({ this.uid, this.url,this.username,this.photo,this.country });
  SoundTrack.fromMap(Map data) {
    url = data['url'] ?? '';
    username = data['username'] ?? '';
    uid = data['uid'] ?? '';
    photo = data['profilePic'] ?? '';
    country = data['country'] ?? '';
  }

}