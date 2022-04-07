import 'package:flutter/material.dart';
import '../bloc/update_post_cubit.dart';
import '../bloc/update_post_state.dart';
import '../model/post_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';
import '../views/view_of_update.dart';

class UpdatePage extends StatefulWidget {
  Post? post;

  UpdatePage({Key? key, this.post}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  _finish(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Navigator.pop(context, "result");
    });
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.post!.title!;
    bodyController.text = widget.post!.body!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePostCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update a Post"),
        ),
        body: BlocBuilder<UpdatePostCubit, UpdatePostState>(
          builder: (BuildContext context, UpdatePostState state) {
            if (state is UpdatePostLoading) {
              String title = titleController.text.toString();
              String body = bodyController.text.toString();
              Post post = Post(
                  id: widget.post!.id,
                  title: title,
                  body: body,
                  userId: widget.post!.userId);
              return viewOfUpdate(
                  true, context, post, titleController, bodyController);
            }
            if (state is UpdatePostLoaded) {
              _finish(context);
            }
            if (state is UpdatePostError) {}
            return viewOfUpdate(
                false, context, widget.post!, titleController, bodyController);
          },
        ),
      ),
    );
  }
}
