import 'package:finance_system_controller/features/finance_controller/domain/entities/enterprise.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/externalspecialist.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/screens/client_screens/await_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/core/injection_container.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/bloc/registration_state_management/register_bloc.dart';

import '../../../domain/usecases/externalspecialist_usecases/enterprises_usecases.dart';
import '../../../domain/usecases/login_usecases.dart';
import '../../../domain/usecases/registration_usecase.dart';

class ExternalSpecialistRegistrationScreen extends StatefulWidget {
  const ExternalSpecialistRegistrationScreen({super.key});

  @override
  State<ExternalSpecialistRegistrationScreen> createState() => _ExternalSpecialistRegistrationScreenState();
}

class _ExternalSpecialistRegistrationScreenState extends State<ExternalSpecialistRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _bicController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final client = ExternalSpecialist(
          username: _usernameController.text,
          password: _passwordController.text,
          fullName: _fullNameController.text,
          passportSeriesAndNumber: _passportController.text,
          idNumber: 0,
          phone: _phoneController.text,
          email: _emailController.text,
          isApproved: false,
          role: 'ExternalSpecialist'
      );
      context.read<RegisterBloc>().add(RegisterClient(client));
    }
  }

  void _registerEnterprise(BuildContext context){
    if (_formKey.currentState!.validate()) {
      final enterprise = Enterprise(type: _typeController.text, pin: _pinController.text, address: _addressController.text, name: _nameController.text, bic: _bicController.text);
      context.read<RegisterBloc>().add(RegisterEnterprise(enterprise));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => RegisterBloc(
          registerUsecase: InjectionContainer.sl<RegisterUsecase>(),
          loginUsecase: InjectionContainer.sl<LoginUsecase>(),
          bankManagementUsecases: InjectionContainer.sl<EnterprisesUsecases>(),
        ),
        child: Builder(
          builder: (context) {
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: Form(
                  key: _formKey,
                  child: ListView(
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
                      TextFormField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(labelText: 'ФИО'),
                        validator: (value) =>
                        value!.isEmpty ? 'Введите ФИО' : null,
                      ),
                      TextFormField(
                        controller: _passportController,
                        decoration: const InputDecoration(
                            labelText: 'Серия и номер паспорта'),
                        validator: (value) =>
                        value!.isEmpty ? 'Введите паспортные данные' : null,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(labelText: 'Телефон'),
                        validator: (value) =>
                        value!.isEmpty ? 'Введите номер телефона' : null,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) =>
                        value!.isEmpty ? 'Введите email' : null,
                      ),
                      const SizedBox(height: 20),
                      const Text("Информация по вашему предприятию:", style: TextStyle(fontSize: 16),),
                      TextFormField(
                        controller: _typeController,
                        decoration: const InputDecoration(labelText: 'Тип'),
                        obscureText: true,
                        validator: (value) =>
                        value!.isEmpty ? 'Введите тип' : null,
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Название'),
                        validator: (value) =>
                        value!.isEmpty ? 'Введите название' : null,
                      ),
                      TextFormField(
                        controller: _bicController,
                        decoration: const InputDecoration(
                            labelText: 'BIC'),
                        validator: (value) =>
                        value!.isEmpty ? 'Введите BIC' : null,
                      ),
                      TextFormField(
                        controller: _pinController,
                        decoration: const InputDecoration(labelText: 'PIN'),
                        validator: (value) =>
                        value!.isEmpty ? 'Введите PIN' : null,
                      ),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(labelText: 'Юр. адрес'),
                        validator: (value) =>
                        value!.isEmpty ? 'Введите адрес' : null,
                      ),
                      const SizedBox(height: 20),
                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            InjectionContainer.sl.unregister<Client>();
                            InjectionContainer.sl
                                .registerSingleton<Client>(state.client);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AwaitConfirmationScreen()),
                            );
                          } else if (state is RegisterFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ElevatedButton(
                            onPressed: () {
                              _register(context);
                              _registerEnterprise(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.blueAccent,
                            ),
                            child: const Text('Зарегистрироваться', style: TextStyle(color: Colors.black),),
                          );
                        },
                      ),
                    ],
                  ),
                ),)
            );
          },
        ),
      ),
    );
  }
}
