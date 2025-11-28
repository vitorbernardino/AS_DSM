import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/api_task_model.dart';
import '../../services/api_service.dart';

class ExternalTasksScreen extends StatelessWidget {
  const ExternalTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = context.read<ApiService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas Globais (API)'),
      ),
      body: FutureBuilder<List<ApiTask>>(
        future: apiService.fetchTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                    const SizedBox(height: 16),
                    Text(
                      'Erro ao carregar dados:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhuma tarefa encontrada na API."));
          }

          final tasks = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                color: const Color(0xFF2E2E2E),
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: task.completed 
                        ? Colors.green.withOpacity(0.2) 
                        : Colors.orange.withOpacity(0.2),
                    child: Icon(
                      task.completed ? Icons.check : Icons.access_time,
                      color: task.completed ? Colors.green : Colors.orange,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    task.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'ID: ${task.id} • User: ${task.userId}',
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}