#!/bin/bash

# Test script for sendmail endpoint

echo "🧪 Testing Email Service - sendmail endpoint"
echo "=============================================="
echo ""

BASE_URL="http://localhost:9090"

# Test 1: Single email
echo "Test 1: Sending to 1 recipient"
curl -s -X POST $BASE_URL/sendmail \
  -H "Content-Type: application/json" \
  -d '{"emails": ["user@example.com"]}' | jq '.' 2>/dev/null || \
  curl -s -X POST $BASE_URL/sendmail \
  -H "Content-Type: application/json" \
  -d '{"emails": ["user@example.com"]}'
echo -e "\n"

# Test 2: Multiple emails
echo "Test 2: Sending to 3 recipients"
curl -s -X POST $BASE_URL/sendmail \
  -H "Content-Type: application/json" \
  -d '{"emails": ["user1@example.com", "user2@example.com", "user3@example.com"]}' | jq '.' 2>/dev/null || \
  curl -s -X POST $BASE_URL/sendmail \
  -H "Content-Type: application/json" \
  -d '{"emails": ["user1@example.com", "user2@example.com", "user3@example.com"]}'
echo -e "\n"

# Test 3: Many emails
echo "Test 3: Sending to 10 recipients"
curl -s -X POST $BASE_URL/sendmail \
  -H "Content-Type: application/json" \
  -d '{"emails": ["a@test.com","b@test.com","c@test.com","d@test.com","e@test.com","f@test.com","g@test.com","h@test.com","i@test.com","j@test.com"]}' | jq '.' 2>/dev/null || \
  curl -s -X POST $BASE_URL/sendmail \
  -H "Content-Type: application/json" \
  -d '{"emails": ["a@test.com","b@test.com","c@test.com","d@test.com","e@test.com","f@test.com","g@test.com","h@test.com","i@test.com","j@test.com"]}'
echo -e "\n"

echo "✅ All tests completed!"
