import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'portfolio_app.dart';

void main() {
  // BlocObserver only runs in debug mode — no console noise in production.
  assert(() {
    Bloc.observer = MyBlocObserver();
    return true;
  }());
  runApp(const PortfolioApp());
}
