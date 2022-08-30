import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/base/state_model.dart';
import 'package:manga_app/model/category.dart';

import 'package:manga_app/page/bloc/new_update_home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bloc = NewUpdateHomeCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is StateModelSuccess<List<Category>>) {
                  var categories = state.value;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: categories?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(categories?[index].name ?? ""),
                          Text(categories?[index].description ?? "", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),),
                        ],
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
