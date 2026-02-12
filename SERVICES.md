# Services Overview

This workspace contains two Ballerina microservices that work together:

## 📦 Services

### 1. Customer Data Enricher (Port 9091)

**Purpose:** Retrieve enriched customer data based on email addresses

**Endpoint:** `GET /data?emails=...`

**Example:**

```bash
curl "http://localhost:9091/data?emails=user1@test.com&emails=user2@test.com"
```

**Response:**

```json
{
  "status": "success",
  "count": 2,
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
    }
  ]
}
```

### 2. Email Service (Port 9090)

**Purpose:** Send emails to multiple recipients

**Endpoint:** `POST /sendmail`

**Example:**

```bash
curl -X POST http://localhost:9090/sendmail \
  -H "Content-Type: application/json" \
  -d '{"emails": ["user1@test.com", "user2@test.com"]}'
```

**Response:**

```json
{
  "status": "success",
  "message": "Emails sent successfully to 2 recipient(s)",
  "emailCount": 2
}
```

## 🚀 Running Both Services

### Terminal 1 - Customer Data Enricher:

```bash
cd customer_data_enricher
bal run
```

### Terminal 2 - Email Service:

```bash
cd email_svc
bal run
```

## 🔄 Typical Workflow

```bash
# Step 1: Get customer data
curl "http://localhost:9091/data?emails=alice@company.com&emails=bob@company.com"

# Returns enriched customer information

# Step 2: Send emails to those customers
curl -X POST http://localhost:9090/sendmail \
  -H "Content-Type: application/json" \
  -d '{"emails": ["alice@company.com", "bob@company.com"]}'

# Confirms emails sent
```

## 📊 Complete Example

```bash
# Get customer data for 3 emails
$ curl -s "http://localhost:9091/data?emails=john@test.com&emails=jane@test.com&emails=joe@test.com" | jq '.'

{
  "status": "success",
  "count": 3,
  "customers": [
    {
      "email": "john@test.com",
      "name": "Customer 1",
      "location": "New York",
      "tier": "Gold"
    },
    {
      "email": "jane@test.com",
      "name": "Customer 2",
      "location": "London",
      "tier": "Silver"
    },
    {
      "email": "joe@test.com",
      "name": "Customer 3",
      "location": "Tokyo",
      "tier": "Bronze"
    }
  ]
}

# Send emails to those customers
$ curl -X POST http://localhost:9090/sendmail \
  -H "Content-Type: application/json" \
  -d '{"emails": ["john@test.com", "jane@test.com", "joe@test.com"]}'

{
  "status": "success",
  "message": "Emails sent successfully to 3 recipient(s)",
  "emailCount": 3
}
```

## 🧪 Testing

Each service has its own test script:

```bash
# Test customer data enricher
cd customer_data_enricher
./test-data.sh

# Test email service
cd email_svc
./test-sendmail.sh
```

## 🏗️ Service Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Client Application                    │
└─────────────────────────────────────────────────────────┘
                    │                │
                    │                │
         ┌──────────┘                └──────────┐
         │                                      │
         ▼                                      ▼
┌──────────────────────┐           ┌──────────────────────┐
│  Customer Data       │           │   Email Service      │
│  Enricher            │           │                      │
│                      │           │                      │
│  GET /data           │           │  POST /sendmail      │
│  Port: 9091          │           │  Port: 9090          │
└──────────────────────┘           └──────────────────────┘
```

## 📝 Use Cases

### Use Case 1: Customer Welcome Email

1. Get customer data to personalize email
2. Send welcome email with customer details

### Use Case 2: Batch Processing

1. Get data for multiple customers
2. Process enriched data
3. Send targeted emails based on tier/location

### Use Case 3: Data Enrichment Pipeline

1. Input: List of email addresses
2. Enrich: Get customer details (name, location, tier)
3. Action: Send personalized communications

## 🔧 Integration Example

```ballerina
import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Get customer data
    http:Client dataClient = check new("http://localhost:9091");
    json customerData = check dataClient->get("/data?emails=user1@test.com&emails=user2@test.com");
    io:println("Customer Data:", customerData);

    // Send emails
    http:Client emailClient = check new("http://localhost:9090");
    json emailPayload = {
        emails: ["user1@test.com", "user2@test.com"]
    };
    json emailResponse = check emailClient->post("/sendmail", emailPayload);
    io:println("Email Response:", emailResponse);
}
```

## 📦 Quick Reference

| Service                | Port | Method | Endpoint  | Purpose                    |
| ---------------------- | ---- | ------ | --------- | -------------------------- |
| Customer Data Enricher | 9091 | GET    | /data     | Get enriched customer data |
| Email Service          | 9090 | POST   | /sendmail | Send emails                |

## 🎯 Next Steps

1. **Run both services** in separate terminals
2. **Test individually** using curl commands above
3. **Test together** using the integration example
4. **Build your workflow** combining both services

---

**Both services return dummy/mock data and are for demonstration purposes.**
