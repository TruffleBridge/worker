import 'package:dartz/dartz.dart';
import 'package:nimora_worker/core/utils/failures.dart';
import 'package:nimora_worker/domain/model/view_model/onboarding_item_model.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, List<OnboardingItem>>> getOnboardingItems();
  Future<Either<Failure, bool>> hasSeenOnboarding();
  Future<Either<Failure, void>> markOnboardingAsSeen();
}
