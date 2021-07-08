SWIFT_MODULE_SRC="WikiNetworking/Sources/WikiNetworking"
openapi-generator generate -i "f1Api.yaml" -g swift5 -o "api-mobile"
rm -r $SWIFT_MODULE_SRC""*
cp -R "api-mobile/OpenAPIClient/Classes/OpenAPIs/". $SWIFT_MODULE_SRC
rm -r "api-mobile"
