import 'package:download_image/data/download_image_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_download_event.dart';
part 'image_download_state.dart';
part 'image_download_bloc.freezed.dart';

class ImageDownloadBloc extends Bloc<ImageDownloadEvent, ImageDownloadState> {
  DownloadImage downloadImage = DownloadImage();
  TextEditingController urlController = TextEditingController();
  ImageDownloadBloc() : super(ImageDownloadState.initial()) {
    on<ImageDownloadEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, hasError: false, imgUrl: null));
      final result = await downloadImage.downloadImage(url: event.url);
      if (result == null) {
        emit(state.copyWith(isLoading: false, hasError: true));
      } else {
        emit(state.copyWith(imgUrl: result, isLoading: false, hasError: false));
      }
    });
  }
}
