import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spotify_dribble/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:spotify_dribble/core/auth/presentation/cubit/auth_states.dart';
import 'package:spotify_dribble/features/home/presentation/pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        if (state is Authenticated) {
          return HomePage(user: state.user);
        } else if (state is AuthError) {
          return TransitionScreen(child: Center(child: Text(state.message)));
        } else {
          return TransitionScreen(
            child: Center(
              child: LoadingAnimationWidget.waveDots(
                color: Theme.of(context).colorScheme.primary,
                size: 60,
              ),
            ),
          );
        }
      },
    );
  }
}

class TransitionScreen extends StatelessWidget {
  final Widget child;
  const TransitionScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.fromLTRB(150, 100, 150, 100),
        width: double.infinity,
        height: 810,
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
        child: child,
      ),
    );
  }
}
