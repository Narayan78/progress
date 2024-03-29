import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/employee_model.dart';

final employeeDataRepository = Provider((ref) => FetchEmployeeDataRepository());

class FetchEmployeeDataRepository {
  final dio = Dio();

  Future<Either<String, List<EmployeeModel>>> fetchEmployeeData() async {
    try {
      final response = await dio.get(
        'http://ghfmun.org/getEmployeeData',
        options: Options(headers: {
          'authorization': 'Bearer 9866570482',
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = response.data['data'] as List<dynamic>;
        final employeeList =
            jsonData.map((data) => EmployeeModel.fromMap(data)).toList();
        return right(employeeList);
      } else {
        return left('Failed to fetch employee data');
      }
    } catch (e) {
      return left('Error: $e');
    }
  }
}