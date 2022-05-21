provider "google" {
    region      = var.region
    project     = var.project_name
}

provider "google-beta" {
    region      = var.region
    project     = var.project_name
}

module "gke_cluster" {
    source = "./modules/autopilot_gke"

    name            = "remesh-cluster"
    project         = var.project_name
    region          = var.region
    network_name    = "remesh-network"
    subnet_name     = "remesh-subnet"
}

module "cloud_sql" {
    source = "./modules/sql_database"

    name            = "remesh-postgres"
    region          = var.region
    database_name   = "remeshdb"
}