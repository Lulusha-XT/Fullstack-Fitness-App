import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/src/features/core/models/exercise_model.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class LocalExcerciseScreen extends StatefulWidget {
  const LocalExcerciseScreen({super.key, required this.excerciseCategory});
  final ExerciseCategory excerciseCategory;
  @override
  State<LocalExcerciseScreen> createState() => _LocalExcerciseScreenState();
}

class _LocalExcerciseScreenState extends State<LocalExcerciseScreen> {
  List<Exercise> excercise = [];
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  bool _disPosed = false;
  int _isPlayingIndex = -1;
  Duration? _duration;
  Duration? _position;
  var _onUpdateControllerTime = 0;
  var _progress = 0.0;

  _initData() async {
    setState(() {
      excercise = widget.excerciseCategory.exercise!;
      _initializedVideo(0);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _disPosed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            _playView(context),
            _controllerView(context),
            _buildCard(),
          ],
        ),
      ),
    );
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _controllerView(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo(remained % 60);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.grey[850],
            inactiveTrackColor: Colors.grey[900],
            trackShape: const RoundedRectSliderTrackShape(),
            trackHeight: 2.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
            thumbColor: Colors.grey,
            overlayColor: Colors.blue[70],
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
            tickMarkShape: const RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.grey[900],
            inactiveTickMarkColor: Colors.grey[900],
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.grey[900],
            valueIndicatorTextStyle: const TextStyle(
              color: Colors.white54,
            ),
          ),
          child: Slider(
            value: max(0, min(_progress * 100, 100)),
            min: 0,
            max: 100,
            divisions: 100,
            label: _position?.toString().split(".")[0],
            onChanged: (value) {
              setState(
                () {
                  _progress = value * 0.01;
                },
              );
            },
            onChangeStart: (value) {
              _controller?.pause();
            },
            onChangeEnd: (value) {
              final duration = _controller?.value.duration;
              if (duration != null) {
                var newValue = max(0, min(value, 99)) * 0.01;
                var millis = (duration.inMilliseconds * newValue).toInt();
                _controller?.seekTo(Duration(milliseconds: millis));
                _controller?.play();
              }
            },
          ),
        ),
        Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (noMute) {
                    //  Get.toNamed(RouteHelper.getIntial());
                    _controller?.setVolume(0);
                  } else {
                    _controller?.setVolume(1.0);
                  }
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 4.0,
                          color: Color.fromARGB(50, 0, 0, 0),
                        ),
                      ],
                    ),
                    child: Icon(
                      noMute ? Icons.volume_up : Icons.volume_off,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final index = _isPlayingIndex - 1;
                  if (index >= 0 && excercise.length >= 0) {
                    _initializedVideo(index);
                  } else {
                    Get.snackbar(
                      "video_list".tr,
                      "",
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(
                        Icons.face,
                        size: 20,
                      ),
                      backgroundColor: Colors.grey,
                      colorText: Colors.white,
                      messageText: Text(
                        "no_video_a_head".tr,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                },
                child: const Icon(
                  Icons.fast_rewind,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_isPlaying) {
                    setState(() {
                      _isPlaying = false;
                    });
                    _controller?.pause();
                  } else {
                    setState(() {
                      _isPlaying = true;
                    });
                    _controller?.play();
                  }
                },
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final index = _isPlayingIndex + 1;
                  if (index <= excercise.length - 1) {
                    _initializedVideo(index);
                  } else {
                    Get.snackbar(
                      "video_list".tr,
                      "",
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(
                        Icons.face,
                        size: 16,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.grey[900],
                      colorText: Colors.white,
                      messageText: Text(
                        "no_mor_video".tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                },
                child: const Icon(
                  Icons.fast_forward,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                "$mins:$secs",
                style: const TextStyle(
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(150, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;

    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 14,
        child: VideoPlayer(_controller!),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 14,
        child: Center(
          child: Text(
            "preparing".tr,
            style: TextStyle(
              fontSize: 20,
              color: Get.isDarkMode ? Colors.white60 : Colors.black54,
            ),
          ),
        ),
      );
    }
  }

  void _onControllerUpdated() async {
    if (_disPosed) {
      return;
    }
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint("controller is null");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller can not be initialized");
      return;
    }
    _duration ??= _controller?.value.duration;
    var duration = _duration;
    if (duration == null) return;
    var position = await controller.position;
    _position = position;
    final playing = controller.value.isPlaying;
    if (playing) {
      if (_disPosed) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  _initializedVideo(int index) async {
    final controller =
        VideoPlayerController.asset(excercise[index].exerciseVideoUrl);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdated);
      old.pause();
    }
    setState(() {
      controller
        ..initialize().then((_) {
          old?.dispose();
          _isPlayingIndex = index;
          controller.addListener(_onControllerUpdated);
          controller.play();
        });
    });
  }

  _onTapVideo(int index) {
    _initializedVideo(index);
  }

  _buildCard() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: double.infinity,
              height: 190,
              child: ListView.builder(
                itemCount: excercise.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _onTapVideo(index);
                          },
                          child: Container(
                            height: 160,
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image: AssetImage(
                                  excercise[index].exerciseThumbnail,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Text(
                            excercise[index].exerciseName,
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
