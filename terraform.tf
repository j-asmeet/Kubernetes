provider "google" {
  credentials = file("./credentials.json")
  project     = "advcloud-402315"
  region      = "us-central1"
}

resource "google_container_cluster" "cloud_cluster" {
  name               = "cloud-assignment-cluster"
  location           = "us-central1"
  remove_default_node_pool = true
  initial_node_count = 1
  
   node_config {
    machine_type = "e2-micro"
    disk_size_gb = 10
    disk_type = "pd-standard"
    image_type      = "COS_CONTAINERD"
  }
}
resource "google_container_node_pool" "custom_node_pool" {
  name       = "custom-node-pool"
  cluster    = google_container_cluster.cloud_cluster.name
  initial_node_count = 1
  node_config {
    machine_type = "e2-micro"
    disk_size_gb = 10
    disk_type    = "pd-standard"
    image_type   = "COS_CONTAINERD"
  }
}