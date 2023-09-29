import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const kUrl = 'https://rest.coinapi.io/v1/exchangerate';
const kApiKey = 'YOUR_API_KEY';

class CoinData {
  Future<Map<String, String>> getCoinData(String selectedCurrency) async {
    Map<String, String> rateMap = {};

    for (String crypto in cryptoList) {
      http.Response response = await http
          .get(Uri.parse('$kUrl/$crypto/$selectedCurrency?apiKey=$kApiKey'));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        //
        double exchangeRate = decodedData['rate'];
        rateMap[crypto] = exchangeRate.toStringAsFixed(4);
      } else {
        print(response.statusCode);
        //
        throw 'Problem with the get request';
      }
    }
    return rateMap;
  }
}
