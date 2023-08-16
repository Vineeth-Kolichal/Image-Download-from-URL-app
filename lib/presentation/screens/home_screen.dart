import 'dart:developer';
import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:download_image/business_logic/bloc/image_download_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(children: [
          TextFormField(
            controller: context.read<ImageDownloadBloc>().urlController,
            decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    FlutterClipboard.paste().then((value) => context
                        .read<ImageDownloadBloc>()
                        .urlController
                        .text = value);
                  },
                  child: const Icon(Icons.paste),
                ),
                hintText: 'Paste Image url',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  context.read<ImageDownloadBloc>().add(Started(
                      url: context
                          .read<ImageDownloadBloc>()
                          .urlController
                          .text
                          .trim()));
                },
                icon: const Icon(Icons.download),
                label: const Text('Download Image'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<ImageDownloadBloc>().urlController.clear();
                },
                icon: const Icon(Icons.clear),
                label: const Text('Clear URL'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          BlocConsumer<ImageDownloadBloc, ImageDownloadState>(
            listener: (context, state) {
              if (state.imgUrl != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image downloaded to download folder'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            builder: (context, state) {
              log('${state.imgUrl}');
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.hasError) {
                return const Center(child: Text('Error occured'));
              }
              return Column(
                children: [
                  SizedBox(
                    // height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: (state.imgUrl != null)
                        ? Image.file(
                            File(
                              state.imgUrl!,
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  Visibility(
                    visible: (state.imgUrl != null),
                    child: TextButton.icon(
                        onPressed: () async {
                          XFile image = XFile(state.imgUrl!);

                          try {
                            final result = await Share.shareXFiles([image],
                                text: 'Great picture');
                            if (result.status == ShareResultStatus.success) {
                              print('Thank you for sharing the picture!');
                            }
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        icon: const Icon(Icons.share),
                        label: const Text('Share')),
                  )
                ],
              );
            },
          )
        ]),
      ),
    );
  }
}
