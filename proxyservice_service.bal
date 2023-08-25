import ballerina_proxy_grpc.echoClient;
import ballerina/grpc;

listener grpc:Listener ep = new (9091);

@grpc:Descriptor {value: GRPC_PROXY_SERVICE_DESC}
service "ProxyService" on ep {

    remote function SayHelloProxy(HelloProxyRequest value) returns HelloProxyReply|error {
        echoClient:HelloRequest request = {name: value.name};
        echoClient:HelloReply|error? reply = echoClient:SayHello(request);
        if reply is error {
            return {message: "error" + reply.toString()};
        } else if reply is echoClient:HelloReply {
            return {message: "Proxy " + reply.message};
        } else {
            return {message: ""};
        }
    }

    remote function SayHelloStreamProxy(HelloProxyRequest value) returns stream<echoClient:HelloReply, error?>|error {
        echoClient:HelloRequest request = {name: value.name};
        stream<echoClient:HelloReply, error?>|error? reply = echoClient:SayHelloStream(request);
        if reply is error {
            return error("error");
        } else if reply is stream<echoClient:HelloReply, error?> {
            return reply;
        } else {
            return error("null");
        }
    }
}

