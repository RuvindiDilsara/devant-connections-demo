# Email Service - sendmail Endpoint

A simple Ballerina REST API with a POST endpoint that accepts a list of emails and returns a success response.

## 🚀 Quick Start

### Run the service:

```bash
cd email_svc
bal run
```

The service starts on port **9090** (default Ballerina HTTP port).

## 📋 API Endpoint

### POST /sendmail

**Request:**

```json
{
  "emails": ["email1@example.com", "email2@example.com"]
}
```

**Response:**

```json
{
  "status": "success",
  "message": "Emails sent successfully to 2 recipient(s)",
  "emailCount": 2
}
```

## 🧪 Testing

### Using cURL:

```bash
curl -X POST http://localhost:9090/sendmail \
  -H "Content-Type: application/json" \
  -d '{"emails": ["test@example.com", "user@example.com"]}'
```

### Using the test script:

```bash
./test-sendmail.sh
```

## 📝 Examples

**Single email:**

```bash
curl -X POST http://localhost:9090/sendmail \
  -H "Content-Type: application/json" \
  -d '{"emails": ["user@example.com"]}'
```

Response:

```json
{
  "status": "success",
  "message": "Emails sent successfully to 1 recipient(s)",
  "emailCount": 1
}
```

**Multiple emails:**

```bash
curl -X POST http://localhost:9090/sendmail \
  -H "Content-Type: application/json" \
  -d '{"emails": ["a@test.com", "b@test.com", "c@test.com"]}'
```

Response:

```json
{
  "status": "success",
  "message": "Emails sent successfully to 3 recipient(s)",
  "emailCount": 3
}
```

## 📂 Code Structure

- **SendMailRequest**: Request record with `emails` array field
- **SendMailResponse**: Response record with `status`, `message`, and `emailCount` fields
- **POST /sendmail**: Resource function that returns a dummy success response

## ✨ Features

- ✅ Accepts any number of email addresses
- ✅ Returns success status with email count
- ✅ Simple and lightweight
- ✅ No validation (dummy service)

---

**Note:** This is a dummy service that returns success responses without actually sending emails.
