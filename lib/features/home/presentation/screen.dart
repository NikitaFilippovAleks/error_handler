import 'package:error_handler/features/home/data/repositories/home_repository_impl.dart';
import 'package:error_handler/features/home/domain/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            HomeBloc(HomeRepositoryImpl(), HomeState.idle(null)),
        child: HomeInner());
  }
}

class HomeInner extends StatelessWidget {
  const HomeInner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Rectangle(
            isLoading: false,
            data: 'Main data',
            error: 'Error text',
          ),
          FilledButton(
              onPressed: () {
                context.read<HomeBloc>().add(HomeEvent.makePhone());
              },
              child: Text('Phone')),
          FilledButton(
              onPressed: () {
                context.read<HomeBloc>().add(HomeEvent.makeEmail());
              },
              child: Text('Email')),
        ],
        spacing: 10,
      ),
    );
  }
}

class Rectangle extends StatelessWidget {
  Rectangle({super.key, required this.isLoading, this.data, this.error});

  bool isLoading;
  String? data;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(width: 3, color: Color.fromARGB(255, 40, 115, 220))),
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          FilledButton(
              onPressed: () {
                context.read<HomeBloc>().add(HomeEvent.makeMain());
              },
              child: Text('Main')),
          Container(
            width: 160,
            height: 80,
            child: Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('Data: $data'), Text('Error: $error')],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
