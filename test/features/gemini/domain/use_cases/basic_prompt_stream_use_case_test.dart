import 'package:test/test.dart';
import 'package:orion_gem_dart_sdk/orion_gem_dart_sdk.dart';
import 'package:mocktail/mocktail.dart';

class MockGeminiChatRepository extends Mock implements GeminiChatRepository {}

class TestException extends BaseException {
  TestException(String message) : super(type: 'test', message: message);
}

void main() {
  late BasicPromptStreamUseCase useCase;
  late MockGeminiChatRepository mockRepository;
  late BasicPromptStreamParams testParams;

  setUp(() {
    mockRepository = MockGeminiChatRepository();
    useCase = BasicPromptStreamUseCase(mockRepository);
    testParams = BasicPromptStreamParams(prompt: 'Test prompt');
  });

  group('BasicPromptStreamUseCase', () {
    test('returns success when repository returns success', () async {
      // Arrange
      final expectedResponse = 'Test response';
      when(
        () => mockRepository.basicPromptStream(testParams),
      ).thenAnswer((_) async => Right(expectedResponse));

      // Act
      final result = await useCase.execute(testParams);

      // Assert
      expect(result, isA<Right<BaseException, String>>());
      expect(result.fold((l) => l, (r) => r), equals(expectedResponse));
      verify(() => mockRepository.basicPromptStream(testParams)).called(1);
    });

    test('returns failure when repository returns failure', () async {
      // Arrange
      final expectedException = TestException('Test error');
      when(
        () => mockRepository.basicPromptStream(testParams),
      ).thenAnswer((_) async => Left(expectedException));

      // Act
      final result = await useCase.execute(testParams);

      // Assert
      expect(result, isA<Left<BaseException, String>>());
      expect(result.fold((l) => l, (r) => ''), equals(expectedException));
      verify(() => mockRepository.basicPromptStream(testParams)).called(1);
    });

    test('passes correct parameters to repository', () async {
      // Arrange
      when(
        () => mockRepository.basicPromptStream(testParams),
      ).thenAnswer((_) async => Right('Response'));

      // Act
      await useCase.execute(testParams);

      // Assert
      verify(() => mockRepository.basicPromptStream(testParams)).called(1);
    });
  });
}
