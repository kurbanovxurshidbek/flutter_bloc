import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pattern_bloc/bloc/list_post_state.dart';
import '../bloc/list_post_cubit.dart';
import '../model/post_model.dart';
import '../services/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../views/view_of_home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListPostCubit>(context).apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pattern - BloC"),
        ),
        body: BlocBuilder<ListPostCubit, ListPostState>(
          builder: (BuildContext context, ListPostState state){
            if(state is ListPostError){
              return viewOfHome(items, true);
            }
            if(state is ListPostLoaded){
              items = state.posts!;
              return viewOfHome(items, false);
            }
            return viewOfHome(items, true);
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {
            BlocProvider.of<ListPostCubit>(context).callCreatePage(context);
          },
          child: Icon(Icons.add),
        ));
  }
}
