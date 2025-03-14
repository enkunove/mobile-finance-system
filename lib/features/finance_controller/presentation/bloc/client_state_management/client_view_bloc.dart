import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'client_view_event.dart';
part 'client_view_state.dart';

class ClientViewBloc extends Bloc<ClientViewEvent, ClientViewState> {
  ClientViewBloc() : super(ClientViewInitial()) {
    on<ClientViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
