import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../services/auth_service.dart';
import '../../router/app_router.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthInitialized extends AuthEvent {}

class AuthGenerateOTP extends AuthEvent {
  final String phoneNumber;

  const AuthGenerateOTP(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class AuthVerifyOTP extends AuthEvent {
  final String phoneNumber;
  final String otp;
  final String expectedOTP;

  const AuthVerifyOTP({
    required this.phoneNumber,
    required this.otp,
    required this.expectedOTP,
  });

  @override
  List<Object?> get props => [phoneNumber, otp, expectedOTP];
}

class AuthEmailLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthEmailLogin({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthLogout extends AuthEvent {}

class AuthClearData extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthOTPSent extends AuthState {
  final String phoneNumber;
  final String generatedOTP;

  const AuthOTPSent({
    required this.phoneNumber,
    required this.generatedOTP,
  });

  @override
  List<Object?> get props => [phoneNumber, generatedOTP];
}

class AuthAuthenticated extends AuthState {
  final String userId;
  final String phoneNumber;
  final String? email;

  const AuthAuthenticated({
    required this.userId,
    required this.phoneNumber,
    this.email,
  });

  @override
  List<Object?> get props => [userId, phoneNumber, email];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc({required AuthService authService})
      : _authService = authService,
        super(AuthInitial()) {
    on<AuthInitialized>(_onAuthInitialized);
    on<AuthGenerateOTP>(_onAuthGenerateOTP);
    on<AuthVerifyOTP>(_onAuthVerifyOTP);
    on<AuthEmailLogin>(_onAuthEmailLogin);
    on<AuthLogout>(_onAuthLogout);
    on<AuthClearData>(_onAuthClearData);
  }

  Future<void> _onAuthInitialized(
    AuthInitialized event,
    Emitter<AuthState> emit,
  ) async {
    print('AuthBloc: Initializing authentication...');
    emit(AuthLoading());
    
    try {
      final isLoggedIn = await _authService.isLoggedIn();
      print('AuthBloc: isLoggedIn = $isLoggedIn');
      
      if (isLoggedIn) {
        final userId = await _authService.getUserId();
        final phoneNumber = await _authService.getUserPhone();
        print('AuthBloc: User is logged in - userId: $userId, phone: $phoneNumber');
        emit(AuthAuthenticated(
          userId: userId ?? '',
          phoneNumber: phoneNumber ?? '',
        ));
      } else {
        print('AuthBloc: User is not logged in, emitting unauthenticated');
        emit(AuthUnauthenticated());
      }
      
      // Trigger router refresh after state change
      AppRouter.refreshNotifier.refresh();
    } catch (e) {
      print('AuthBloc: Error during initialization - $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthGenerateOTP(
    AuthGenerateOTP event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      final generatedOTP = await _authService.generateOTP();
      emit(AuthOTPSent(
        phoneNumber: event.phoneNumber,
        generatedOTP: generatedOTP,
      ));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthVerifyOTP(
    AuthVerifyOTP event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      final success = await _authService.verifyOTP(
        event.phoneNumber,
        event.otp,
        event.expectedOTP,
      );
      
      if (success) {
        final userId = await _authService.getUserId();
        final phoneNumber = await _authService.getUserPhone();
        emit(AuthAuthenticated(
          userId: userId ?? '',
          phoneNumber: phoneNumber ?? '',
        ));
      } else {
        emit(const AuthError('Invalid OTP'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthEmailLogin(
    AuthEmailLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      final success = await _authService.verifyEmailLogin(
        event.email,
        event.password,
      );
      
      if (success) {
        final userId = await _authService.getUserId();
        final email = await _authService.getUserEmail();
        emit(AuthAuthenticated(
          userId: userId ?? '',
          phoneNumber: '', // Empty for email login
          email: email,
        ));
      } else {
        emit(const AuthError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthLogout(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      await _authService.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthClearData(
    AuthClearData event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      await _authService.clearAllData();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
} 