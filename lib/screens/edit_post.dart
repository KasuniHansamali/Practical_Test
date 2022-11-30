import 'package:flutter/material.dart';
import 'package:flutter_basics/HTTPHelper.dart';

class EditPost extends StatefulWidget {
  EditPost(this.post, {Key? key}) : super(key: key);
  Map post;

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerBody = TextEditingController();

  initState() {
    super.initState();
    _controllerTitle.text = widget.post['empNo'];
    _controllerBody.text = widget.post['empName'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _controllerTitle,
              ),
              TextFormField(
                controller: _controllerBody,
                maxLines: 5,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Map<String, String> dataToUpdate = {
                      'empNo': _controllerTitle.text,
                      'empName': _controllerBody.text,
                    };

                    bool status = await HTTPHelper()
                        .updateItem(dataToUpdate, widget.post['id'].toString());

                    if (status) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Post updated')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to update the post')));
                    }
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
