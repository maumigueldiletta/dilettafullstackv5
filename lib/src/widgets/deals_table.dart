
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/backend_api.dart';
import 'package:intl/intl.dart';

class DealsTable extends ConsumerStatefulWidget {
  const DealsTable({super.key});
  @override
  ConsumerState<DealsTable> createState() => _DealsTableState();
}

class _DealsTableState extends ConsumerState<DealsTable> {
  bool loading = true; String? error; List deals = const [];
  @override
  void initState(){ super.initState(); _load(); }
  Future<void> _load() async {
    try{
      final api = ref.read(backendProvider);
      deals = await api.getDeals(limit: 100);
    }catch(e){ error = e.toString(); }
    finally { if (mounted) setState(()=> loading=false); }
  }
  String _brl(num v) => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(v);

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text('Erro ao carregar deals: $error'));

    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(columns: const [
          DataColumn(label: Text('Título')),
          DataColumn(label: Text('Org')),
          DataColumn(label: Text('Pessoa')),
          DataColumn(label: Text('Valor')),
          DataColumn(label: Text('Fase')),
          DataColumn(label: Text('Status')),
        ], rows: [
          for (final d in deals) DataRow(cells: [
            DataCell(Text('${d['title'] ?? '—'}')),
            DataCell(Text('${d['org_name'] ?? '—'}')),
            DataCell(Text('${d['person_name'] ?? '—'}')),
            DataCell(Text(_brl((d['value'] ?? 0) as num))),
            DataCell(Text('${d['stage_name'] ?? d['stage_id'] ?? '—'}')),
            DataCell(Text('${d['status'] ?? '—'}')),
          ])
        ]),
      ),
    );
  }
}
