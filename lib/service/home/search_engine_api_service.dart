import 'package:dartz/dartz.dart';
import 'package:puntgpt_nick/core/constants/end_points.dart';
import 'package:puntgpt_nick/core/helper/base_api_helper.dart';

class SearchEngineAPISearvice {
  SearchEngineAPISearvice._();
  static SearchEngineAPISearvice instance = SearchEngineAPISearvice._();

  Future<Either<ApiException, Map<String, dynamic>>> getSearchEngine({
    required String jumpFilter,
    String? track,
  }) async {
    return await BaseApiHelper.instance.get<Map<String, dynamic>>(
      EndPoints.getUpcomingMeetings(jumpFilter: jumpFilter, track: track),
    );
  }

  Future<Either<ApiException, Map<String, dynamic>>> createSaveSearch({
    required Map<String, dynamic> data,
  }) async {
    return await BaseApiHelper.instance.post<Map<String, dynamic>>(
      EndPoints.createSaveSearch,
      data: data,
    );
  }

  Future<Either<ApiException, Map<String, dynamic>>> getAllSaveSearch() async {
    return await BaseApiHelper.instance.get<Map<String, dynamic>>(
      EndPoints.getAllSaveSearch,
    );
  }

  Future<Either<ApiException, Map<String, dynamic>>> getSaveSearchDetails({
    required String id,
  }) async {
    return await BaseApiHelper.instance.get<Map<String, dynamic>>(
      EndPoints.getSearchDetails(id: id),
    );
  }

  Future<Either<ApiException, Map<String, dynamic>>> editSaveSearch({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    return await BaseApiHelper.instance.patch<Map<String, dynamic>>(
      EndPoints.editSaveSearch(id: id),
      data: data,
    );
  }

  Future<Either<ApiException, Map<String, dynamic>>> deleteSaveSearch({required String id}) async {
    return await BaseApiHelper.instance.delete<Map<String, dynamic>>(
      EndPoints.deleteSaveSearch(id: id),
    );
  }
}
