// ignore_for_file: cascade_invocations

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_service/video_player_service.dart';

/// A mock class of [VideoPlayerController].
class _MockVideoPlayerController extends Mock
    implements VideoPlayerController {}

void main() {
  late VideoPlayerService sut;

  setUp(() {
    sut = VideoPlayerService(options: VideoPlayerOptions());
  });

  group('VideoPlayerService', () {
    test('can be instantiated', () {
      expect(VideoPlayerService(options: VideoPlayerOptions()), isNotNull);
    });

    test('can provide a controller', () {
      expect(sut.controller, isNull);
    });

    test('can provide status of the video player', () {
      expect(sut.isReady, false);
    });

    test('can provide current status of the video player', () {
      expect(sut.isPlaying, false);
    });

    test('can provide current position of the video', () {
      expect(sut.position, Duration.zero);
    });

    test('can provide duration of the video', () {
      expect(sut.duration, Duration.zero);
    });

    test('can provide playback speed of the video', () {
      expect(sut.playbackSpeed, 1);
    });

    test('can provide height detail of the video', () {
      expect(sut.height, 0);
    });

    test('can provide width detail of the video', () {
      expect(sut.width, 0);
    });

    test('can load a video from file', () async {
      final controller = _MockVideoPlayerController();
      final videoPlayerService = VideoPlayerService.test(
        controller: controller,
      );

      when(controller.initialize).thenAnswer((_) => Future.value());
      when(() => controller.setVolume(any())).thenAnswer((_) => Future.value());

      await videoPlayerService.loadFile(File(''));

      verify(controller.initialize).called(1);
      verify(() => controller.setVolume(any())).called(1);
    });

    test('can throw LoadVideoException while loading a video from file', () {
      expect(
        sut.loadFile(File('')),
        throwsA(isA<LoadVideoException>()),
      );
    });

    test('can dispose the video player controller', () {
      expect(sut.dispose(), isA<Future<void>>());
    });

    test('can throw PlayVideoException while trying to play a video', () {
      expect(sut.play(), throwsA(isA<PlayVideoException>()));
    });

    test('can throw PauseVideoException while trying to pause a video', () {
      expect(sut.pause(), throwsA(isA<PauseVideoException>()));
    });

    test(
        'can throw SetVideoPlaybackSpeedException while setting the playback '
        'speed', () {
      expect(
        sut.setPlaybackSpeed(2),
        throwsA(isA<SetVideoPlaybackSpeedException>()),
      );
    });

    test(
        'can throw SeekVideoPositionException while trying to seek the video '
        'position', () {
      expect(
        sut.seekTo(Duration.zero),
        throwsA(isA<SeekVideoPositionException>()),
      );
    });

    test('can add listener to the video player', () {
      final controller = _MockVideoPlayerController();
      final videoPlayerService = VideoPlayerService.test(
        controller: controller,
      );

      when(() => controller.addListener(any())).thenThrow(Exception());

      videoPlayerService.addListener(any);

      verify(() => controller.addListener(any())).called(1);
    });

    test('can remove listener from the video player', () {
      final controller = _MockVideoPlayerController();
      final videoPlayerService = VideoPlayerService.test(
        controller: controller,
      );

      when(() => controller.removeListener(any())).thenThrow(Exception());

      videoPlayerService.removeListener(any);

      verify(() => controller.removeListener(any())).called(1);
    });
  });
}
