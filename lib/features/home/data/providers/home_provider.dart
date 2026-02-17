import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/home/data/repositories/home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});
