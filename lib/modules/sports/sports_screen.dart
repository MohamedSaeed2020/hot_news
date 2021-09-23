import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_news/shared/components/components.dart';
import 'package:hot_news/shared/cubit/cubit.dart';
import 'package:hot_news/shared/cubit/states.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic>  sportsNews=AppCubit.get(context).sports;
        return Directionality(
            textDirection: TextDirection.rtl,
            child: articleBuilder(sportsNews));

      },
    );
  }
}
