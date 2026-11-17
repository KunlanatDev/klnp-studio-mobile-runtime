class RuntimeState {
  const RuntimeState({this.isReady = false});
  final bool isReady;

  RuntimeState copyWith({bool? isReady}) =>
      RuntimeState(isReady: isReady ?? this.isReady);
}
