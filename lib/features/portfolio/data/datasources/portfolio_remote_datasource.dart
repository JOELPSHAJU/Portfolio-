import 'package:portfolio_client/portfolio_client.dart' as client;

abstract class PortfolioRemoteDataSource {
  Future<client.PortfolioData> getPortfolioData();
  Future<bool> sendContactMessage(String name, String email, String message);
}

class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource {
  final client.Client clientInstance;

  PortfolioRemoteDataSourceImpl({required this.clientInstance});

  @override
  Future<client.PortfolioData> getPortfolioData() async {
    return await clientInstance.portfolio.getPortfolioData();
  }

  @override
  Future<bool> sendContactMessage(String name, String email, String message) async {
    return await clientInstance.portfolio.submitInquiry(
      name: name,
      email: email,
      message: message,
    );
  }
}
