import 'package:dartz/dartz.dart';
import 'package:puntgpt_nick/core/constants/end_points.dart';
import 'package:puntgpt_nick/core/helper/base_api_helper.dart';

class SearchEngineAPISearvice{
    SearchEngineAPISearvice._();
    static SearchEngineAPISearvice instance = SearchEngineAPISearvice._();

    Future<Either<ApiException, Map<String, dynamic>>> getSearchEngine({required String jumpFilter,String? track}) async {
        return await BaseApiHelper.instance.get<Map<String, dynamic>>(
            EndPoints.getUpcomingMeetings(jumpFilter: jumpFilter, track: track),
        );
    }

    Future<Either<ApiException, Map<String, dynamic>>> createSaveSearch({required Map<String, dynamic> data}) async {
        return await BaseApiHelper.instance.post<Map<String, dynamic>>(
            EndPoints.createSaveSearch,
            data: data,
        );
    }

}