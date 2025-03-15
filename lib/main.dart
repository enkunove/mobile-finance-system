
import 'package:finance_system_controller/core/application.dart';
import 'package:finance_system_controller/features/finance_controller/data/datasources/banks_datasource.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/bloc/login_state_management/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/injection_container.dart';
import 'features/finance_controller/presentation/bloc/registration_state_management/register_bloc.dart';

void main() async {
  await InjectionContainer.init();
  WidgetsFlutterBinding.ensureInitialized();

  await InjectionContainer.sl<BanksDatasource>().initBanks();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => InjectionContainer.sl<RegisterBloc>()),
        Provider(create: (_) => InjectionContainer.sl<LoginBloc>()),
      ],
      child: const Application(),
    ),
  );
}
