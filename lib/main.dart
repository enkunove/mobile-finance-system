import 'dart:developer';

import 'package:finance_system_controller/core/application.dart';
import 'package:finance_system_controller/features/finance_controller/data/datasources/clients_datasource.dart';
import 'package:finance_system_controller/features/finance_controller/data/models/system_users/client_model.dart';
import 'package:finance_system_controller/features/finance_controller/data/repositories/account_repository_impl.dart';
import 'package:finance_system_controller/features/finance_controller/data/repositories/system_users/client_repository_impl.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/account.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/bank.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/system_users/client_repository.dart';
import 'package:finance_system_controller/features/finance_controller/domain/usecases/client_usecases/account_management_usecases.dart';
import 'package:finance_system_controller/features/finance_controller/domain/usecases/client_usecases/registration_usecase.dart';
import 'package:finance_system_controller/features/finance_controller/domain/usecases/login.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/bloc/login_state_management/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'core/injection_container.dart';
import 'features/finance_controller/data/datasources/accounts_datasourse.dart';
import 'features/finance_controller/domain/entities/system_users/client.dart';
import 'features/finance_controller/presentation/bloc/registration_state_management/register_bloc.dart';

void main() async {
  await InjectionContainer.init();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => InjectionContainer.sl<RegisterBloc>()),
        Provider(create: (_) => InjectionContainer.sl<LoginBloc>()),
      ],
      child: Application(),
    ),
  );
}
