part of 'image_download_bloc.dart';

@freezed
class ImageDownloadEvent with _$ImageDownloadEvent {
  const factory ImageDownloadEvent.started({required String url}) = Started;
}