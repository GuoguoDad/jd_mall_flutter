import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerDemo extends StatefulWidget {
  const VideoPlayerDemo({super.key, this.title});

  final String? title;

  @override
  State<VideoPlayerDemo> createState() => _VideoPlayerDemoState();
}

class _VideoPlayerDemoState extends State<VideoPlayerDemo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  //获取当前视频播放的信息
  VideoPlayerValue get videoPlayerValue => _controller.value;

  //是否初始化完成
  bool get isInitialized => videoPlayerValue.isInitialized;

  //是否正在播放
  bool get isPlaying => videoPlayerValue.isPlaying;

  //当前播放的视频的宽高比例
  double get aspectRatio => videoPlayerValue.aspectRatio;

  //当前视频是否缓存
  bool get isBuffer => videoPlayerValue.isBuffering;

  //当前视频是否循环
  bool get isLoop => videoPlayerValue.isLooping;

  //当前播放视频的总时长
  Duration get totalDuration => videoPlayerValue.duration;

  //当前播放视频的位置
  Duration get currentDuration => videoPlayerValue.position;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    var url = 'https://ik.imagekit.io/guoguodad/video/butterfly.mp4';
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize().then((value) => setState(() {}));

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Butterfly Video'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              //设置视频的大小 宽高比。长宽比表示为宽高比。例如，16:9宽高比的值为16.0/9.0
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          playOrPause();
          setState(() {});
        },
        child: playOrPauseWidget(),
      ),
    );
  }

  playOrPause() {
    if (!_controller.value.isInitialized) {
      return;
    }
    _controller.value.isPlaying ? _controller.pause() : _controller.play();
  }

  playOrPauseWidget() {
    IconData? icon = _controller.value.isPlaying ? Icons.pause : Icons.play_arrow;
    return Icon(icon);
  }
}
