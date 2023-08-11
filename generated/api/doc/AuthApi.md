# flutter_template_api.api.AuthApi

## Load the API package
```dart
import 'package:flutter_template_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v2AuthLoginPost**](AuthApi.md#v2authloginpost) | **POST** /v2/auth/login | 


# **v2AuthLoginPost**
> String v2AuthLoginPost(userCredentials)



### Example
```dart
import 'package:flutter_template_api/api.dart';

final api = FlutterTemplateApi().getAuthApi();
final UserCredentials userCredentials = ; // UserCredentials | 

try {
    final response = api.v2AuthLoginPost(userCredentials);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->v2AuthLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userCredentials** | [**UserCredentials**](UserCredentials.md)|  | [optional] 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

