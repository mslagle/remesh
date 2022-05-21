# Create the GKE cluster
resource "google_container_cluster" "autopilot_gke" {
    #provider    = google-beta

    project     = var.project
    name        = var.name
    location    = var.region
    enable_autopilot = true

    ip_allocation_policy { }

    release_channel {
        channel = var.release_channel
    }

    maintenance_policy {
        daily_maintenance_window {
            start_time = var.start_time
        }
    }
}

# Create a service account with the correct permissions for workload identity SQL access
resource "google_service_account" "workload_service_account" {
  account_id   = "remesh-app"
  display_name = "GCP SA bound to K8S SA remesh-app"
  project      = var.project
}

# Enable the sql user role
resource "google_project_iam_member" "workload_sa_role_sqluser" {
  project = var.project
  role    = "roles/cloudsql.instanceUser"
  member  = "serviceAccount:${google_service_account.workload_service_account.email}"
}

# Enable the sql client role
resource "google_project_iam_member" "workload_sa_role_sqlclient" {
  project = var.project
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.workload_service_account.email}"
}

# Enable the workload identity role
resource "google_project_iam_member" "workload_sa_role_identity" {
  project = var.project
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${google_service_account.workload_service_account.email}"
}

# Enable the cloud sql admin api for db connections
resource "google_project_service" "project" {
  project = var.project
  service = "sqladmin.googleapis.com"
}