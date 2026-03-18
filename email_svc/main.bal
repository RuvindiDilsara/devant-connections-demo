import ballerina/io;
import ballerina/http;

listener http:Listener httpDefaultListener = http:getDefaultListener();


public function main() returns error? {
    io:println("Starting emails service...");
}