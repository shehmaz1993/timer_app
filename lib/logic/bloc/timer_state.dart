import 'dart:io';

import 'package:equatable/equatable.dart';

class TimerState extends Equatable {
  final int duration;
  final File? headshot;
  final File? screenshot;

  const TimerState({required this.duration,this.headshot,this.screenshot});

  @override
  List<Object> get props => [duration];

  String get formattedDuration {
    final minutes = ((duration ~/ 60) % 60).toString().padLeft(2, '0');
    final seconds = (duration % 60).toString().padLeft(2, '0');
    final hours = (duration ~/ 3600).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
  TimerState copyWith({
    int? duration,
    File? headshot,
    File? screenshot,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      headshot: headshot ?? this.headshot,
      screenshot: screenshot ?? this.screenshot,
    );
  }
}