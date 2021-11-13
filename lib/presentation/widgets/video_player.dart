
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_themoviedb/commons/utils/navigator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerView extends StatefulWidget {

  final String videoId;

  VideoPlayerView(this.videoId);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trailer'),
        leading: IconButton(
          onPressed: () => pop(context),
          icon: Icon(Icons.close),
        ),
      ),
      body: Center(
        child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            )
        ),
      ),
    );
  }
}