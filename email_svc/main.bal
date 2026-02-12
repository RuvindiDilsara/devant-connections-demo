import ballerina/http;

listener http:Listener httpDefaultListener = http:getDefaultListener();

// Request type for sendmail endpoint
type SendMailRequest record {|
    string[] emails;
|};

// Response type for sendmail endpoint
type SendMailResponse record {|
    string status;
    string message;
    int emailCount;
|};

service / on httpDefaultListener {
    
    // POST endpoint to send emails
    resource function post sendmail(@http:Payload SendMailRequest request) returns SendMailResponse {
        // Return dummy success response
        return {
            status: "success",
            message: string `Emails sent successfully to ${request.emails.length()} recipient(s)`,
            emailCount: request.emails.length()
        };
    }
}
