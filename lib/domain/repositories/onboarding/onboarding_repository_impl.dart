import 'package:dartz/dartz.dart';
import 'package:nimora_worker/core/constants/assets_images.dart';
import 'package:nimora_worker/domain/model/view_model/onboarding_item_model.dart';
import 'package:nimora_worker/domain/repositories/onboarding/onboarding_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/failures.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  static const _seenKey = 'onboarding_seen';

  final SharedPreferences sharedPreferences;

  const OnboardingRepositoryImpl({required this.sharedPreferences});

  @override
  Future<Either<Failure, List<OnboardingItem>>> getOnboardingItems() async {
    try {
      const items = [
        OnboardingItem(
          imagePath: AssetJPGImages.onboarding1,
          title: 'Search Job Easier and More Effective',
          subtitle: 'Help you find the perfect job near from your location',
        ),
        OnboardingItem(
          imagePath: AssetJPGImages.onboarding2,
          title: 'Apply for job anywhere & anytime',
          subtitle: 'Help you find the perfect job near from your location',
        ),
        OnboardingItem(
          imagePath: AssetJPGImages.onboarding3,
          title: 'Your dream job is waiting for you!',
          subtitle: 'Help you find the perfect job near from your location',
        ),
      ];
      return const Right(items);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> hasSeenOnboarding() async {
    try {
      final seen = sharedPreferences.getBool(_seenKey) ?? false;
      return Right(seen);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markOnboardingAsSeen() async {
    try {
      await sharedPreferences.setBool(_seenKey, true);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
