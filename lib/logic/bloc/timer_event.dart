import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class StartTimer extends TimerEvent {}
class StopTimer extends TimerEvent {}
class ResetTimer extends TimerEvent {}
class Tick extends TimerEvent {
  final int duration;

  const Tick(this.duration);

  @override
  List<Object> get props => [duration];
}
class CaptureHeadshot extends TimerEvent {}
class CaptureScreenshot extends TimerEvent {}