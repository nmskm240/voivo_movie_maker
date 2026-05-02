import 'package:flutter/material.dart';

import '../models/timeline.dart';

final mockProject = Project(
  id: 'project-001',
  name: 'テキスト編集サンプル',
  filePath: null,
  settings: const ProjectSettings(
    width: 1920,
    height: 1080,
    fps: 30,
    sampleRate: 48000,
    backgroundColor: Color(0xff20262b),
  ),
  timeline: const Timeline(
    durationFrames: 1200,
    tracks: [
      TimelineTrack(
        id: 'track-text-main',
        name: 'Text',
        type: TrackType.text,
        clips: [
          TextClip(
            id: 'clip-title',
            name: 'タイトル',
            startFrame: 120,
            durationFrames: 240,
            transform: ClipTransform(
              x: 0.5,
              y: 0.28,
              scale: 1,
              rotation: 0,
              opacity: 1,
            ),
            text: 'Voivo Movie Maker',
            fontFamily: 'Noto Sans CJK JP',
            fontSize: 64,
            textColor: Color(0xffffcf5c),
            effects: [
              FadeEffect(
                id: 'effect-title-fade-in',
                startOffsetFrames: 0,
                durationFrames: 18,
                direction: FadeDirection.fadeIn,
              ),
            ],
          ),
          TextClip(
            id: 'clip-subtitle',
            name: '字幕: こんにちは',
            startFrame: 480,
            durationFrames: 330,
            transform: ClipTransform(
              x: 0.5,
              y: 0.82,
              scale: 1,
              rotation: 0,
              opacity: 1,
            ),
            text: 'こんにちは、動画編集をはじめよう',
            fontFamily: 'Noto Sans CJK JP',
            fontSize: 42,
            textColor: Color(0xffffffff),
            effects: [
              FadeEffect(
                id: 'effect-subtitle-fade-out',
                startOffsetFrames: 300,
                durationFrames: 30,
                direction: FadeDirection.fadeOut,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  createdAt: DateTime(2026, 5, 2),
  updatedAt: DateTime(2026, 5, 2),
);
