import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/config.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/book_model.dart';
import 'package:frontend/src/features/core/screens/book/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({super.key, this.bookInfo, this.index});
  final Book? bookInfo;
  final int? index;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  String? _localPath;
  bool? _permissionReady;
  TargetPlatform? platform;
  int isLike = 0;
  int downloadProgress = 0;
  bool isDownloadStarted = false;
  bool isDownloadFinish = false;

  @override
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        // color: Get.isDarkMode ? darkGreyClr : Colors.white,
        padding: const EdgeInsets.only(top: 60, left: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 0, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      size: 28,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              child: Row(
                children: [
                  Material(
                    elevation: 0.0,
                    child: Container(
                      height: 180,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ],
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.bookInfo!.fullImagePath,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth - 30 - 180 - 20,
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          widget.bookInfo!.bookTitle,
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w900,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black54,
                          ),
                        ),
                        Text(
                          "${"author".tr}: ${widget.bookInfo!.bookAuthor}",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w900,
                            color: Get.isDarkMode
                                ? Colors.white38
                                : Colors.black54,
                          ),
                        ),
                        const Divider(color: Colors.black26),
                        TextWidget(
                          text: widget.bookInfo!.bookTitle,
                          fontSize: 16,
                          color: Colors.white24,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Divider(color: Colors.black26),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            print("Is Like buttn cliked");
                            _likePost();
                          });
                        },
                        child: Icon(
                          Icons.favorite,
                          color: isLike == 1
                              ? const Color.fromARGB(255, 226, 25, 25)
                              : const Color(0xFF7b8ea3),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  //  Expanded(child: Container()),
                  Column(
                    children: [
                      Visibility(
                          visible: isDownloadStarted,
                          child: CircularPercentIndicator(
                            radius: 20.0,
                            lineWidth: 3.0,
                            percent: (downloadProgress / 100),
                            center: Text(
                              "$downloadProgress%",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.blue),
                            ),
                            progressColor: Colors.blue,
                          )),
                      Visibility(
                        visible: !isDownloadStarted,
                        child: IconButton(
                          icon: const Icon(Icons.download),
                          color: isDownloadFinish ? Colors.green : Colors.grey,
                          onPressed: downloadFile,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                TextWidget(
                  text: "details".tr,
                  fontSize: 30,
                ),
                Expanded(child: Container())
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 210,
              child: Text(
                widget.bookInfo!.bookDescription,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w900,
                  color: Get.isDarkMode ? Colors.white24 : Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showMsg(msg) {
    Get.snackbar(
      "Token has Refresh ",
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.cGreenClr,
    );
  }

  _likePost() async {
    print("Is Liked : $isLike");
    if (isLike == 0) {
      print("Is Liked : $isLike");
      bool liked = await ApiService.likeBook(widget.bookInfo!.bookId!);
      print("Is Liked : $liked");
      if (liked) {
        // Book liked successfully, update the UI or take further action
        setState(() {
          isLike = 1;
        });
      } else {
        // Handle the case where liking the book failed
        // You can show an error message or take other actions
      }
    } else if (isLike == 1) {
      print("Is Liked : $isLike");
      // Handle disliking the book if needed
    }
  }

  // Your existing likeGet() method can be used to fetch the like status

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath());
    print(_localPath);
    final saveDir = Directory(_localPath!);
    bool hasExited = await saveDir.exists();
    if (!hasExited) {
      saveDir.create();
    }
  }

  Future<String> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/sdcard/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return '${directory.path}${Platform.pathSeparator}Download';
    }
  }

  void downloadFile() async {
    isDownloadStarted = true;
    isDownloadFinish = false;
    downloadProgress = 0;
    _permissionReady = await _checkPermission();
    if (_permissionReady!) {
      await _prepareSaveDir();
      print("Downloading");

      try {
        final dio = Dio();
        final response = await dio.get(
          "${Config.imageURL}/${widget.bookInfo!.bookFilePath}", // Replace with your book file URL
          onReceiveProgress: (received, total) {
            print("${Config.imageURL}${widget.bookInfo!.bookFilePath}");
            setState(() {
              downloadProgress = (received / total * 100).floor();
            });
          },
        );

        if (response.statusCode == 200) {
          final file = File('$_localPath/new_fitness_file.pdf');
          await file.writeAsBytes(response.data);
        }
      } catch (e) {
        print("Download Failed: $e");
      }
    }

    if (downloadProgress == 100) {
      setState(() {
        if (downloadProgress == 100) {
          isDownloadFinish = true;
          isDownloadStarted = false;
        }
      });
    }
  }
}
