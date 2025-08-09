import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BackendApi {
  final String baseUrl;
  BackendApi({required this.baseUrl});

  Uri _u(String path, [Map<String,String?> q = const {}]) =>
    Uri.parse('$baseUrl$path').replace(queryParameters: {...q}..removeWhere((k,v)=>v==null));

  Future<Map<String,dynamic>> _get(String path, [Map<String,String?> q = const {}]) async {
    final res = await http.get(_u(path, q));
    if (res.statusCode != 200) throw Exception('HTTP ${res.statusCode}: ${res.body}');
    return jsonDecode(res.body) as Map<String,dynamic>;
  }

  Future<List<dynamic>> getDeals({int start=0, int limit=50, String? status}) async {
    final json = await _get('/api/pd/deals', {'start':'$start','limit':'$limit','status': status});
    return (json['data'] as List?) ?? [];
  }
  Future<Map<String,dynamic>> getKpis() async => await _get('/api/kpis');
  Future<Map<String,dynamic>> askAssistant(String query) async {
    final res = await http.post(_u('/api/assistant'),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({'query': query}));
    if (res.statusCode!=200) throw Exception('HTTP ${res.statusCode}: ${res.body}');
    return jsonDecode(res.body) as Map<String,dynamic>;
  }
}

final backendProvider = Provider<BackendApi>((ref){
  return BackendApi(baseUrl: 'http://localhost:8787');
});
