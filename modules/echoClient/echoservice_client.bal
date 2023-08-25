EchoServiceClient ep = check new ("http://172.17.0.2:9090");

public function SayHello(HelloRequest request) returns HelloReply|error? {
    HelloRequest sayHelloRequest = {name: request.name};
    HelloReply sayHelloResponse = check ep->SayHello(sayHelloRequest);
    return sayHelloResponse;
}

public function SayHelloStream(HelloRequest request) returns stream<HelloReply, error?>|error? {
    HelloRequest sayHelloStreamRequest = {name: request.name};
    stream<HelloReply, error?> sayHelloStreamResponse = check ep->SayHelloStream(sayHelloStreamRequest);
    return sayHelloStreamResponse;
}

