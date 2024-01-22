# Define variables
variable "project_id" {
  description = "Google Cloud Project ID"
  default     = input("Enter your Google Cloud Project ID: ")
}

variable "topic_count" {
  description = "Number of Pub/Sub topics to create"
  type        = number
  default     = 10000
}

# Generate topic names dynamically
variable "topic_names" {
  default = [for i in range(var.topic_count) : "topic-${i + 1}"]
}

# Configure the Google Cloud provider
provider "google" {
  credentials = file("<your-service-account-key.json>")
  project     = var.project_id
  region      = "us-central1"  # Set your desired region
}

# Create Pub/Sub topics
resource "google_pubsub_topic" "pubsub_topics" {
  count = length(var.topic_names)

  name = var.topic_names[count.index]
}
