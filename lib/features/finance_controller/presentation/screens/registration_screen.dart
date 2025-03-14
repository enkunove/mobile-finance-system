import 'package:finance_system_controller/features/finance_controller/presentation/screens/client_screens/client_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/core/injection_container.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/bloc/registration_state_management/register_bloc.dart';

import '../../domain/usecases/client_usecases/registration_usecase.dart';
import '../../domain/usecases/login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final client = Client(
        _usernameController.text,
        _passwordController.text,
        fullName: _fullNameController.text,
        passportSeriesAndNumber: _passportController.text,
        phone: _phoneController.text,
        email: _emailController.text,
      );
      context.read<RegisterBloc>().add(RegisterClient(client));
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
                    TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(labelText: 'ФИО'),
                      validator: (value) => value!.isEmpty ? 'Введите ФИО' : null,
                    ),
                    TextFormField(
                      controller: _passportController,
                      decoration: const InputDecoration(labelText: 'Серия и номер паспорта'),
                      validator: (value) => value!.isEmpty ? 'Введите паспортные данные' : null,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Телефон'),
                      validator: (value) => value!.isEmpty ? 'Введите номер телефона' : null,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) => value!.isEmpty ? 'Введите email' : null,
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<RegisterBloc, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSuccess) {
                          InjectionContainer.sl.unregister<Client>();
                          InjectionContainer.sl.registerSingleton<Client>(state.client);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const ClientMainScreen()),
                          );
                        } else if (state is RegisterFailure) {
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
                          child: const Text('Зарегистрироваться'),
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
