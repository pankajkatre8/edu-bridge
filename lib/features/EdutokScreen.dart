import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class EdutokScreen extends StatefulWidget {
  const EdutokScreen({super.key});

  @override
  _EdutokScreenState createState() => _EdutokScreenState();
}

class _EdutokScreenState extends State<EdutokScreen> {
  final List<String> _videoUrls = [
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
  ];
  
  late PageController _pageController;
  late List<VideoPlayerController?> _videoControllers;
  ChewieController? _chewieController;
  int _currentPage = 0;
  final CacheManager _cacheManager = CacheManager(Config(
    'edutok_cache',
    stalePeriod: const Duration(days: 7),
  ));

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _videoControllers = List.generate(_videoUrls.length, (_) => null);
    _initializePlayer(0);
    _preloadNextVideo(0);
  }

  void _preloadNextVideo(int currentIndex) {
    final nextIndex = currentIndex + 1;
    if (nextIndex < _videoUrls.length) {
      _initializePlayer(nextIndex);
    }
  }

  void _unloadDistantVideos(int currentIndex) {
    for (int i = 0; i < _videoControllers.length; i++) {
      if ((i < currentIndex - 1 || i > currentIndex + 1) && 
          _videoControllers[i] != null) {
        _videoControllers[i]?.dispose();
        _videoControllers[i] = null;
      }
    }
  }

  Future<void> _initializePlayer(int index) async {
    if (_videoControllers[index] != null) return;

    try {
      final file = await _cacheManager.getSingleFile(_videoUrls[index]);
      final controller = VideoPlayerController.network(_videoUrls[index]);
      _videoControllers[index] = controller;
      
      await controller.initialize();
      
      if (mounted && index == _currentPage) {
        _chewieController?.dispose();
        _chewieController = ChewieController(
          videoPlayerController: controller,
          autoPlay: true,
          looping: true,
          showControls: false,
          aspectRatio: controller.value.aspectRatio,
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                'Error loading video',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
        setState(() {});
      }
    } catch (e) {
      print('Error initializing video $index: $e');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _videoControllers) {
      controller?.dispose();
    }
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _videoUrls.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
          _initializePlayer(index);
          _preloadNextVideo(index);
          _unloadDistantVideos(index);
        },
        itemBuilder: (context, index) {
          return _buildVideoItem(index);
        },
      ),
    );
  }

  Widget _buildVideoItem(int index) {
    return Stack(
      children: [
        _buildVideoContent(index),
        _buildVideoOverlay(),
      ],
    );
  }

  Widget _buildVideoContent(int index) {
    if (_videoControllers[index]?.value.isInitialized ?? false) {
      return Chewie(controller: _chewieController!);
    }
    
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildThumbnailPlaceholder(index),
          const SizedBox(height: 20),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      ),
    );
  }

  Widget _buildThumbnailPlaceholder(int index) {
    final List<String> thumbnails = [
      'assets/thumbnails/lesson1.jpg',
      'assets/thumbnails/lesson2.jpg',
      'assets/thumbnails/lesson3.jpg',
    ];
    
    return Image.asset(
      thumbnails[index],
      fit: BoxFit.cover,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[900],
          child: const Icon(Icons.error, color: Colors.white),
        );
      },
    );
  }

  Widget _buildVideoOverlay() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              _buildIconButton(Icons.favorite_border, '2.1K'),
              const SizedBox(height: 20),
              _buildIconButton(Icons.comment, '456'),
              const SizedBox(height: 20),
              _buildIconButton(Icons.share, 'Share'),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://example.com/profile.jpg'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String text) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: () {},
        ),
        Text(text, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}