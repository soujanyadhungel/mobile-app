import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:patta/api/converter/today_converter.dart' as today_converter;
import 'package:patta/app/dio.dart';
import 'package:patta/app/feed_preferences.dart';
import 'package:patta/app/logger.dart';
import 'package:patta/model/CardModel.dart';
import '../model/NetworkErrorCardModel.dart';

class PariyattiApi {
  final TODAY_URL = '/api/v2/today.json';

  String baseUrl;
  FeedPreferences feedPreferences;

  PariyattiApi(this.baseUrl, this.feedPreferences);

  Future<List<CardModel>> fetchToday() async {
    try {
      AppLogger.debug('Fetching today\'s content from $baseUrl$TODAY_URL');
      var response = await GetDio.getDio(baseURL: baseUrl).get(TODAY_URL);
      AppLogger.debug('Received response from API');
      
      var models = today_converter.convertJsonToCardModels(response.data, baseUrl);
      models.removeWhere(CardModel.inFuture());
      
      if (notEnoughCardsPublished(models)) {
        AppLogger.warning('No cards published for today yet');
        return [NetworkErrorCardModel.create("Cards have not been published for today yet.")];
      }
      
      var trimmed = models.takeWhile(CardModel.laterThan(feedPreferences.getTodayMaxDays())).toList();
      AppLogger.debug('Successfully processed ${trimmed.length} cards');
      return trimmed;
    } on DioException catch (e) {
      AppLogger.error('Failed to fetch data from Pariyatti server', e, e.stackTrace);
      return [NetworkErrorCardModel.create("Could not reach Pariyatti server '$baseUrl'.")];
    } catch (se, st) {
      AppLogger.error('Unexpected error while fetching today\'s content', se, st);
      return [NetworkErrorCardModel.create("Could not reach Pariyatti server '$baseUrl'.")];
    }
  }

  bool notEnoughCardsPublished(List<CardModel> models) {
    var today = DateTime.now();
    var onlyOneDayVisible = feedPreferences.getTodayMaxDays() == 1;
    var todayIsntVisible = models.first.publishedDate != DateTime(today.year, today.month, today.day);
    return onlyOneDayVisible && todayIsntVisible;
  }

  void logError(e) {
    if (e.response != null) {
      AppLogger.error('API Error Response', {
        'data': e.response!.data,
        'headers': e.response!.headers,
        'requestOptions': e.response!.requestOptions
      });
    } else {
      AppLogger.error('API Error', {
        'requestOptions': e.requestOptions,
        'type': e.type,
        'message': e.message
      });
    }
  }
} 