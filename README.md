# Flutter Template

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Generated by the [Very Good CLI][very_good_cli_link] 🤖

Starting Template for a Flutter application

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

### Pre-commit checks

The project contains a script (`scripts/pre-commit.bash`) that execute linting, analysis and unit test before each commit and abort the commit if some errors are found
There is also another script (`scripts/install-hooks.bash`)  that must be used to install the previous one as pre-commit hook

The command needed to install the pre-commit hook is the following:
`chmod +x scripts/*.bash && ./scripts/install-hooks.bash`

---

## Running Tests 🧪

To generate mockito mock dependency
```sh
$ flutter pub run build_runner build --delete-conflicting-outputs
```

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Commit messages template 📝

The template messages follow the [Conventional Commits specification](https://www.conventionalcommits.org/en/v1.0.0/)
The scope used in each commit will be the ID of the Jira subtask
The global tasks will, instead, use the `project` scope

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:flutter_template/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

If the translations must be used from outside a widget, for instance in order to set an error message inside a failure, where the BuildContext isn't available, the `tr` variable from the `AppTranslations` class must be used

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli

---

## Navigation 🧭

The navigation is managed with the [go_router](https://pub.dev/packages/go_router) package.
The routes are defined inside `shared/core/routes/routes.dart`


---
## Project structure 📁

The project is structured following a feature-first approach

```
├── lib
│   ├── app
│   │   ├── shared
│   │   ├─── features
│   │   │   ├──── login
│   │   │   ├──── onboarding
```


The folder `lib/app` contains the following subfolders:
- features: contains a subfolder for each of the features that logically compose the application
- shared: contains all the classes, constants and functions shared between multiple features

```
├── login
│   ├─── data
│   ├─── domain
│   ├─── presentation
```

Each feature is divided into 3 further subfolders:
- domain: 
    Entities, use cases and repository interface. It containts the core aspects and the business logic of the feature.
    For projects without complex functionalities, the use cases can be omitted and this layer would contains only local entities definitions and repositories interfaces. 
    This second option is the choice made for the current project
- data: 
    Repositories implementation and data sources. It manages access to the data required for the feature
- presentation: 
    UI and view logic (BLoC). It shows the data to the user and manages interactions

### Data layer
```
├── data
│   ├─── data_sources
│   ├─── repositories
```

- Data sources:
    Components that provide functionalities to retrieve, edit and store data. Sources can provide access to remote, local or in-memory data. This is the layer where actual integration with the APIs is implemented.
- Repositories:
    Components that expose a common interface used by the lower layers to access data. They mediate between different sources and implement caching strategies

all common repositories, data sources and entities must be put in the shared foulder

### Domain layer
```
├── domain
│   ├─── entities
│   ├─── repositories
│   ├─── ❌ use_cases
```

- Entities:
    The entities are the domain model used only by the current features. The shared ones will be located inside the shared folder
- Repositories:
    Interfaces of the repositories. Used to prevent the use cases from depending directly from a lower layer (which is against Clean Architectures rules). These interfaces allow the domain layer to be the one owner of the definition of the contracts that the data layer must adhere to
- Use cases:
    Use cases of the applications: business actions that can be triggered from the user by interacting with the applications (eg: login, create report, get materials list, ...)

In this application, since the major complexity is in the presentation layer and the domain doesn't seem to have complex cases to manage, the use_cases  have been removed in the sake of simplicity. So the BLoC components will interact directly with the repositories implementation in the data layer.
The repositories interface are keeped in order to define a contract between the presentation and data layer

### Presentation layer
```
├── presentation
│   ├─── ui
│   ├─── widgets
│   ├─── bloc
```

- UI:
    Contains the pages of the application. Each page is usually divided into 2 files: [section]_screen and [section]_page. The page just inject the Bloc used by the screen. This separation allows a better testing of the screen, since otherwise it won't be possible to inject a mocked version of the BLoC component. 
- Widgets:
    Contains components used by multiple pages of the feature
- BLoC
    Components that contains the UI logic of a page or section. For each BLoC must be defined 3 different files: one containins all the events that are triggered by the ui ([page_name]_events), one containing the definition of the state of that page ([page_name]_state) and another containing the effective BLoC implementation and so the logic that merges events and states ([page_name]_bloc)


### Shared folder

```
├── shared
│   ├─── core
│   ├─── data
│   ├─── domain
│   ├─── presentation
│   ├─── utils
```

- Core:
    Contains all classes used for core aspects of the entire project, for instance errors catalog, service locator, config/env manager, ecc...s 
- Utils:
    Contains utility classes and functions used in the project
- Data/Domain/Presentation
    Contain entities, repositories, widgets used by more than a single feature. They mantain the same structure of the corresponding feature folders


### Tests

The unit test files organization follow the same convention used before, but inside the test folder. The file name will be the same as the tested component's file, but with the _test prefix
So, for instance, the test of the login bloc will be located under:
```
/test/app/features/login/presentation/bloc/login_bloc_test.dart
```

## Dependency Injection 💉

For dependency injection the package [get_it](https://pub.dev/packages/get_it) is used
The dependencies definition is made inside the ```/lib/app/shared/locator/injection_container.dart``` file

For instance, the following code shows how to register all the dependencies used by the Login section:

```
  // LOGIN
  sl
    ..registerLazySingleton<FakeLoginDataSource>(FakeLoginDataSource.new)
    ..registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton<LoginBloc>(() => LoginBloc(loginRepository: sl()));
```

## Forms 📋

Forms are managed through the [formz](https://pub.dev/packages/formz) library.
The fields definition is located in `lib/shared/core/form_fields`
A usage example can be found in the `login` feature

## BE Integration 🔧

In order to generate API integration code automatically, add the updated swagger.json in the `openapi` folder and then run the command:
```make generate_api```


## Native Integration 📫

the Pigeon library is used for integration with the native side. In order to generate the pigeon integration code run the command:
```make generate_native_integration```


## Rename the project 
``` flutter pub global activate rename ```
``` rename setAppName --targets ios,android --value "flutter_template" ```