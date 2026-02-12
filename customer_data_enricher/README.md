# Customer Data Enricher Service

A Ballerina REST API service that enriches customer data based on email addresses.

## 🚀 Quick Start

### Run the service:

```bash
cd customer_data_enricher
bal run
```

The service starts on port **9091**.

## 📋 API Endpoint

### GET /data

**Description:** Get enriched customer data for a list of email addresses.

**Query Parameters:**

- `emails` - Array of email addresses (required, can be specified multiple times)

**Example Request:**

```bash
GET /data?emails=user1@test.com&emails=user2@test.com&emails=user3@test.com
```

**Response:**

```json
{
  "status": "success",
  "count": 3,
  "customers": [
    {
      "email": "user1@test.com",
      "name": "Customer 1",
      "location": "New York",
      "tier": "Gold"
    },
    {
      "email": "user2@test.com",
      "name": "Customer 2",
      "location": "London",
      "tier": "Silver"
    },
    {
      "email": "user3@test.com",
      "name": "Customer 3",
      "location": "Tokyo",
      "tier": "Bronze"
    }
  ]
}
```

## 🧪 Testing

### Using cURL:

**Single email:**

```bash
curl "http://localhost:9091/data?emails=user@example.com"
```

**Multiple emails:**

```bash
curl "http://localhost:9091/data?emails=user1@test.com&emails=user2@test.com&emails=user3@test.com"
```

**With pretty JSON (requires jq):**

```bash
curl -s "http://localhost:9091/data?emails=user1@test.com&emails=user2@test.com" | jq '.'
```

### Using the test script:

```bash
chmod +x test-data.sh
./test-data.sh
```

## 📊 Customer Data Fields

Each customer record includes:

| Field      | Type   | Description            | Example Values                                                     |
| ---------- | ------ | ---------------------- | ------------------------------------------------------------------ |
| `email`    | string | Customer email address | user@example.com                                                   |
| `name`     | string | Customer name          | Customer 1                                                         |
| `location` | string | Customer location      | New York, London, Tokyo, Paris, Sydney, Berlin, Toronto, Singapore |
| `tier`     | string | Customer tier          | Gold, Silver, Bronze, Platinum                                     |

## 🎨 Data Variation

The service rotates through predefined locations and tiers:

**Locations (8 total):**

- New York
- London
- Tokyo
- Paris
- Sydney
- Berlin
- Toronto
- Singapore

**Tiers (4 total):**

- Gold
- Silver
- Bronze
- Platinum

Each customer gets data based on their position in the request list, providing consistent but varied dummy data.

## 📝 Example Scenarios

### Scenario 1: Enrich a single customer

```bash
curl "http://localhost:9091/data?emails=john.doe@company.com"
```

Response:

```json
{
  "status": "success",
  "count": 1,
  "customers": [
    {
      "email": "john.doe@company.com",
      "name": "Customer 1",
      "location": "New York",
      "tier": "Gold"
    }
  ]
}
```

### Scenario 2: Batch enrichment

```bash
curl "http://localhost:9091/data?emails=alice@test.com&emails=bob@test.com&emails=charlie@test.com&emails=diana@test.com&emails=eve@test.com"
```

Returns enriched data for all 5 customers with varied locations and tiers.

## 🔧 Integration Examples

### From Another Ballerina Service:

```ballerina
import ballerina/http;

http:Client dataClient = check new("http://localhost:9091");

public function main() returns error? {
    string[] emails = ["user1@test.com", "user2@test.com"];
    string query = string `/data?${createQueryParams(emails)}`;
    json response = check dataClient->get(query);
    // Process response
}

function createQueryParams(string[] emails) returns string {
    string params = "";
    foreach string email in emails {
        params += string `emails=${email}&`;
    }
    return params;
}
```

### From JavaScript/Node.js:

```javascript
const axios = require("axios");

async function getCustomerData(emails) {
  const params = emails.map((email) => `emails=${email}`).join("&");
  const response = await axios.get(`http://localhost:9091/data?${params}`);
  return response.data;
}

// Usage
const emails = ["user1@test.com", "user2@test.com"];
const data = await getCustomerData(emails);
console.log(data.customers);
```

### From Python:

```python
import requests

def get_customer_data(emails):
    params = [('emails', email) for email in emails]
    response = requests.get('http://localhost:9091/data', params=params)
    return response.json()

# Usage
emails = ['user1@test.com', 'user2@test.com']
data = get_customer_data(emails)
print(data['customers'])
```

## 📂 Code Structure

- **CustomerData**: Record type for individual customer data
- **DataResponse**: Response record with status, count, and customer array
- **GET /data**: Resource function that generates enriched data
- **Helper functions**: `getLocationByIndex()` and `getTierByIndex()` for data variation

## ✨ Features

- ✅ GET endpoint with query parameters
- ✅ Accepts multiple email addresses
- ✅ Returns enriched customer data
- ✅ Varied dummy data (locations and tiers rotate)
- ✅ JSON response format
- ✅ Consistent data based on input order

## 🔄 Service Ports

- **Customer Data Enricher**: Port 9091
- **Email Service**: Port 9090 (separate service)

## 🚀 Development

To modify the data:

1. **Add more locations**: Edit `getLocationByIndex()` function
2. **Add more tiers**: Edit `getTierByIndex()` function
3. **Add more fields**: Update `CustomerData` record type
4. **Change response format**: Modify `DataResponse` record type

## 📊 Response Format

```typescript
{
  status: "success",          // Always "success" for this dummy service
  count: number,              // Number of customers returned
  customers: [                // Array of customer data
    {
      email: string,          // Input email
      name: string,           // Generated customer name
      location: string,       // Rotating location
      tier: string           // Rotating tier
    }
  ]
}
```

---

**Note:** This is a dummy service that returns mock enriched data. In production, this would integrate with real customer databases or CRM systems.
