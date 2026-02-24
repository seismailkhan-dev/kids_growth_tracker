// // test/features/auth/auth_repository_test.dart
//
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:dartz/dartz.dart';
// import 'package:family_health_tracker/features/auth/data/datasources/auth_remote_datasource.dart';
// import 'package:family_health_tracker/features/auth/data/repositories/auth_repository_impl.dart';
// import 'package:family_health_tracker/features/auth/domain/entities/user_entity.dart';
//
// class MockAuthDataSource extends Mock implements AuthRemoteDataSource {}
//
// void main() {
//   late AuthRepositoryImpl repository;
//   late MockAuthDataSource mockDataSource;
//
//   setUp(() {
//     mockDataSource = MockAuthDataSource();
//     repository = AuthRepositoryImpl(mockDataSource);
//   });
//
//   group('AuthRepository', () {
//     const testUser = UserEntity(
//       uid: 'test-uid-123',
//       email: 'test@example.com',
//       displayName: 'Test User',
//       isPremium: false,
//       createdAt: null,
//     );
//
//     test('login should return UserEntity on success', () async {
//       // Arrange
//       when(mockDataSource.login('test@example.com', 'password123'))
//           .thenAnswer((_) async => testUser);
//
//       // Act
//       final result = await repository.login('test@example.com', 'password123');
//
//       // Assert
//       expect(result, isA<Right<String, UserEntity>>());
//       result.fold(
//         (error) => fail('Should not return error'),
//         (user) {
//           expect(user.uid, equals('test-uid-123'));
//           expect(user.email, equals('test@example.com'));
//         },
//       );
//     });
//
//     test('login should return error string on failure', () async {
//       // Arrange
//       when(mockDataSource.login(any, any))
//           .thenThrow(Exception('user-not-found'));
//
//       // Act
//       final result = await repository.login('bad@email.com', 'wrong');
//
//       // Assert
//       expect(result, isA<Left<String, UserEntity>>());
//       result.fold(
//         (error) => expect(error, contains('No account found')),
//         (_) => fail('Should return error'),
//       );
//     });
//
//     test('signup should create new user entity', () async {
//       // Arrange
//       when(mockDataSource.signup(any, any, any))
//           .thenAnswer((_) async => testUser);
//
//       // Act
//       final result = await repository.signup(
//           'test@example.com', 'password123', 'Test User');
//
//       // Assert
//       expect(result, isA<Right<String, UserEntity>>());
//     });
//   });
// }
//
// // test/features/growth/growth_controller_test.dart
// // Widget test example
