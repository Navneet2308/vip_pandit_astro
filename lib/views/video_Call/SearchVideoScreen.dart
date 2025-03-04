import 'package:astrologeradmin/constance/assets_path.dart';
import 'package:astrologeradmin/views/video_Call/controllers/video_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../model/update_consultationModel.dart';

class SearchAnimationScreen extends StatelessWidget {
  final ConsultationData? mconsultationData;

  SearchAnimationScreen({required this.mconsultationData});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<VideoProvider>(context, listen: false);
      provider.consultationData = mconsultationData!;
      provider.initSharedPreferences(context);
    });
    return Consumer<VideoProvider>(builder: (context, videoProvider, child) {
      return Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: Lottie.asset(AssetsPath.search_lottie),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      videoProvider.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => videoProvider.stopSearching(context),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
