// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'repositories/data_repository.dart' as _i3;
import 'repositories/firebase_repository.dart' as _i4;
import 'repositories/supabase_repository.dart' as _i5;
import 'storage/app_preference.dart' as _i6;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.DataRepository>(() => _i3.DataRepository());
  gh.lazySingleton<_i4.FirebaseRepository>(() => _i4.FirebaseRepository());
  gh.lazySingleton<_i5.SupabaseRepository>(() => _i5.SupabaseRepository());
  gh.lazySingleton<_i6.AppPreference>(() => _i6.AppPreference());
  return getIt;
}
