import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/backend_api.dart';

class AssistantPanel extends ConsumerStatefulWidget {
  const AssistantPanel({super.key});
  @override
  ConsumerState<AssistantPanel> createState() => _AssistantPanelState();
}

class _AssistantPanelState extends ConsumerState<AssistantPanel> {
  final _controller = TextEditingController();
  String _answer = '';
  bool _loading = false;

  Future<void> _ask() async {
    final q = _controller.text.trim();
    if(q.isEmpty) return;
    setState(()=>_loading=true);
    try {
      final api = ref.read(backendProvider);
      final json = await api.askAssistant(q);
      setState(()=>_answer = (json['answer'] as String?) ?? (json['data'] as String? ?? ''));
    } catch (e) {
      setState(()=>_answer = 'Erro ao consultar o Assistant: $e');
    } finally { setState(()=>_loading=false); }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Assistant (GPT-5) — perguntas em linguagem natural'),
      const SizedBox(height: 8),
      Row(children:[
        Expanded(child: TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Ex: Quais deals > R\$200k sem atividade há 14 dias?'),
          onSubmitted: (_)=>_ask(),
        )),
        const SizedBox(width: 8),
        FilledButton.icon(onPressed: _loading?null:_ask, icon: const Icon(Icons.send), label: const Text('Perguntar')),
      ]),
      const SizedBox(height: 16),
      Expanded(child: Card(child:
        Padding(padding: const EdgeInsets.all(16), child:
          _loading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(child: Text(_answer))
        ))),
    ]);
  }
}
