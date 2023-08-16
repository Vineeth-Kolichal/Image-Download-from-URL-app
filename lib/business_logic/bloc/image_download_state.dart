part of 'image_download_bloc.dart';

@freezed
class ImageDownloadState with _$ImageDownloadState {
  const factory ImageDownloadState({
    required bool isLoading,
    String? imgUrl,
    required bool hasError,
  }) = _Initial;
  factory ImageDownloadState.initial() =>
      ImageDownloadState(isLoading: false, hasError: false);
}
