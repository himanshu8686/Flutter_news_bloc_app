import 'dart:async';

import 'package:news_bloc_app/models/NewsModel.dart';
import 'package:news_bloc_app/services/ApiManager.dart';

enum NewsAction  { Fetch,Delete}

class NewsBloc{
  final _stateStreamController = StreamController<List<Article>>();
  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final _eventStreamContoller = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamContoller.sink;
  Stream<NewsAction> get _eventStream => _eventStreamContoller.stream;

  /**
   *
   */
  NewsBloc(){
    _eventStream.listen((event) async {
      if(event == NewsAction.Fetch){
        try {
          var news= await API_Manager.getNews();
          if(news != null){
            _newsSink.add(news.articles);
          }else
            _newsSink.addError("Something went wrong");
        } on Exception catch (e) {
          _newsSink.addError("Something went wrong");
        }
      }
    });
  }

/**
 *
 */
  void dispose(){
    _stateStreamController.close();
    _eventStreamContoller.close();
  }

}