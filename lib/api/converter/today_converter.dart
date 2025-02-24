import 'package:patta/api/model/today.dart';
import 'package:patta/model/CardModel.dart';
import 'package:patta/model/DohaCardModel.dart';
import 'package:patta/model/KosaAudio.dart';
import 'package:patta/model/OverlayInspirationCardModel.dart';
import 'package:patta/model/PaliWordCardModel.dart';
import 'package:patta/model/StackedInspirationCardModel.dart';
import 'package:patta/model/WordsOfBuddhaCardModel.dart';
import 'package:patta/model/Translations.dart';
import 'package:patta/app/logger.dart';

List<CardModel> convertJsonToCardModels(Iterable response, String baseUrl) {
  try {
    return response
        .map((apiCard) {
          try {
            final String cardType = apiCard['type'];
            ApiCard card = ApiCard.fromJson(apiCard);
            return _convertApiCardToCardModel(card, cardType, baseUrl);
          } catch (e, st) {
            AppLogger.error('Failed to convert API card to model', e, st);
            return null;
          }
        })
        .whereType<CardModel>()
        .toList();
  } catch (e, st) {
    AppLogger.error('Failed to process API response', e, st);
    return [];
  }
}

CardModel? _convertApiCardToCardModel(
  ApiCard card,
  String cardType,
  String baseUrl,
) {
  try {
    switch (cardType) {
      case 'stacked_inspiration':
        {
          return StackedInspirationCardModel(
            id: card.id,
            url: card.url,
            publishedDate: card.publishedDate,
            publishedAt: card.publishedAt,
            header: card.header,
            text: card.text,
            imageUrl: '$baseUrl${card.image?.url}',
            isBookmarkable: card.isBookmarkable,
            isShareable: card.isShareable
          );
        }
      case 'overlay_inspiration':
        {
          return OverlayInspirationCardModel(
              id: card.id,
              url: card.url,
              publishedDate: card.publishedDate,
              publishedAt: card.publishedAt,
              header: card.header,
              text: card.text,
              imageUrl: '$baseUrl${card.image?.url}',
              textColor: card.textColor,
              isBookmarkable: card.isBookmarkable,
              isShareable: card.isShareable);
        }
      case 'pali_word':
        {
          var translationMap = Map<String,String>.fromIterable(
            card.translations!, 
            key: (e) => e.language, 
            value: (e) => e.translation
          );
          PaliWordCardModel? model;
          if (card.translations!.isNotEmpty) {
            model = PaliWordCardModel(
              id: card.id,
              url: card.url,
              publishedDate: card.publishedDate,
              publishedAt: card.publishedAt,
              header: card.header,
              pali: card.pali,
              audioUrl: '$baseUrl${card.audio?.url}',
              translation: card.translations![0].translation,
              translations: Translations(translationMap),
              isBookmarkable: card.isBookmarkable,
              isShareable: card.isShareable
            );
          } else {
            AppLogger.warning('No translations found for Pali word card: ${card.id}');
            model = null;
          }
          return model;
        }
      case 'words_of_buddha':
        {
          var translationMap = Map<String,String>.fromIterable(
            card.translations!, 
            key: (e) => e.language, 
            value: (e) => e.translation
          );
          return WordsOfBuddhaCardModel(
            id: card.id,
            url: card.url,
            publishedDate: card.publishedDate,
            publishedAt: card.publishedAt,
            header: card.header,
            words: card.words,
            translations: Translations(translationMap),
            audioUrl: card.audioUrl,
            kosaAudio: KosaAudio(card.audio?.url),
            citepali: card.citepali,
            citepali_url: card.citepali_url,
            citebook: card.citebook,
            citebook_url: card.citebook_url,
            imageUrl: '$baseUrl${card.image?.url}',
            isBookmarkable: card.isBookmarkable,
            isShareable: card.isShareable
          );
        }
      case 'doha':
        {
          var translationMap = Map<String,String>.fromIterable(
            card.translations!, 
            key: (e) => e.language, 
            value: (e) => e.translation
          );
          return DohaCardModel(
            id: card.id,
            url: card.url,
            publishedDate: card.publishedDate,
            publishedAt: card.publishedAt,
            header: card.header,
            doha: card.doha,
            translations: Translations(translationMap),
            audioUrl: card.audioUrl,
            kosaAudio: KosaAudio(card.audio?.url),
            imageUrl: '$baseUrl${card.image?.url}',
            isBookmarkable: card.isBookmarkable,
            isShareable: card.isShareable
          );
        }
      default:
        {
          AppLogger.warning('Unknown card type: $cardType');
          return null;
        }
    }
  } catch (e, st) {
    AppLogger.error('Failed to convert card type: $cardType', e, st);
    return null;
  }
} 