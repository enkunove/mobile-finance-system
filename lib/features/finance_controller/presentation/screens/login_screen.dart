import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/manager.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/operator.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/bloc/login_state_management/login_bloc.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/screens/client_screens/await_confirmation_screen.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/screens/client_screens/client_main_screen.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/screens/manager_screens/manager_main_screen.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/screens/manager_screens/registration_confirmer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/core/injection_container.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/bloc/registration_state_management/register_bloc.dart';

import '../../data/models/system_users/manager_model.dart';
import '../../data/models/system_users/operator_model.dart';
import '../../domain/usecases/client_usecases/registration_usecase.dart';
import '../../domain/usecases/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final String username = _usernameController.text;
      final String password = _passwordController.text;
      context.read<LoginBloc>().add(LoginClient(username, password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => RegisterBloc(
          registerUsecase: InjectionContainer.sl<RegisterUsecase>(),
          loginUsecase: InjectionContainer.sl<LoginUsecase>(),
        ),
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: 'Логин'),
                      validator: (value) =>
                          value!.isEmpty ? 'Введите логин' : null,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Пароль'),
                      obscureText: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Введите пароль' : null,
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          if (state.user is Client) {
                            InjectionContainer.sl.unregister<Client>();
                            InjectionContainer.sl
                                .registerSingleton<Client>(state.user);
                            if (state.user.isApproved == false) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const AwaitConfirmationScreen()),
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ClientMainScreen()),
                              );
                            }
                          }
                          if (state.user is ManagerModel){
                            InjectionContainer.sl.unregister<Manager>();
                            InjectionContainer.sl
                                .registerSingleton<Manager>(state.user);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ManagerMainScreen()),
                            );
                          }
                          if (state.user is OperatorModel){
                            InjectionContainer.sl.unregister<Manager>();
                            InjectionContainer.sl
                                .registerSingleton<Manager>(state.user);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ManagerMainScreen()),
                            );
                          }
                        } else if (state is LoginFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is RegisterLoading) {
                          return const CircularProgressIndicator();
                        }
                        return ElevatedButton(
                          onPressed: () => _register(context),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: const Text('Войти'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
