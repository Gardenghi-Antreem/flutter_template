flutter pub run pigeon \
  --input pigeons/native_integration_interfaces.dart \
  --dart_out lib/pigeon.g.dart \
  --objc_header_out ios/Runner/pigeon.g.h \
  --objc_source_out ios/Runner/pigeon.g.m \
  --swift_out ios/Runner/Pigeon.g.swift \
  --kotlin_out android/app/src/main/kotlin/com/scmgroup/pigeon/Pigeon.g.kt \
  --kotlin_package "com.scmgroup.pigeon" \