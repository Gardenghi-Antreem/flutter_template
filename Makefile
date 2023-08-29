generate_api:
	rm -Rf generated/api
	openapi-generator generate -i ./openapi/swagger.json \
	 -p pubAuthor="Gellify" \
	 -p pubDescription="API library for flutter template" \
	 -p pubLibrary=generated/api \
	 -p pubName=flutter_template_api \
	 -p pubVersion=1.0.0 \
	 -o generated/api \
	 -g dart-dio
	cd ./generated/api; sleep 5; flutter pub get && flutter packages pub run build_runner build

cli_generate_api:
	rm -Rf generated/api
	openapi-generator-cli generate -i ./openapi/swagger.json \
	 -o generated/api \
	 -g dart-dio \
	 -p pubName=flutter_template_api
	cd ./generated/api; sleep 5; flutter pub get && flutter packages pub run build_runner build