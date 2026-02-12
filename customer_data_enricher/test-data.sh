#!/bin/bash

# Test script for customer data enricher service

echo "🧪 Testing Customer Data Enricher - GET /data endpoint"
echo "======================================================"
echo ""

BASE_URL="http://localhost:9091"

# Test 1: Single email
echo "Test 1: Get data for 1 email"
echo "----------------------------"
curl -s "$BASE_URL/data?emails=customer1@company.com" | jq '.' 2>/dev/null || \
  curl -s "$BASE_URL/data?emails=customer1@company.com"
echo -e "\n"

# Test 2: Multiple emails
echo "Test 2: Get data for 3 emails"
echo "------------------------------"
curl -s "$BASE_URL/data?emails=alice@test.com&emails=bob@test.com&emails=charlie@test.com" | jq '.' 2>/dev/null || \
  curl -s "$BASE_URL/data?emails=alice@test.com&emails=bob@test.com&emails=charlie@test.com"
echo -e "\n"

# Test 3: Many emails (showing variety)
echo "Test 3: Get data for 8 emails (showing variety)"
echo "------------------------------------------------"
curl -s "$BASE_URL/data?emails=user1@example.com&emails=user2@example.com&emails=user3@example.com&emails=user4@example.com&emails=user5@example.com&emails=user6@example.com&emails=user7@example.com&emails=user8@example.com" | jq '.' 2>/dev/null || \
  curl -s "$BASE_URL/data?emails=user1@example.com&emails=user2@example.com&emails=user3@example.com&emails=user4@example.com&emails=user5@example.com&emails=user6@example.com&emails=user7@example.com&emails=user8@example.com"
echo -e "\n"

# Test 4: Different email formats
echo "Test 4: Different email formats"
echo "--------------------------------"
curl -s "$BASE_URL/data?emails=john.doe@company.com&emails=jane_smith@business.org&emails=admin@startup.io" | jq '.' 2>/dev/null || \
  curl -s "$BASE_URL/data?emails=john.doe@company.com&emails=jane_smith@business.org&emails=admin@startup.io"
echo -e "\n"

echo "✅ All tests completed!"
echo ""
echo "Note: Service running on port 9091"
echo "Example URL: $BASE_URL/data?emails=test@example.com"
