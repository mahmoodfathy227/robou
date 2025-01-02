import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerView extends StatefulWidget {
  final String url;
  final DataSourceType dataSourceType;

  const VideoPlayerView({required this.url, required this.dataSourceType, Key? key})
      : super(key: key);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.url);
        break;
      case DataSourceType.network:
        _videoPlayerController = VideoPlayerController.network(widget.url);
        break;
      case DataSourceType.file:

      case DataSourceType.contentUri:

    }
    _videoPlayerController.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(

          aspectRatio: 9 / 16,
          autoPlay: false,
          looping: false,
          videoPlayerController: _videoPlayerController,
        );
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController.value.isInitialized ?
         Chewie(controller: _chewieController)
        : Center(child: CircularProgressIndicator());
  }
}
