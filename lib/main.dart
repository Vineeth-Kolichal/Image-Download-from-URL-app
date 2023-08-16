import 'package:download_image/business_logic/bloc/image_download_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/screens/home_screen.dart';

void main(List<String> args) {
  runApp(const DownloadImageApp());
}

class DownloadImageApp extends StatelessWidget {
  const DownloadImageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageDownloadBloc(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green),
        title: 'Download Image',
        home: const HomeScreen(),
      ),
    );
  }
}
