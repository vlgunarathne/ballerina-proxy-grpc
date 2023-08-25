import ballerina/grpc;
import ballerina/protobuf;

public const string GRPC_ECHO_SERVICE_DESC = "0A17677270635F6563686F5F736572766963652E70726F746F12137669647572616E67612E6563686F2E6772706322220A0C48656C6C6F5265717565737412120A046E616D6518012001280952046E616D6522260A0A48656C6C6F5265706C7912180A076D65737361676518012001280952076D65737361676532B9010A0B4563686F5365727669636512500A0853617948656C6C6F12212E7669647572616E67612E6563686F2E677270632E48656C6C6F526571756573741A1F2E7669647572616E67612E6563686F2E677270632E48656C6C6F5265706C79220012580A0E53617948656C6C6F53747265616D12212E7669647572616E67612E6563686F2E677270632E48656C6C6F526571756573741A1F2E7669647572616E67612E6563686F2E677270632E48656C6C6F5265706C7922003001620670726F746F33";

public isolated client class EchoServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, GRPC_ECHO_SERVICE_DESC);
    }

    isolated remote function SayHello(HelloRequest|ContextHelloRequest req) returns HelloReply|grpc:Error {
        map<string|string[]> headers = {};
        HelloRequest message;
        if req is ContextHelloRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("viduranga.echo.grpc.EchoService/SayHello", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <HelloReply>result;
    }

    isolated remote function SayHelloContext(HelloRequest|ContextHelloRequest req) returns ContextHelloReply|grpc:Error {
        map<string|string[]> headers = {};
        HelloRequest message;
        if req is ContextHelloRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("viduranga.echo.grpc.EchoService/SayHello", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <HelloReply>result, headers: respHeaders};
    }

    isolated remote function SayHelloStream(HelloRequest|ContextHelloRequest req) returns stream<HelloReply, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        HelloRequest message;
        if req is ContextHelloRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("viduranga.echo.grpc.EchoService/SayHelloStream", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        HelloReplyStream outputStream = new HelloReplyStream(result);
        return new stream<HelloReply, grpc:Error?>(outputStream);
    }

    isolated remote function SayHelloStreamContext(HelloRequest|ContextHelloRequest req) returns ContextHelloReplyStream|grpc:Error {
        map<string|string[]> headers = {};
        HelloRequest message;
        if req is ContextHelloRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("viduranga.echo.grpc.EchoService/SayHelloStream", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        HelloReplyStream outputStream = new HelloReplyStream(result);
        return {content: new stream<HelloReply, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public class HelloReplyStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|HelloReply value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|HelloReply value;|} nextRecord = {value: <HelloReply>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public type ContextHelloReplyStream record {|
    stream<HelloReply, error?> content;
    map<string|string[]> headers;
|};

public type ContextHelloRequest record {|
    HelloRequest content;
    map<string|string[]> headers;
|};

public type ContextHelloReply record {|
    HelloReply content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: GRPC_ECHO_SERVICE_DESC}
public type HelloRequest record {|
    string name = "";
|};

@protobuf:Descriptor {value: GRPC_ECHO_SERVICE_DESC}
public type HelloReply record {|
    string message = "";
|};

