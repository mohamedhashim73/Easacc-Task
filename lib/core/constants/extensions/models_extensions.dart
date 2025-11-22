extension UriEx on Uri?{
  Uri completeUrl(String url)=> Uri.parse((this != null && this!.scheme.isEmpty) ? 'https://$url' : url);
}