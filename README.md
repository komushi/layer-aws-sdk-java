# lambda-layer-aws-sdk-java-v2

```
source ./modules.sh
docker build -t layer-aws-sdk-java-v2: .
docker run layer-aws-sdk-java-v2 cat /tmp/aws-sdk-java-v2-layer.zip > aws-sdk-java-v2-layer-$AWS_SDK2_VERSION.zip
```