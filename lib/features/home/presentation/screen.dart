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
      create: (context) => HomeBloc(HomeRepositoryImpl(), HomeState.idle()),
      child: HomeInner()
    );
  }
}

class HomeInner extends StatelessWidget {
const HomeInner({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(
        child: Column(
          children: [
            FilledButton(onPressed: () { context.read<HomeBloc>().add(HomeEvent.makeMain()); }, child: Text('Main')),
            FilledButton(onPressed: () { context.read<HomeBloc>().add(HomeEvent.makePhone()); }, child: Text('Phone')),
            FilledButton(onPressed: () { context.read<HomeBloc>().add(HomeEvent.makeEmail()); }, child: Text('Email')),
          ],
          spacing: 10,
        ),
      );
  }
}
