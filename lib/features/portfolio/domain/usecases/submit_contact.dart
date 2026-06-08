import '../entities/contact_message.dart';
import '../repositories/portfolio_repository.dart';

class SubmitContact {
  final PortfolioRepository repository;

  SubmitContact(this.repository);

  Future<bool> call(ContactMessage message) async {
    return await repository.sendContactMessage(message);
  }
}
