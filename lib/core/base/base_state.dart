import 'package:pixabay_image_feed/core/enum/state_status.dart';

class BaseState<T> {
  final StateStatus status;
  final T? model;

  BaseState({required this.status, this.model});
}
