import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappclone/feature/contact/repository/contacts_repository.dart';

final contactsControllerProvider = FutureProvider(
  (ref) {
    final contactsRepository = ref.watch(contactsRepositoryProvider);
    return contactsRepository.getAllContacts();
  },
);
