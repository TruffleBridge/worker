import 'package:dartz/dartz.dart';
import 'package:nimora_worker/core/utils/failures.dart';
import 'package:nimora_worker/domain/model/view_model/onboarding_item_model.dart';
import 'package:nimora_worker/domain/repositories/onboarding/onboarding_repository.dart';

import '../../../../core/utils/use_case.dart';

class GetOnboardingItemsUseCase
    implements UseCase<List<OnboardingItem>, NoParams> {
  final OnboardingRepository repository;
  const GetOnboardingItemsUseCase(this.repository);

  @override
  Future<Either<Failure, List<OnboardingItem>>> call(NoParams params) {
    return repository.getOnboardingItems();
  }
}

class HasSeenOnboardingUseCase implements UseCase<bool, NoParams> {
  final OnboardingRepository repository;
  const HasSeenOnboardingUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.hasSeenOnboarding();
  }
}

class MarkOnboardingAsSeenUseCase implements UseCase<void, NoParams> {
  final OnboardingRepository repository;
  const MarkOnboardingAsSeenUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.markOnboardingAsSeen();
  }
}
