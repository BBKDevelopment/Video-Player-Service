/// {@template video_player_service_exception}
/// An exception thrown by the video player service.
/// {@endtemplate}
sealed class VideoPlayerServiceException implements Exception {
  /// {@macro video_player_service_exception}
  const VideoPlayerServiceException();
}

/// {@template load_video_exception}
/// An exception thrown when the video player fails to load a video.
/// {@endtemplate}
class LoadVideoException implements VideoPlayerServiceException {
  /// {@macro load_video_exception}
  const LoadVideoException();
}

/// {@template play_video_exception}
/// An exception thrown when the video player fails to play a video.
/// {@endtemplate}
class PlayVideoException implements VideoPlayerServiceException {
  /// {@macro play_video_exception}
  const PlayVideoException();
}

/// {@template pause_video_exception}
/// An exception thrown when the video player fails to pause a video.
/// {@endtemplate}
class PauseVideoException implements VideoPlayerServiceException {
  /// {@macro pause_video_exception}
  const PauseVideoException();
}

/// {@template set_video_volume_exception}
/// An exception thrown when the video player fails to set playback speed.
/// {@endtemplate}
class SetVideoPlaybackSpeedException implements VideoPlayerServiceException {
  /// {@macro set_video_volume_exception}
  const SetVideoPlaybackSpeedException();
}

/// {@template set_volume_exception}
/// An exception thrown when the video player fails to set the volume.
/// {@endtemplate}
class SetVolumeException implements VideoPlayerServiceException {
  /// {@macro set_volume_exception}
  const SetVolumeException();
}

/// {@template seek_video_position_exception}
/// An exception thrown when the video player fails to seek to a position.
/// {@endtemplate}
class SeekVideoPositionException implements VideoPlayerServiceException {
  /// {@macro seek_video_position_exception}
  const SeekVideoPositionException();
}
