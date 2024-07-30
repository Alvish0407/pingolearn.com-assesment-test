import 'package:freezed_annotation/freezed_annotation.dart';

class UriConverter implements JsonConverter<Uri?, String?> {
  const UriConverter();

  @override
  Uri? fromJson(String? json) {
    if (json == null) return null;
    return createUri(json);
  }

  @override
  String? toJson(Uri? object) {
    if (object == null) return null;
    return object.toString();
  }

  Uri createUri(String path) {
    Uri? uri = Uri.tryParse(path);

    if (uri != null && (uri.isScheme('http') || uri.isScheme('https'))) {
      return uri;
    } else {
      throw ArgumentError('Invalid URL: $path');
    }
  }
}
