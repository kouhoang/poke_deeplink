import 'package:get_it/get_it.dart';
import 'core/network/network_client.dart';
import 'features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'features/pokemon/domain/repositories/pokemon_repository.dart';
import 'features/pokemon/domain/usecases/get_pokemon_by_name.dart';
import 'features/pokemon/domain/usecases/get_pokemon_detail.dart';
import 'features/pokemon/domain/usecases/get_pokemon_list.dart';
import 'features/pokemon/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'features/pokemon/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';

final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // Core
  sl.registerLazySingleton<NetworkClient>(() => NetworkClient());

  // Data sources
  sl.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(networkClient: sl()),
  );

  // Repositories
  sl.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPokemonList(sl()));
  sl.registerLazySingleton(() => GetPokemonDetail(sl()));
  sl.registerLazySingleton(() => GetPokemonByName(sl()));

  // Cubits - Factory pattern for multiple instances
  sl.registerFactory(
    () => PokemonListCubit(getPokemonList: sl()),
  );
  
  sl.registerFactory(
    () => PokemonDetailCubit(
      getPokemonDetail: sl(),
      getPokemonByName: sl(),
    ),
  );
}
