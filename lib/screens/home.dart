import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vottle/services/models.dart';

enum PlayerState{
   played,
   paused,

}
class PlayerScreen extends StatefulWidget {
  PlayerScreen({this.topic,this.id,this.ref});
  final String topic;
  final String id;
  final CollectionReference ref;
  PlayerState playerState = PlayerState.paused;

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final _store = Firestore.instance;
  PlayerState playerState = PlayerState.paused;
  AudioPlayer audioPlayer = AudioPlayer();
  int currentTrackIndex = 0;
  List<String> tracks = [];
  List<SoundTrack> soundTracks = [];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<List<SoundTrack>> getData() async {
      var snapshots = await _store.collection('topics').document(widget.id).collection('soundTracks').getDocuments();
      soundTracks = snapshots.documents.map((doc) => SoundTrack.fromMap(doc.data) ).toList();
      print(soundTracks.length);
      for(SoundTrack track in soundTracks){

        print(tracks.length.toString()+ 'hello');
        print(soundTracks.length);
        print(track.url);
        tracks.add(track.url);

      }
      return snapshots.documents.map((doc) => SoundTrack.fromMap(doc.data) ).toList();
    }

    getData();

    print(tracks.length);
    print('herllo');

  }
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return FutureBuilder<QuerySnapshot>(
      future:  _store.collection('topics').document(widget.id).collection('soundTracks').getDocuments(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if(!snapshot.hasData) {

          return Center(

            child: CircularProgressIndicator(


              backgroundColor: Colors.lightBlueAccent,
            ),


          );

        }

//        soundTracks = snapshot.data.documents.map((doc) => SoundTrack.fromMap(doc.data) ).toList();
//


        return Scaffold(
          appBar: AppBar(
            title: Text(widget.topic),
            backgroundColor: Colors.transparent,
            actions: <Widget>[
                IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                onPressed: (){
                  },),
            ],
          ),

          backgroundColor: Color(0xff240043),
          body: Center(
            child: Column(

              children: <Widget>[

                SizedBox(height: 100,),
            Stack(
              alignment: Alignment.center ,
              children: <Widget>[


                SpinKitDoubleBounce	(
                  color: Color(0xff8D7A9D),
                  size: 300.0,
                ),

                CircleAvatar(backgroundColor: Colors.red,radius: 90,
                  backgroundImage: NetworkImage(soundTracks[currentTrackIndex].photo),
                ),

              ],
            ),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Text(soundTracks[currentTrackIndex].username,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17),textAlign: TextAlign.center,),
                ),
                SizedBox(height: 15,),
                Text(soundTracks[currentTrackIndex].country,style: TextStyle(color: Colors.white),),
                SizedBox(height: 120,),
            Container(
              alignment: Alignment.center,
              height: 70,
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                color: Color(0xff120027),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      icon: FaIcon(FontAwesomeIcons.stepBackward,color: Colors.white,size: 20,),
                        onPressed: () {

                        print(currentTrackIndex);
//                          if(currentTrackIndex-1 >= 0) {
//                            audioPlayer.play(tracks[currentTrackIndex - 1]);
//                          }


                        }
                  ),

                  IconButton(
                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      icon: playerState == PlayerState.played ? FaIcon(FontAwesomeIcons.pauseCircle,color: Colors.white,size: 40,) : FaIcon(FontAwesomeIcons.playCircle,color: Colors.white,size: 40,),
                      onPressed: () async {


//                        int result = await audioPlayer.play('hhttp://www.bigrockmusic.com/mp3/track_01.mp3');

                        play(int i) async {

                          currentTrackIndex = i;
                          audioPlayer.play(tracks[i]);
                          audioPlayer.onPlayerCompletion.listen((event) {
                            print('completed');


                            setState(() {
                              currentTrackIndex += 1;
                            });

                            if(currentTrackIndex <= tracks.length){
                              play(currentTrackIndex);
                            } else {
                              audioPlayer.stop();
                              print('done');
                            }
                          });

                        }

                        if(playerState == PlayerState.paused) {
                          print('I am here');

                          play(0);
                          setState(() {
                            playerState = PlayerState.played;
                          });


                        } else {
                          setState(() {
                            playerState = PlayerState.paused;
                          });
                          audioPlayer.stop();

                        }
//                        play();


                      }
                  ),
                   IconButton(
                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                  icon: FaIcon(FontAwesomeIcons.stepForward,color: Colors.white,size: 20,),
                  onPressed: () {

                    if(currentTrackIndex+1 <= tracks.length) {
                      audioPlayer.play(tracks[currentTrackIndex + 1]);
                      setState(() {
                        currentTrackIndex += 1;
                      });
                    }
                  }
                   ),

                ],
              ),

            ),



              ],

            ),
          ),
        );
      }
    );
  }
}
