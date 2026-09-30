import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const FullScreenVideoPlayer({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _controller;
  bool isPlaying = false; // State to track whether the video is playing

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://civm.ariespro.com/assets/clientuploads/${widget.videoUrl}'))
      ..initialize().then((_) {
        setState(
            () {}); // Ensure the first frame is shown after the video is initialized
        _controller.pause(); // Start the video in a paused state
      }).catchError((error) {
        print('Error loading video: $error');
      });

    // Add listener to update play/pause button when video ends
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          isPlaying = false; // Set isPlaying to false when the video ends
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {}); // Remove listener when disposing
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  void togglePlayPause() {
    setState(() {
      if (isPlaying) {
        _controller.pause(); // Pause the video if it's currently playing
      } else {
        _controller
            .seekTo(Duration.zero); // Reset to the beginning before playing
        _controller.play(); // Play the video
      }
      isPlaying = !isPlaying; // Toggle the playing state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : CircularProgressIndicator(), // Show loading indicator while video is loading
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context), // Close the dialog
          ),
        ),
        // Play/Pause button overlay in the center
        Center(
          child: IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              size: 64,
              color: Colors.white,
            ),
            onPressed: togglePlayPause, // Toggle play/pause on button press
          ),
        ),
      ],
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isLoading = true; // Track if the video is still loading

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isLoading = false;
        });
        _controller.play();
      }).catchError((error) {
        print('Video initialization error: $error');
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(_controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                ),
              ],
            ),
          );
  }
}
