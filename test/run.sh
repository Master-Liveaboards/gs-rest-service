cd $(dirname $0)
cd ../initial

./mvnw clean compile
ret=$?
if [ $ret -ne 0 ]; then
exit $ret
fi
rm -rf target

./gradlew compileJava
ret=$?
if [ $ret -ne 0 ]; then
exit $ret
fi
rm -rf build

cd ../complete
./mvnw clean package

# if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; 
#   then 
#     curl https://raw.githubusercontent.com/timkay/aws/main/aws -o aws
#     chmod u+x aws
#     ./aws put --progress "x-amz-acl: public-read" springio-guides/gs-rest-service-0.1.0.jar target/gs-rest-service-0.1.0.jar
# fi

./docker build -f ./docker/dockerfile

rm -rf target

./gradlew build
ret=$?
if [ $ret -ne 0 ]; then
exit $ret
fi

rm -rf build
exit
