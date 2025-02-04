# AWS-Serverless-Reminder-System

![image](https://github.com/user-attachments/assets/908e243a-623e-42c9-8200-e5d88c7cd59a)

---
## 📌 Overview
This is a serverless AWS-based reminder service that allows users to set and receive reminders via email and mobile SMS notifications. The service is designed to work globally, sending notifications and emails according to the user's time zone. 
---
## 🛠️ Tools & Technologies
- AWS Lambda – Serverless compute for processing reminders
- Amazon DynamoDB – NoSQL database for storing reminders
- Amazon API Gateway – API interface for user interactions
- Amazon Simple Email Service (SES) – Email notifications
- Amazon Simple Notification Service (SNS) – Mobile SMS notifications
- Terraform – Infrastructure as code

---
## 🚀 How It Works
- User Requests Reminder
  - User sends a request via API Gateway to set a reminder.
- Reminder Processing
  - set-reminder-lambda stores the reminder in DynamoDB with a TTL (time-to-live).
- Fetching Reminders
  - get-reminder-lambda retrieves reminders when requested.
- Automated Notification
  - When TTL expires, send-reminder-lambda triggers a notification via SES (email) and SNS (mobile SMS).
- Infrastructure as Code
  - Terraform provisions all AWS resources.
