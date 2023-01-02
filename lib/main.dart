import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/home/home.dart';
import './screens/counter/counter.dart';
import 'app/app.dart';

void main() {
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.deepPurple,
    ),
    routerConfig: GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
            builder: (context, state, child) => App(body: child),
            routes: <GoRoute>[
              GoRoute(
                name: 'home',
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
              GoRoute(
                  path: '/counter',
                  builder: (context, state) {
                    return Counter(
                        time: state.queryParams['time'] as String,
                        interval: state.queryParams['interval'] as String);
                  }),
            ]),
      ],
    ),
  ));
}
