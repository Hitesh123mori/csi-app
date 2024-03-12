

import 'package:flutter/cupertino.dart';

import '../models/post_model/post.dart';

class PostProvider extends ChangeNotifier{
  Post? post = Post();
  bool forEdit = false;

  void notify(){
    notifyListeners();
  }

}