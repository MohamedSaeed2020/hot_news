import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_news/shared/components/components.dart';
import 'package:hot_news/shared/cubit/cubit.dart';
import 'package:hot_news/shared/cubit/states.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic>  businessNews=AppCubit.get(context).business;
        return ScreenTypeLayout(
          mobile: Builder(
            builder: (context) {
              AppCubit.get(context).setDesktop(false);
              return Directionality(
                textDirection: TextDirection.rtl,
                child: articleBuilder(businessNews),
              );
            }
          ),
          desktop: Builder(
            builder: (context) {
              AppCubit.get(context).setDesktop(true);
              return Row(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: articleBuilder(businessNews),
                  ),
                  if(businessNews.length>0)
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          '${businessNews[AppCubit.get(context).businessSelectedItem]['description']!=null?businessNews[AppCubit.get(context).businessSelectedItem]['description']:'There is no description'}',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
          breakpoints:
          ScreenBreakpoints(watch: 100.0, tablet: 400.0, desktop: 650.0),

        );
      },
    );
  }
}
