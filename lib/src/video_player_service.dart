import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

/// An exception thrown when the video player fails to load a video.
class LoadVideoException implements Exception {}

/// An exception thrown when the video player fails to play a video.
class PlayVideoException implements Exception {}

/// An exception thrown when the video player fails to pause a video.
class PauseVideoException implements Exception {}

/// An exception thrown when the video player fails to set playback speed.
class SetVideoPlaybackSpeedException implements Exception {}

/// An exception thrown when the video player fails to seek to a position.
class SeekVideoPositionException implements Exception {}

/// {@template video_player_service}
/// A service that provides video player functionality.
///
/// This service uses the `video_player` package.
///
/// ```dart
/// final videoPlayerService = VideoPlayerService(
///  options: VideoPlayerOptions(mixWithOthers: true),
/// );
/// ```
/// {@endtemplate}
class VideoPlayerService {
  /// {@macro video_player_service}
  VideoPlayerService({
    required VideoPlayerOptions options,
  })  : _isServiceUnderTest = false,
        _options = options,
        _controller = null;

  /// A named constructor of [VideoPlayerService] for testing purposes.
  @visibleForTesting
  VideoPlayerService.test({
    required VideoPlayerController controller,
  })  : _isServiceUnderTest = true,
        _options = VideoPlayerOptions(),
        _controller = controller;

  final bool _isServiceUnderTest;
  final VideoPlayerOptions _options;
  VideoPlayerController? _controller;

  /// The current video player controller.
  ///
  /// The controller is being exposed to the outside for the [VideoPlayer]
  /// widget. Please do not use it directly for any other purpose.
  VideoPlayerController? get controller => _controller;

  /// The status of the video player.
  ///
  /// Returns `true` if the video player is loaded and the controller is not
  /// equal to null.
  bool get isVideoPlayerReady => _controller != null;

  /// The current status of the video player.
  bool get isPlaying {
    try {
      return _controller!.value.isPlaying;
    } catch (error, stackTrace) {
      log(
        'Could not get playing status!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  /// The current position of the video.
  ///
  /// Returns [Duration.zero] if the video has not been initialized.
  Duration get position {
    try {
      return _controller!.value.position;
    } catch (error, stackTrace) {
      log(
        'Could not get position!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
      return Duration.zero;
    }
  }

  /// The duration of the video.
  ///
  /// Returns [Duration.zero] if the video has not been initialized.
  Duration get duration {
    try {
      return _controller!.value.duration;
    } catch (error, stackTrace) {
      log(
        'Could not get duration!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
      return Duration.zero;
    }
  }

  /// The current playback speed of the video.
  double get playbackSpeed {
    try {
      return _controller!.value.playbackSpeed;
    } catch (error, stackTrace) {
      log(
        'Could not get playback speed!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
      return 1;
    }
  }

  /// The height of the video.
  ///
  /// Returns `0` if the video has not been initialized.
  double get height {
    try {
      return _controller!.value.size.height;
    } catch (error, stackTrace) {
      log(
        'Could not get height!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
      return 0;
    }
  }

  /// The width of the video.
  ///
  /// Returns `0` if the video has not been initialized.
  double get width {
    try {
      return _controller!.value.size.width;
    } catch (error, stackTrace) {
      log(
        'Could not get width!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
      return 0;
    }
  }

  /// Loads a video from a [file].
  ///
  /// Throws a [LoadVideoException] if the video fails to load.
  Future<void> loadFile(File file, {double volume = 1.0}) async {
    try {
      if (!_isServiceUnderTest) {
        _controller = VideoPlayerController.file(
          file,
          videoPlayerOptions: _options,
        );
      }

      await _controller!.initialize();
      await _controller!.setVolume(volume);
    } catch (error, stackTrace) {
      log(
        'Could not load file!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
      throw LoadVideoException();
    }
  }

  /// Disposes the [VideoPlayerController].
  Future<void> dispose() async {
    try {
      await _controller!.dispose();
    } catch (error, stackTrace) {
      log(
        'Could not dispose controller!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Plays the video.
  ///
  /// Throws a [PlayVideoException] if the video fails to play.
  Future<void> play() async {
    try {
      await _controller!.play();
    } catch (error, stackTrace) {
      log(
        'Could not play the video!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
      throw PlayVideoException();
    }
  }

  /// Pauses the video.
  ///
  /// Throws a [PauseVideoException] if the video fails to pause.
  Future<void> pause() async {
    try {
      await _controller!.pause();
    } catch (error, stackTrace) {
      log(
        'Could not pause the video!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
      throw PauseVideoException();
    }
  }

  /// Sets the playback speed of the video.
  ///
  /// Throws a [SetVideoPlaybackSpeedException] if could not set playback speed.
  Future<void> setPlaybackSpeed(double speed) async {
    try {
      await _controller!.setPlaybackSpeed(speed);
    } catch (error, stackTrace) {
      log(
        'Could not set playback speed!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
      throw SetVideoPlaybackSpeedException();
    }
  }

  /// Seeks to a position in the video.
  ///
  /// Throws a [SeekVideoPositionException] if the video fails to seek.
  Future<void> seekTo(Duration position) async {
    try {
      await _controller!.seekTo(position);
    } catch (error, stackTrace) {
      log(
        'Could not seek to the position!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
      throw SeekVideoPositionException();
    }
  }

  /// Adds a listener to the video player.
  void addListener(VoidCallback listener) {
    try {
      _controller!.addListener(listener);
    } catch (error, stackTrace) {
      log(
        'Could not add listener!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Removes a listener from the video player.
  void removeListener(VoidCallback listener) {
    try {
      _controller!.removeListener(listener);
    } catch (error, stackTrace) {
      log(
        'Could not remove listener!',
        name: '$VideoPlayerService',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
