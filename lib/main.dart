import 'package:DiAs/bloc/detail_sdki/detail_sdki_bloc.dart';
import 'package:DiAs/bloc/detail_search/detail_search_bloc.dart';
import 'package:DiAs/bloc/detail_slki/detail_slki_bloc.dart';
import 'package:DiAs/bloc/search/search_bloc.dart';
import 'package:DiAs/bloc/siki/siki_bloc.dart';
import 'package:DiAs/bloc/slki/slki_bloc.dart';
import 'package:DiAs/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/detail_siki/detail_siki_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/login/login_event.dart';
import 'bloc/payment/payment_bloc.dart';
import 'bloc/sdki/sdki_bloc.dart';
import 'services/api_service.dart';
import 'services/auth_checker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final authBloc = AuthBloc(ApiService());
            authBloc.add(AppStartedEvent());
            return authBloc;
          },
        ),
        BlocProvider(
          create: (context) => PaymentBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider<SdkiBloc>(
          create: (context) => SdkiBloc(ApiService()),
        ),
        BlocProvider<SlkiBloc>(
          create: (context) => SlkiBloc(ApiService()),
        ),
        BlocProvider<SikiBloc>(
          create: (context) => SikiBloc(ApiService()),
        ),
        BlocProvider<DetailSdkiBloc>(
          create: (context) => DetailSdkiBloc(ApiService()),
        ),
        BlocProvider<DetailSlkiBloc>(
          create: (context) => DetailSlkiBloc(ApiService()),
        ),
        BlocProvider<DetailSikiBloc>(
          create: (context) => DetailSikiBloc(ApiService()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(ApiService()),
        ),
        BlocProvider<DetailSearchBloc>(
          create: (context) => DetailSearchBloc(ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'DiAs Mobile',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const AuthChecker(),
      ),
    );
  }
}
