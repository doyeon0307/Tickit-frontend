// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CalendarState {
  dynamic get loadingCalendar => throw _privateConstructorUsedError;
  List<Map<String, List<SchedulePreviewModel>>> get schedules =>
      throw _privateConstructorUsedError;
  DateTime get selectedDate => throw _privateConstructorUsedError;
  DateTime get today => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  String get errorMsg => throw _privateConstructorUsedError;
  String get successMsg => throw _privateConstructorUsedError;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarStateCopyWith<CalendarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarStateCopyWith<$Res> {
  factory $CalendarStateCopyWith(
          CalendarState value, $Res Function(CalendarState) then) =
      _$CalendarStateCopyWithImpl<$Res, CalendarState>;
  @useResult
  $Res call(
      {dynamic loadingCalendar,
      List<Map<String, List<SchedulePreviewModel>>> schedules,
      DateTime selectedDate,
      DateTime today,
      int currentIndex,
      String errorMsg,
      String successMsg});
}

/// @nodoc
class _$CalendarStateCopyWithImpl<$Res, $Val extends CalendarState>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingCalendar = freezed,
    Object? schedules = null,
    Object? selectedDate = null,
    Object? today = null,
    Object? currentIndex = null,
    Object? errorMsg = null,
    Object? successMsg = null,
  }) {
    return _then(_value.copyWith(
      loadingCalendar: freezed == loadingCalendar
          ? _value.loadingCalendar
          : loadingCalendar // ignore: cast_nullable_to_non_nullable
              as dynamic,
      schedules: null == schedules
          ? _value.schedules
          : schedules // ignore: cast_nullable_to_non_nullable
              as List<Map<String, List<SchedulePreviewModel>>>,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      today: null == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      errorMsg: null == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
      successMsg: null == successMsg
          ? _value.successMsg
          : successMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarStateImplCopyWith<$Res>
    implements $CalendarStateCopyWith<$Res> {
  factory _$$CalendarStateImplCopyWith(
          _$CalendarStateImpl value, $Res Function(_$CalendarStateImpl) then) =
      __$$CalendarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic loadingCalendar,
      List<Map<String, List<SchedulePreviewModel>>> schedules,
      DateTime selectedDate,
      DateTime today,
      int currentIndex,
      String errorMsg,
      String successMsg});
}

/// @nodoc
class __$$CalendarStateImplCopyWithImpl<$Res>
    extends _$CalendarStateCopyWithImpl<$Res, _$CalendarStateImpl>
    implements _$$CalendarStateImplCopyWith<$Res> {
  __$$CalendarStateImplCopyWithImpl(
      _$CalendarStateImpl _value, $Res Function(_$CalendarStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingCalendar = freezed,
    Object? schedules = null,
    Object? selectedDate = null,
    Object? today = null,
    Object? currentIndex = null,
    Object? errorMsg = null,
    Object? successMsg = null,
  }) {
    return _then(_$CalendarStateImpl(
      loadingCalendar: freezed == loadingCalendar
          ? _value.loadingCalendar!
          : loadingCalendar,
      schedules: null == schedules
          ? _value._schedules
          : schedules // ignore: cast_nullable_to_non_nullable
              as List<Map<String, List<SchedulePreviewModel>>>,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      today: null == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      errorMsg: null == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
      successMsg: null == successMsg
          ? _value.successMsg
          : successMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CalendarStateImpl implements _CalendarState {
  const _$CalendarStateImpl(
      {this.loadingCalendar = LoadingStatus.none,
      final List<Map<String, List<SchedulePreviewModel>>> schedules = const [],
      required this.selectedDate,
      required this.today,
      this.currentIndex = 0,
      this.errorMsg = "",
      this.successMsg = ""})
      : _schedules = schedules;

  @override
  @JsonKey()
  final dynamic loadingCalendar;
  final List<Map<String, List<SchedulePreviewModel>>> _schedules;
  @override
  @JsonKey()
  List<Map<String, List<SchedulePreviewModel>>> get schedules {
    if (_schedules is EqualUnmodifiableListView) return _schedules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_schedules);
  }

  @override
  final DateTime selectedDate;
  @override
  final DateTime today;
  @override
  @JsonKey()
  final int currentIndex;
  @override
  @JsonKey()
  final String errorMsg;
  @override
  @JsonKey()
  final String successMsg;

  @override
  String toString() {
    return 'CalendarState(loadingCalendar: $loadingCalendar, schedules: $schedules, selectedDate: $selectedDate, today: $today, currentIndex: $currentIndex, errorMsg: $errorMsg, successMsg: $successMsg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarStateImpl &&
            const DeepCollectionEquality()
                .equals(other.loadingCalendar, loadingCalendar) &&
            const DeepCollectionEquality()
                .equals(other._schedules, _schedules) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.today, today) || other.today == today) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg) &&
            (identical(other.successMsg, successMsg) ||
                other.successMsg == successMsg));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(loadingCalendar),
      const DeepCollectionEquality().hash(_schedules),
      selectedDate,
      today,
      currentIndex,
      errorMsg,
      successMsg);

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarStateImplCopyWith<_$CalendarStateImpl> get copyWith =>
      __$$CalendarStateImplCopyWithImpl<_$CalendarStateImpl>(this, _$identity);
}

abstract class _CalendarState implements CalendarState {
  const factory _CalendarState(
      {final dynamic loadingCalendar,
      final List<Map<String, List<SchedulePreviewModel>>> schedules,
      required final DateTime selectedDate,
      required final DateTime today,
      final int currentIndex,
      final String errorMsg,
      final String successMsg}) = _$CalendarStateImpl;

  @override
  dynamic get loadingCalendar;
  @override
  List<Map<String, List<SchedulePreviewModel>>> get schedules;
  @override
  DateTime get selectedDate;
  @override
  DateTime get today;
  @override
  int get currentIndex;
  @override
  String get errorMsg;
  @override
  String get successMsg;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarStateImplCopyWith<_$CalendarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
