import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_news/shared/components/components.dart';
import 'package:hot_news/shared/cubit/cubit.dart';
import 'package:hot_news/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: ( context, state) =>AppCubit(),
      builder: ( context,  state) {
        List<dynamic>  searchNews=AppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormField(
                    onChange: (value){
                      AppCubit.get(context).getSearch(value);
                    },
                    controller: searchController,
                    type: TextInputType.text,
                    label: "Search",
                    icon: Icons.search),
              ),
              Expanded(child: articleBuilder(searchNews,isSearch: true,)),
            ],
          ),
        );
      },
    );
  }
}
