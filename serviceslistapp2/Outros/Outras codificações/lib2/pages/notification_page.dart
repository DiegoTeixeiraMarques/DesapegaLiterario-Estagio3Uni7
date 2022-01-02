import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviceslistapp2/core/services/notification/chat_notification_service.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Notificacoes'),
      ),
      body: ListView.builder(
        itemCount: service.itemsCount,
        itemBuilder: (cxt, i) => ListTile(
          title: Text(items[i].title),
          subtitle: Text(items[i].body),
          onTap: () => service.remove(i),
        ),
      ),
    );
  }
}
