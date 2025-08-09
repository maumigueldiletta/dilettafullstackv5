import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/backend_api.dart';
import 'cards.dart';
import 'charts.dart';
import 'package:intl/intl.dart';

class KpiLoader extends ConsumerStatefulWidget {
  const KpiLoader({super.key});
  @override
  ConsumerState<KpiLoader> createState() => _KpiLoaderState();
}

class _KpiLoaderState extends ConsumerState<KpiLoader> {
  Map<String,dynamic>? data;
  bool loading = true;
  String? error;

  @override
  void initState(){ super.initState(); _load(); }

  Future<void> _load() async {
    setState(()=> loading = true);
    try {
      final api = ref.read(backendProvider);
      final json = await api.getKpis();
      data = json['data'] as Map<String,dynamic>?;
      error = null;
    } catch (e) { error = e.toString(); }
    finally { if (mounted) setState(()=> loading = false); }
  }

  String _brl(num v) => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(v);

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text('Erro ao carregar KPIs: $error'));
    final d = data ?? {};
    final novos = d['novos30d'] ?? 0;
    final pipelineValor = (d['pipelineValor'] ?? 0).toDouble();
    final win = d['winRate90'] ?? 0;
    final pendAtiv = d['pendAtiv'] ?? 0;
    final pipeline = (d['pipeline'] as List?)?.cast<Map>() ?? [];
    final labels = pipeline.map((e)=> (e['name'] ?? '').toString()).toList();
    final values = pipeline.map((e)=> ((e['value'] ?? 0) as num).toDouble()).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 16, runSpacing: 16, children: [
          KpiCard(title: 'Novos deals (30d)', value: '$novos'),
          KpiCard(title: 'Valor no pipeline', value: _brl(pipelineValor)),
          KpiCard(title: 'Win rate (90d)', value: '$win%'),
          KpiCard(title: 'Atividades pendentes', value: '$pendAtiv'),
        ]),
        const SizedBox(height: 24),
        SizedBox(height: 280, child: PipelineChart(values: values, labels: labels)),
      ],
    );
  }
}
