import ballerina/http;

listener http:Listener httpListener = new(9091);

// Response type for customer data
type CustomerData record {|
    string email;
    string name;
    string location;
    string tier;
|};

// Response type for data endpoint
type DataResponse record {|
    string status;
    int count;
    CustomerData[] customers;
|};

service / on httpListener {
    
    // GET endpoint to retrieve customer data
    // Example: GET /data?emails=user1@test.com,user2@test.com
    resource function get data(string[] emails) returns DataResponse {
        // Generate dummy customer data for each email
        CustomerData[] customers = [];
        
        int counter = 0;
        foreach string email in emails {
            customers.push({
                email: email,
                name: string `Customer ${counter + 1}`,
                location: getLocationByIndex(counter),
                tier: getTierByIndex(counter)
            });
            counter += 1;
        }
        
        // Return dummy response
        return {
            status: "success",
            count: customers.length(),
            customers: customers
        };
    }
}

// Helper function to generate locations based on index
function getLocationByIndex(int index) returns string {
    string[] locations = ["New York", "London", "Tokyo", "Paris", "Sydney", "Berlin", "Toronto", "Singapore"];
    return locations[index % locations.length()];
}

// Helper function to generate tiers based on index
function getTierByIndex(int index) returns string {
    string[] tiers = ["Gold", "Silver", "Bronze", "Platinum"];
    return tiers[index % tiers.length()];
}
