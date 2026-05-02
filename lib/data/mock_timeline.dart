import 'package:flutter/material.dart';

import '../models/timeline.dart';

const mockTimelineTracks = [
  TimelineTrack(
    name: 'Video 1',
    icon: Icons.movie_outlined,
    clips: [
      TimelineClip(
        title: 'opening.mp4',
        start: 0.04,
        width: 0.28,
        color: Color(0xff4fb5ff),
      ),
      TimelineClip(
        title: 'talk_scene.mp4',
        start: 0.36,
        width: 0.32,
        color: Color(0xff65d692),
      ),
    ],
  ),
  TimelineTrack(
    name: 'Text',
    icon: Icons.title,
    clips: [
      TimelineClip(
        title: 'タイトル',
        start: 0.12,
        width: 0.24,
        color: Color(0xffffcf5c),
      ),
      TimelineClip(
        title: '字幕: こんにちは',
        start: 0.43,
        width: 0.27,
        color: Color(0xffffa24f),
      ),
    ],
  ),
  TimelineTrack(
    name: 'Voice',
    icon: Icons.record_voice_over_outlined,
    clips: [
      TimelineClip(
        title: 'ずんだもん_001.wav',
        start: 0.39,
        width: 0.23,
        color: Color(0xffc08bff),
      ),
    ],
  ),
  TimelineTrack(
    name: 'SE',
    icon: Icons.graphic_eq,
    clips: [
      TimelineClip(
        title: '決定音.wav',
        start: 0.67,
        width: 0.13,
        color: Color(0xffff6f91),
      ),
    ],
  ),
];
