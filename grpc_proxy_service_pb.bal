import ballerina/grpc;
import ballerina/protobuf;

public const string GRPC_PROXY_SERVICE_DESC = "0A18677270635F70726F78795F736572766963652E70726F746F12147669647572616E67612E70726F78792E6772706322270A1148656C6C6F50726F78795265717565737412120A046E616D6518012001280952046E616D65222B0A0F48656C6C6F50726F78795265706C7912180A076D65737361676518012001280952076D65737361676522260A0A48656C6C6F5265706C7912180A076D65737361676518012001280952076D65737361676532D7010A0C50726F78795365727669636512610A0D53617948656C6C6F50726F787912272E7669647572616E67612E70726F78792E677270632E48656C6C6F50726F7879526571756573741A252E7669647572616E67612E70726F78792E677270632E48656C6C6F50726F78795265706C79220012640A1353617948656C6C6F53747265616D50726F787912272E7669647572616E67612E70726F78792E677270632E48656C6C6F50726F7879526571756573741A202E7669647572616E67612E70726F78792E677270632E48656C6C6F5265706C7922003001620670726F746F33";

public isolated client class ProxyServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, GRPC_PROXY_SERVICE_DESC);
    }

    isolated remote function SayHelloProxy(HelloProxyRequest|ContextHelloProxyRequest req) returns HelloProxyReply|grpc:Error {
        map<string|string[]> headers = {};
        HelloProxyRequest message;
        if req is ContextHelloProxyRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("viduranga.proxy.grpc.ProxyService/SayHelloProxy", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <HelloProxyReply>result;
    }

    isolated remote function SayHelloProxyContext(HelloProxyRequest|ContextHelloProxyRequest req) returns ContextHelloProxyReply|grpc:Error {
        map<string|string[]> headers = {};
        HelloProxyRequest message;
        if req is ContextHelloProxyRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("viduranga.proxy.grpc.ProxyService/SayHelloProxy", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <HelloProxyReply>result, headers: respHeaders};
    }

    isolated remote function SayHelloStreamProxy(HelloProxyRequest|ContextHelloProxyRequest req) returns stream<HelloReply, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        HelloProxyRequest message;
        if req is ContextHelloProxyRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("viduranga.proxy.grpc.ProxyService/SayHelloStreamProxy", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        HelloReplyStream outputStream = new HelloReplyStream(result);
        return new stream<HelloReply, grpc:Error?>(outputStream);
    }

    isolated remote function SayHelloStreamProxyContext(HelloProxyRequest|ContextHelloProxyRequest req) returns ContextHelloReplyStream|grpc:Error {
        map<string|string[]> headers = {};
        HelloProxyRequest message;
        if req is ContextHelloProxyRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("viduranga.proxy.grpc.ProxyService/SayHelloStreamProxy", message, headers);
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

public client class ProxyServiceHelloReplyCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendHelloReply(HelloReply response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextHelloReply(ContextHelloReply response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class ProxyServiceHelloProxyReplyCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendHelloProxyReply(HelloProxyReply response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextHelloProxyReply(ContextHelloProxyReply response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextHelloReplyStream record {|
    stream<HelloReply, error?> content;
    map<string|string[]> headers;
|};

public type ContextHelloProxyRequest record {|
    HelloProxyRequest content;
    map<string|string[]> headers;
|};

public type ContextHelloReply record {|
    HelloReply content;
    map<string|string[]> headers;
|};

public type ContextHelloProxyReply record {|
    HelloProxyReply content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: GRPC_PROXY_SERVICE_DESC}
public type HelloProxyRequest record {|
    string name = "";
|};

@protobuf:Descriptor {value: GRPC_PROXY_SERVICE_DESC}
public type HelloReply record {|
    string message = "";
|};

@protobuf:Descriptor {value: GRPC_PROXY_SERVICE_DESC}
public type HelloProxyReply record {|
    string message = "";
|};

