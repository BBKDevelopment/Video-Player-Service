// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_service/video_player_service.dart';

void main() {
  group('VideoPlayerService', () {
    test('can be instantiated', () {
      expect(VideoPlayerService(options: VideoPlayerOptions()), isNotNull);
    });
  });
}
