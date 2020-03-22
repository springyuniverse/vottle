import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vottle/screens/home.dart';
import 'package:vottle/services/models.dart';


class Topics extends StatelessWidget {
  final _store = Firestore.instance;
  List<TopicsHolder> topicsHolder = [];
  List<TopicsData> topics;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
    future: _store.collection('topics').getDocuments(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {

      if(!snap.hasData){
        return Text('');
      } else {
        topics = snap.data.documents.map((doc) => TopicsData.fromMap(doc.data) ).toList();

        for(TopicsData topic in topics){
          final newTopic = TopicsHolder(title: topic.title,id: topic.id,);
          topicsHolder.add(newTopic);

        }



        return Scaffold(
          backgroundColor: Color(0xff240043),
          body: Center(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 100,),
                Text('Topics', style: TextStyle(color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w200), textAlign: TextAlign.left,),
                SizedBox(height: 20,),
                Container(
                    alignment: Alignment.center,
                    height: 500,
                    width: 380,
                    color: Color(0xff120027),
                    child: ListView(
                      children: topicsHolder,
                    )
                )
              ],

            ),
          ),
        );
  }});
  }
}


class TopicsHolder extends StatelessWidget {
  TopicsHolder({this.title,this.id});
  final String title;
  final String id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 380,
        height: 50,
        child: Text(
          title, style: TextStyle(
            color: Colors.white),
          textAlign: TextAlign.center,),
        decoration: BoxDecoration(
            color: Color(0xff120027),
            border: Border(
              bottom: BorderSide(
                width: 0.25, color: Colors.white,),
            )

        ),
      ),
      onTap: (){

        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => PlayerScreen(id: id,topic: title,)
        )

        );      },
    );
  }
}
