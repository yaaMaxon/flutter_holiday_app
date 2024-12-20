import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/cache_service.dart';

abstract class UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final Map<String, dynamic> user;

  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

class UserCubit extends Cubit<UserState> {
  final CacheService cacheService;

  UserCubit(this.cacheService) : super(UserLoading());

  Future<void> initializeUser() async {
    emit(UserLoading());
    try {
      final cachedUser = await cacheService.getUser();
      if (cachedUser != null) {
        emit(UserLoaded(cachedUser));
      } else {
        emit(UserError("No cached user found"));
      }
    } catch (e) {
      emit(UserError("Failed to load user data: $e"));
    }
  }

  Future<void> updateUserName(String newName) async {
    try {
      if (state is UserLoaded) {
        final currentUser = (state as UserLoaded).user;
        final updatedUser = {...currentUser, 'name': newName};

        await cacheService.saveUser(updatedUser);

        emit(UserLoaded(updatedUser));
      }
    } catch (e) {
      emit(UserError("Failed to update user name: $e"));
    }
  }

  Future<void> updateUserEmail(String newEmail) async {
    try {
      if (state is UserLoaded) {
        final currentUser = (state as UserLoaded).user;
        final updatedUser = {...currentUser, 'email': newEmail};

        await cacheService.saveUser(updatedUser);

        emit(UserLoaded(updatedUser));
      }
    } catch (e) {
      emit(UserError("Failed to update user email: $e"));
    }
  }

  Future<void> logout() async {
    try {
      await cacheService.clearUser();
      emit(UserLoading());
    } catch (e) {
      emit(UserError("Failed to logout: $e"));
    }
  }

  Future<void> deleteAccount() async {
    try {
      await cacheService.clearUser();
      emit(UserLoading());
    } catch (e) {
      emit(UserError("Failed to delete account: $e"));
    }
  }
}
