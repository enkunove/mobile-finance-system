import 'package:finance_system_controller/features/finance_controller/presentation/bloc/login_state_management/login_bloc.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/screens/client_screens/client_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/core/injection_container.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/bloc/registration_state_management/register_bloc.dart';

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
      final String username =
        _usernameController.text;
      final String password = _passwordController.text;
      context.read<LoginBloc>().add(LoginClient(username, password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: BlocProvider(
        create: (_) => RegisterBloc(
          registerUsecase: InjectionContainer.sl<RegisterUsecase>(),
          loginUsecase: InjectionContainer.sl<LoginUsecase>(),
        ),        child: Builder(
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
                    validator: (value) => value!.isEmpty ? 'Введите логин' : null,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Пароль'),
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? 'Введите пароль' : null,
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        InjectionContainer.sl.unregister<Client>();
                        InjectionContainer.sl.registerSingleton<Client>(state.client);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const ClientMainScreen()),
                        );
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
