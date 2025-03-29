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
---
## Postman
I have used Postman to test this solution, Below  Postman API request bodies are mentioned to set and retrieve stored reminders
### Setting a Reminder
-  The API end point is going to be like this 
``` bash
https://{YOUR AWS API GATEWAY ENDPOINT}/setreminder
```
- Example Request Body for Setting an Email Reminder 
``` bash
{
  "name": "Wajeehabatool",
  "contactInfo": "wajeehabatool2021@gmail.com",
  "reminderText": "Doctor appointment in 15 minutes",
  "reminderTime": "2025-03-10 14:15:00",  
  "timeZone": "Asia/Karachi"
}

```
- Here's the recieved email reminder snapshot
  
  ![image](https://github.com/user-attachments/assets/090dafa9-2e12-4079-a7ea-2624b04846be)

- Example Request Body for Setting a Phone Reminder
  ``` bash
  {
  "name": "wajeehabatool",
  "contactInfo": "+923049902383",
  "reminderText": "Your appointment is tomorrow at 10 AM!",
  "reminderTime": "2025-02-03 00:45:00",  
  "timeZone": "Asia/Karachi"
  }

  ```
- Here's the received phone reminder snapshot
  
  ![image](https://github.com/user-attachments/assets/1bb91b1d-6759-4831-a900-2ebb9156023a)

### Getting stored reminder
- Use the below endpoint to retrieve stored reminders
  ``` bash
  https://{your AWS API GATEWAY ENDPOINT}/getreminders?name=wajeehabatool
  ``` 
