// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppError {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code, int? statusCode)
    network,
    required TResult Function(String message, String? field) validation,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Object? originalError) unknown,
    required TResult Function(String message) timeout,
    required TResult Function(String message) noInternet,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code, int? statusCode)? network,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Object? originalError)? unknown,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? noInternet,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code, int? statusCode)? network,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Object? originalError)? unknown,
    TResult Function(String message)? timeout,
    TResult Function(String message)? noInternet,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(ValidationError value) validation,
    required TResult Function(AuthError value) auth,
    required TResult Function(UnknownError value) unknown,
    required TResult Function(TimeoutError value) timeout,
    required TResult Function(NoInternetError value) noInternet,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(AuthError value)? auth,
    TResult? Function(UnknownError value)? unknown,
    TResult? Function(TimeoutError value)? timeout,
    TResult? Function(NoInternetError value)? noInternet,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(ValidationError value)? validation,
    TResult Function(AuthError value)? auth,
    TResult Function(UnknownError value)? unknown,
    TResult Function(TimeoutError value)? timeout,
    TResult Function(NoInternetError value)? noInternet,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppErrorCopyWith<AppError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppErrorCopyWith<$Res> {
  factory $AppErrorCopyWith(AppError value, $Res Function(AppError) then) =
      _$AppErrorCopyWithImpl<$Res, AppError>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$AppErrorCopyWithImpl<$Res, $Val extends AppError>
    implements $AppErrorCopyWith<$Res> {
  _$AppErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NetworkErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$NetworkErrorImplCopyWith(
    _$NetworkErrorImpl value,
    $Res Function(_$NetworkErrorImpl) then,
  ) = __$$NetworkErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code, int? statusCode});
}

/// @nodoc
class __$$NetworkErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$NetworkErrorImpl>
    implements _$$NetworkErrorImplCopyWith<$Res> {
  __$$NetworkErrorImplCopyWithImpl(
    _$NetworkErrorImpl _value,
    $Res Function(_$NetworkErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _$NetworkErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$NetworkErrorImpl implements NetworkError {
  const _$NetworkErrorImpl({required this.message, this.code, this.statusCode});

  @override
  final String message;
  @override
  final String? code;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'AppError.network(message: $message, code: $code, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code, statusCode);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkErrorImplCopyWith<_$NetworkErrorImpl> get copyWith =>
      __$$NetworkErrorImplCopyWithImpl<_$NetworkErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code, int? statusCode)
    network,
    required TResult Function(String message, String? field) validation,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Object? originalError) unknown,
    required TResult Function(String message) timeout,
    required TResult Function(String message) noInternet,
  }) {
    return network(message, code, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code, int? statusCode)? network,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Object? originalError)? unknown,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? noInternet,
  }) {
    return network?.call(message, code, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code, int? statusCode)? network,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Object? originalError)? unknown,
    TResult Function(String message)? timeout,
    TResult Function(String message)? noInternet,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message, code, statusCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(ValidationError value) validation,
    required TResult Function(AuthError value) auth,
    required TResult Function(UnknownError value) unknown,
    required TResult Function(TimeoutError value) timeout,
    required TResult Function(NoInternetError value) noInternet,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(AuthError value)? auth,
    TResult? Function(UnknownError value)? unknown,
    TResult? Function(TimeoutError value)? timeout,
    TResult? Function(NoInternetError value)? noInternet,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(ValidationError value)? validation,
    TResult Function(AuthError value)? auth,
    TResult Function(UnknownError value)? unknown,
    TResult Function(TimeoutError value)? timeout,
    TResult Function(NoInternetError value)? noInternet,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkError implements AppError {
  const factory NetworkError({
    required final String message,
    final String? code,
    final int? statusCode,
  }) = _$NetworkErrorImpl;

  @override
  String get message;
  String? get code;
  int? get statusCode;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkErrorImplCopyWith<_$NetworkErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$ValidationErrorImplCopyWith(
    _$ValidationErrorImpl value,
    $Res Function(_$ValidationErrorImpl) then,
  ) = __$$ValidationErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? field});
}

/// @nodoc
class __$$ValidationErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$ValidationErrorImpl>
    implements _$$ValidationErrorImplCopyWith<$Res> {
  __$$ValidationErrorImplCopyWithImpl(
    _$ValidationErrorImpl _value,
    $Res Function(_$ValidationErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? field = freezed}) {
    return _then(
      _$ValidationErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        field: freezed == field
            ? _value.field
            : field // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ValidationErrorImpl implements ValidationError {
  const _$ValidationErrorImpl({required this.message, this.field});

  @override
  final String message;
  @override
  final String? field;

  @override
  String toString() {
    return 'AppError.validation(message: $message, field: $field)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.field, field) || other.field == field));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, field);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationErrorImplCopyWith<_$ValidationErrorImpl> get copyWith =>
      __$$ValidationErrorImplCopyWithImpl<_$ValidationErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code, int? statusCode)
    network,
    required TResult Function(String message, String? field) validation,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Object? originalError) unknown,
    required TResult Function(String message) timeout,
    required TResult Function(String message) noInternet,
  }) {
    return validation(message, field);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code, int? statusCode)? network,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Object? originalError)? unknown,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? noInternet,
  }) {
    return validation?.call(message, field);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code, int? statusCode)? network,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Object? originalError)? unknown,
    TResult Function(String message)? timeout,
    TResult Function(String message)? noInternet,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message, field);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(ValidationError value) validation,
    required TResult Function(AuthError value) auth,
    required TResult Function(UnknownError value) unknown,
    required TResult Function(TimeoutError value) timeout,
    required TResult Function(NoInternetError value) noInternet,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(AuthError value)? auth,
    TResult? Function(UnknownError value)? unknown,
    TResult? Function(TimeoutError value)? timeout,
    TResult? Function(NoInternetError value)? noInternet,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(ValidationError value)? validation,
    TResult Function(AuthError value)? auth,
    TResult Function(UnknownError value)? unknown,
    TResult Function(TimeoutError value)? timeout,
    TResult Function(NoInternetError value)? noInternet,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationError implements AppError {
  const factory ValidationError({
    required final String message,
    final String? field,
  }) = _$ValidationErrorImpl;

  @override
  String get message;
  String? get field;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationErrorImplCopyWith<_$ValidationErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$AuthErrorImplCopyWith(
    _$AuthErrorImpl value,
    $Res Function(_$AuthErrorImpl) then,
  ) = __$$AuthErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code});
}

/// @nodoc
class __$$AuthErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$AuthErrorImpl>
    implements _$$AuthErrorImplCopyWith<$Res> {
  __$$AuthErrorImplCopyWithImpl(
    _$AuthErrorImpl _value,
    $Res Function(_$AuthErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? code = freezed}) {
    return _then(
      _$AuthErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthErrorImpl implements AuthError {
  const _$AuthErrorImpl({required this.message, this.code});

  @override
  final String message;
  @override
  final String? code;

  @override
  String toString() {
    return 'AppError.auth(message: $message, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      __$$AuthErrorImplCopyWithImpl<_$AuthErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code, int? statusCode)
    network,
    required TResult Function(String message, String? field) validation,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Object? originalError) unknown,
    required TResult Function(String message) timeout,
    required TResult Function(String message) noInternet,
  }) {
    return auth(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code, int? statusCode)? network,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Object? originalError)? unknown,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? noInternet,
  }) {
    return auth?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code, int? statusCode)? network,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Object? originalError)? unknown,
    TResult Function(String message)? timeout,
    TResult Function(String message)? noInternet,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(ValidationError value) validation,
    required TResult Function(AuthError value) auth,
    required TResult Function(UnknownError value) unknown,
    required TResult Function(TimeoutError value) timeout,
    required TResult Function(NoInternetError value) noInternet,
  }) {
    return auth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(AuthError value)? auth,
    TResult? Function(UnknownError value)? unknown,
    TResult? Function(TimeoutError value)? timeout,
    TResult? Function(NoInternetError value)? noInternet,
  }) {
    return auth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(ValidationError value)? validation,
    TResult Function(AuthError value)? auth,
    TResult Function(UnknownError value)? unknown,
    TResult Function(TimeoutError value)? timeout,
    TResult Function(NoInternetError value)? noInternet,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(this);
    }
    return orElse();
  }
}

abstract class AuthError implements AppError {
  const factory AuthError({required final String message, final String? code}) =
      _$AuthErrorImpl;

  @override
  String get message;
  String? get code;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$UnknownErrorImplCopyWith(
    _$UnknownErrorImpl value,
    $Res Function(_$UnknownErrorImpl) then,
  ) = __$$UnknownErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Object? originalError});
}

/// @nodoc
class __$$UnknownErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$UnknownErrorImpl>
    implements _$$UnknownErrorImplCopyWith<$Res> {
  __$$UnknownErrorImplCopyWithImpl(
    _$UnknownErrorImpl _value,
    $Res Function(_$UnknownErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? originalError = freezed}) {
    return _then(
      _$UnknownErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        originalError: freezed == originalError
            ? _value.originalError
            : originalError,
      ),
    );
  }
}

/// @nodoc

class _$UnknownErrorImpl implements UnknownError {
  const _$UnknownErrorImpl({required this.message, this.originalError});

  @override
  final String message;
  @override
  final Object? originalError;

  @override
  String toString() {
    return 'AppError.unknown(message: $message, originalError: $originalError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other.originalError,
              originalError,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(originalError),
  );

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownErrorImplCopyWith<_$UnknownErrorImpl> get copyWith =>
      __$$UnknownErrorImplCopyWithImpl<_$UnknownErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code, int? statusCode)
    network,
    required TResult Function(String message, String? field) validation,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Object? originalError) unknown,
    required TResult Function(String message) timeout,
    required TResult Function(String message) noInternet,
  }) {
    return unknown(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code, int? statusCode)? network,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Object? originalError)? unknown,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? noInternet,
  }) {
    return unknown?.call(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code, int? statusCode)? network,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Object? originalError)? unknown,
    TResult Function(String message)? timeout,
    TResult Function(String message)? noInternet,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message, originalError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(ValidationError value) validation,
    required TResult Function(AuthError value) auth,
    required TResult Function(UnknownError value) unknown,
    required TResult Function(TimeoutError value) timeout,
    required TResult Function(NoInternetError value) noInternet,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(AuthError value)? auth,
    TResult? Function(UnknownError value)? unknown,
    TResult? Function(TimeoutError value)? timeout,
    TResult? Function(NoInternetError value)? noInternet,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(ValidationError value)? validation,
    TResult Function(AuthError value)? auth,
    TResult Function(UnknownError value)? unknown,
    TResult Function(TimeoutError value)? timeout,
    TResult Function(NoInternetError value)? noInternet,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownError implements AppError {
  const factory UnknownError({
    required final String message,
    final Object? originalError,
  }) = _$UnknownErrorImpl;

  @override
  String get message;
  Object? get originalError;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownErrorImplCopyWith<_$UnknownErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TimeoutErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$TimeoutErrorImplCopyWith(
    _$TimeoutErrorImpl value,
    $Res Function(_$TimeoutErrorImpl) then,
  ) = __$$TimeoutErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TimeoutErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$TimeoutErrorImpl>
    implements _$$TimeoutErrorImplCopyWith<$Res> {
  __$$TimeoutErrorImplCopyWithImpl(
    _$TimeoutErrorImpl _value,
    $Res Function(_$TimeoutErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$TimeoutErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$TimeoutErrorImpl implements TimeoutError {
  const _$TimeoutErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AppError.timeout(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeoutErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeoutErrorImplCopyWith<_$TimeoutErrorImpl> get copyWith =>
      __$$TimeoutErrorImplCopyWithImpl<_$TimeoutErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code, int? statusCode)
    network,
    required TResult Function(String message, String? field) validation,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Object? originalError) unknown,
    required TResult Function(String message) timeout,
    required TResult Function(String message) noInternet,
  }) {
    return timeout(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code, int? statusCode)? network,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Object? originalError)? unknown,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? noInternet,
  }) {
    return timeout?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code, int? statusCode)? network,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Object? originalError)? unknown,
    TResult Function(String message)? timeout,
    TResult Function(String message)? noInternet,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(ValidationError value) validation,
    required TResult Function(AuthError value) auth,
    required TResult Function(UnknownError value) unknown,
    required TResult Function(TimeoutError value) timeout,
    required TResult Function(NoInternetError value) noInternet,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(AuthError value)? auth,
    TResult? Function(UnknownError value)? unknown,
    TResult? Function(TimeoutError value)? timeout,
    TResult? Function(NoInternetError value)? noInternet,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(ValidationError value)? validation,
    TResult Function(AuthError value)? auth,
    TResult Function(UnknownError value)? unknown,
    TResult Function(TimeoutError value)? timeout,
    TResult Function(NoInternetError value)? noInternet,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class TimeoutError implements AppError {
  const factory TimeoutError({required final String message}) =
      _$TimeoutErrorImpl;

  @override
  String get message;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeoutErrorImplCopyWith<_$TimeoutErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoInternetErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$NoInternetErrorImplCopyWith(
    _$NoInternetErrorImpl value,
    $Res Function(_$NoInternetErrorImpl) then,
  ) = __$$NoInternetErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NoInternetErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$NoInternetErrorImpl>
    implements _$$NoInternetErrorImplCopyWith<$Res> {
  __$$NoInternetErrorImplCopyWithImpl(
    _$NoInternetErrorImpl _value,
    $Res Function(_$NoInternetErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NoInternetErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NoInternetErrorImpl implements NoInternetError {
  const _$NoInternetErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AppError.noInternet(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoInternetErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoInternetErrorImplCopyWith<_$NoInternetErrorImpl> get copyWith =>
      __$$NoInternetErrorImplCopyWithImpl<_$NoInternetErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code, int? statusCode)
    network,
    required TResult Function(String message, String? field) validation,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Object? originalError) unknown,
    required TResult Function(String message) timeout,
    required TResult Function(String message) noInternet,
  }) {
    return noInternet(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code, int? statusCode)? network,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Object? originalError)? unknown,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? noInternet,
  }) {
    return noInternet?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code, int? statusCode)? network,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Object? originalError)? unknown,
    TResult Function(String message)? timeout,
    TResult Function(String message)? noInternet,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(ValidationError value) validation,
    required TResult Function(AuthError value) auth,
    required TResult Function(UnknownError value) unknown,
    required TResult Function(TimeoutError value) timeout,
    required TResult Function(NoInternetError value) noInternet,
  }) {
    return noInternet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(AuthError value)? auth,
    TResult? Function(UnknownError value)? unknown,
    TResult? Function(TimeoutError value)? timeout,
    TResult? Function(NoInternetError value)? noInternet,
  }) {
    return noInternet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(ValidationError value)? validation,
    TResult Function(AuthError value)? auth,
    TResult Function(UnknownError value)? unknown,
    TResult Function(TimeoutError value)? timeout,
    TResult Function(NoInternetError value)? noInternet,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(this);
    }
    return orElse();
  }
}

abstract class NoInternetError implements AppError {
  const factory NoInternetError({required final String message}) =
      _$NoInternetErrorImpl;

  @override
  String get message;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoInternetErrorImplCopyWith<_$NoInternetErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
