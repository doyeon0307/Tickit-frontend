// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_preview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TicketPreview {
  int get id => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TicketPreviewCopyWith<TicketPreview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketPreviewCopyWith<$Res> {
  factory $TicketPreviewCopyWith(
          TicketPreview value, $Res Function(TicketPreview) then) =
      _$TicketPreviewCopyWithImpl<$Res, TicketPreview>;
  @useResult
  $Res call({int id, String image});
}

/// @nodoc
class _$TicketPreviewCopyWithImpl<$Res, $Val extends TicketPreview>
    implements $TicketPreviewCopyWith<$Res> {
  _$TicketPreviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TicketPreviewImplCopyWith<$Res>
    implements $TicketPreviewCopyWith<$Res> {
  factory _$$TicketPreviewImplCopyWith(
          _$TicketPreviewImpl value, $Res Function(_$TicketPreviewImpl) then) =
      __$$TicketPreviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String image});
}

/// @nodoc
class __$$TicketPreviewImplCopyWithImpl<$Res>
    extends _$TicketPreviewCopyWithImpl<$Res, _$TicketPreviewImpl>
    implements _$$TicketPreviewImplCopyWith<$Res> {
  __$$TicketPreviewImplCopyWithImpl(
      _$TicketPreviewImpl _value, $Res Function(_$TicketPreviewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? image = null,
  }) {
    return _then(_$TicketPreviewImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TicketPreviewImpl implements _TicketPreview {
  const _$TicketPreviewImpl({required this.id, required this.image});

  @override
  final int id;
  @override
  final String image;

  @override
  String toString() {
    return 'TicketPreview(id: $id, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketPreviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketPreviewImplCopyWith<_$TicketPreviewImpl> get copyWith =>
      __$$TicketPreviewImplCopyWithImpl<_$TicketPreviewImpl>(this, _$identity);
}

abstract class _TicketPreview implements TicketPreview {
  const factory _TicketPreview(
      {required final int id,
      required final String image}) = _$TicketPreviewImpl;

  @override
  int get id;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$$TicketPreviewImplCopyWith<_$TicketPreviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
