resource "yandex_kubernetes_cluster" "k8s-cluster" {
  name        = var.cluster_name
  description = var.cluster_description
  network_id  = var.network_id
  master {
    version   = var.kubernetes_version
    public_ip = true
    master_location {
      zone      = var.subnet_zone
      subnet_id = var.subnet_id
    }
    scale_policy {
      auto_scale  {
        min_resource_preset_id = var.min_resource_preset_id
      }
   }
  }
  service_account_id      = yandex_iam_service_account.sa-account.id
  node_service_account_id = yandex_iam_service_account.sa-account.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.alb-editor,
    yandex_resourcemanager_folder_iam_member.editor,
    yandex_resourcemanager_folder_iam_member.vpc-publicAdmin,
    yandex_resourcemanager_folder_iam_member.certificates-downloader,
    yandex_resourcemanager_folder_iam_member.compute-viewer,
    yandex_resourcemanager_folder_iam_member.images-puller
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
  network_policy_provider = var.network_policy_provider
}

resource "yandex_iam_service_account" "sa-account" {
  name        = var.service_account_name
  description = "Сервисный аккаунт для управления кластером Kubernetes"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  # Сервисному аккаунту назначается роль 'k8s.clusters.agent'
  folder_id   = var.folder_id
  role        = "k8s.clusters.agent"
  member      = "serviceAccount:${yandex_iam_service_account.sa-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "alb-editor" {
  # Сервисному аккаунту назначается роль 'alb.editor'
  folder_id   = var.folder_id
  role        = "alb.editor"
  member      = "serviceAccount:${yandex_iam_service_account.sa-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  # Сервисному аккаунту назначается роль 'editor'
  folder_id   = var.folder_id
  role        = "editor"
  member      = "serviceAccount:${yandex_iam_service_account.sa-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-publicAdmin" {
  # Сервисному аккаунту назначается роль 'vpc.publicAdmin'
  folder_id   = var.folder_id
  role        = "vpc.publicAdmin"
  member      = "serviceAccount:${yandex_iam_service_account.sa-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "certificates-downloader" {
  # Сервисному аккаунту назначается роль 'certificate-manager.certificates.downloader'
  folder_id   = var.folder_id
  role        = "certificate-manager.certificates.downloader"
  member      = "serviceAccount:${yandex_iam_service_account.sa-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "compute-viewer" {
  # Сервисному аккаунту назначается роль 'compute.viewer'
  folder_id   = var.folder_id
  role        = "compute.viewer"
  member      = "serviceAccount:${yandex_iam_service_account.sa-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  # Сервисному аккаунту назначается роль 'container-registry.images.puller'
  folder_id   = var.folder_id
  role        = "container-registry.images.puller"
  member      = "serviceAccount:${yandex_iam_service_account.sa-account.id}"
}

resource "yandex_kms_symmetric_key" "kms-key" {
  # Ключ Yandex Key Management Service для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
  name              = var.kms_key_name
  default_algorithm = "AES_256"
  rotation_period   = "8760h" # 1 год.
}
