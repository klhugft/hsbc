# GENERALL
project = "pol-hsi-dev-001"
region  = "europe-west3"
 
# ROLES
sa_details = {
        "viewer" = {
            role              = "viewer"
            members           = ["terraform@pol-hsi-dev-001.iam.gserviceaccount.com"]
        },
        "pubsub.editor" = {
            role              = "pubsub.editor"
            members           = ["terraform@pol-hsi-dev-001.iam.gserviceaccount.com"]
        },
        "storage.objectAdmin" = {
            role              = "storage.objectAdmin"
            members           = [
                                 "terraform@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-dev@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-sit@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-uat@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "cloud-run-pubsub-invoker-dev@pol-hsi-dev-001.iam.gserviceaccount.com"
                                ]
        },
        "storage.objectViewer" = {
            role              = "storage.objectViewer"
            members           = [
                                 "big-query-data-admin@pol-hsi-dev-001.iam.gserviceaccount.com"
                                ]
        },
        "composer.ServiceAgentV2Ext" = {
            role              = "composer.ServiceAgentV2Ext"
            members           = ["service-345639674199@cloudcomposer-accounts.iam.gserviceaccount.com"]
        },
        "iam.serviceAccountUser" = {
            role              = "iam.serviceAccountUser"
            members           = [
                                 "terraform@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-dev@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-sit@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-uat@pol-hsi-dev-001.iam.gserviceaccount.com"
                                ]
        },
        "composer.worker" = {
            role              = "composer.worker"
            members           = [
                                 "composer-sa-dev@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-sit@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-uat@pol-hsi-dev-001.iam.gserviceaccount.com"
                                ]
        },
        "pubsub.publisher" = {
            role              = "pubsub.publisher"
            members           = ["service-345639674199@gs-project-accounts.iam.gserviceaccount.com"]
        },
        "run.invoker" = {
            role              = "run.invoker"
            members           = [
                                 "cloud-run-pubsub-invoker-dev@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "cloud-run-pubsub-invoker-sit@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "cloud-run-pubsub-invoker-uat@pol-hsi-dev-001.iam.gserviceaccount.com"
                                ]
        },
        "iam.serviceAccountTokenCreator" = {
            role              = "iam.serviceAccountTokenCreator"
            members           = ["service-345639674199@gcp-sa-pubsub.iam.gserviceaccount.com"]
        },
        "bigquery.jobUser" = {
            role              = "bigquery.jobUser"
            members           = ["composer-sa-dev@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-sit@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-uat@pol-hsi-dev-001.iam.gserviceaccount.com"]            
        },
        "bigquery.dataViewer" = {
            role              = "bigquery.dataViewer"
            members           = ["composer-sa-dev@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-sit@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-uat@pol-hsi-dev-001.iam.gserviceaccount.com"]            
        },
        "bigquery.user" = {
            role              = "bigquery.user"
            members           = ["composer-sa-dev@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-sit@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-uat@pol-hsi-dev-001.iam.gserviceaccount.com"]                 
        },
        "bigquery.admin" = {
            role              = "bigquery.admin"
            members           = ["big-query-data-admin@pol-hsi-dev-001.iam.gserviceaccount.com",
                                 "composer-sa-dev@pol-hsi-dev-001.iam.gserviceaccount.com"]                 
        }
}

# SERVICE ACCOUNTS DETAILS 
service_accounts = {
        "terraform" = {
            account_id      = "terraform"
            display_name    = "terraform"
            description     = "Service account for terraform deployment purposes"
        },
        "jenkins" = {
            account_id      = "jenkins"
            display_name    = "jenkins"
            description     = "Service account for jenkins"
        },
        "composer-sa" = {
            account_id      = "composer-sa-dev"
            display_name    = "service account for composer"
            description     = "Service account for composer deployment purposes"
        },
        "composer-sa-sit" = {
            account_id      = "composer-sa-sit"
            display_name    = "service account for composer"
            description     = "Service account for sit composer deployment purposes"
        },
        "composer-sa-uat" = {
            account_id      = "composer-sa-uat"
            display_name    = "service account for composer"
            description     = "Service account for uat composer deployment purposes"
        },
        "cloud-run-pubsub-invoker" = {
            account_id      = "cloud-run-pubsub-invoker-dev"
            display_name    = "service account for CloudRun"
            description     = "Service account for Invoking Cloud run from PubSub Masages"
        },
        "cloud-run-pubsub-invoker-sit" = {
            account_id      = "cloud-run-pubsub-invoker-sit"
            display_name    = "service account for CloudRun"
            description     = "Service account for Invoking Cloud run from PubSub Masages"
        },
        "cloud-run-pubsub-invoker-uat" = {
            account_id      = "cloud-run-pubsub-invoker-uat"
            display_name    = "service account for CloudRun"
            description     = "Service account for Invoking Cloud run from PubSub Masages"
        },
        "big-query-data-admin" = {
            account_id      = "big-query-data-admin"
            display_name    = "service account for BigQuery"
            description     = "Service account for owning bigquery data"
        }
}

# LIST OF APIS TO ENABLE
api_name = [
            # "cloudbuild.googleapis.com",
            # "dlp.googleapis.com",
            # "bigquerydatapolicy.googleapis.com"
            "sql-component.googleapis.com",
            "storage-component.googleapis.com",
            "compute.googleapis.com",
            "dataflow.googleapis.com",
            "pubsub.googleapis.com",
            "iam.googleapis.com",
            "composer.googleapis.com",
            "run.googleapis.com",
            "datastudio.googleapis.com",
            "runtimeconfig.googleapis.com",
            "cloudkms.googleapis.com"
            # "datacatalog.googleapis.com",
            # "secretmanager.googleapis.com"
            ]