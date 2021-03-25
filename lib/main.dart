import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:twelve_weeks/repostitory/project/model/db_project.dart';
import 'package:twelve_weeks/repostitory/project/project_data_source.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:twelve_weeks/screens/create/bloc/dates/set_dates_bloc.dart';
import 'package:twelve_weeks/screens/create/bloc/goals/add_goals_bloc.dart';
import 'package:twelve_weeks/screens/create/bloc/strategies/add_strategies_bloc.dart';
import 'package:twelve_weeks/screens/main/main.dart';

import 'generated/l10n.dart';

void main() async {
  await Hive.initFlutter();
  final projectBox = await Hive.openBox<DBProject>('Project');
  runApp(MyApp(projectBox: projectBox));
}

class MyApp extends StatelessWidget {
  final Box<DBProject> projectBox;

  const MyApp({Key key, @required this.projectBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<ProjectRepository>(
            create: (_) => ProjectRepository(
                dataSource: ProjectDataSource(this.projectBox)),
          ),
          ChangeNotifierProxyProvider<ProjectRepository, SetDatesBloc>(
              create: (context) => SetDatesBloc(),
              update: (context, repository, bloc) {
                if(bloc == null) throw ArgumentError.notNull('bloc');
                bloc.projectRepository = repository;
                return bloc;
              }
          ),
          ChangeNotifierProxyProvider<ProjectRepository, AddGoalsBloc>(
              create: (context) => AddGoalsBloc(),
              update: (context, repository, bloc) {
                if(bloc == null) throw ArgumentError.notNull('bloc');
                bloc.projectRepository = repository;
                return bloc;
              }
          ),
          ChangeNotifierProxyProvider<ProjectRepository, AddStrategiesBloc>(
              create: (context) => AddStrategiesBloc(),
              update: (context, repository, bloc) {
                if(bloc == null) throw ArgumentError.notNull('bloc');
                bloc.projectRepository = repository;
                return bloc;
              }
          )
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Main(title: 'Flutter Demo Home Page'),
            localizationsDelegates: [
              // ... app-specific localization delegate[s] here[
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate
            ],
            supportedLocales: S.delegate.supportedLocales));
  }
}
