# School Data Hub Server

The Serverpod backend server for School Data Hub. This server provides the API endpoints, database management, and business logic for the School Data Hub application.

## Overview

The server is built with Serverpod 2.9.1, a Dart-based server framework that provides:
- RESTful API endpoints
- PostgreSQL database integration
- Redis for caching and sessions
- Authentication and authorization
- File storage management
- Background tasks (future calls)

## Prerequisites

- **Dart SDK**: >=3.3.0
- **Docker & Docker Compose**: For running PostgreSQL and Redis
- **Serverpod CLI**: Install globally with:
  ```bash
  dart pub global activate serverpod_cli
  ```

## Quick Start

### Using Docker Compose (Recommended)

The easiest way to get started is using Docker Compose:

1. Start the required services (PostgreSQL and Redis):
   ```bash
   docker compose up -d
   ```

   This starts:
   - PostgreSQL on port 8090 (development) and 9090 (test)
   - Redis on port 8091 (development) and 9091 (test)

2. Generate server code and create migrations:
   ```bash
   make generate
   ```

   Or manually:
   ```bash
   serverpod generate
   serverpod create-migration
   dart run bin/main.dart --role maintenance --apply-migrations
   ```

3. Run the server:
   ```bash
   make run
   ```

   Or manually:
   ```bash
   dart run bin/main.dart --apply-migrations
   ```

The server will start on `http://localhost:8080` by default.

### Configuration

Configuration files are located in the `config/` directory:
- `development.yaml` - Development environment
- `staging.yaml` - Staging environment
- `production.yaml` - Production environment
- `test.yaml` - Test environment

Edit these files to configure:
- Database connection strings
- Redis connection settings
- Server ports and URLs
- Email server configuration
- Storage paths

## Project Structure

```
lib/
├── server.dart                    # Server entry point
└── src/
    ├── _features/                 # Feature modules
    │   ├── admin/                 # Admin endpoints
    │   ├── attendance/            # Attendance management
    │   ├── auth/                  # Authentication
    │   ├── authorizations/        # Authorization management
    │   ├── books/                 # Library management
    │   ├── learning/              # Competence tracking
    │   ├── learning_support/      # Learning support plans
    │   ├── matrix/                # Matrix integration
    │   ├── pupil/                 # Pupil data management
    │   ├── school_data/           # School configuration
    │   ├── school_lists/          # School lists
    │   ├── schoolday/             # Schoolday management
    │   ├── schoolday_events/      # Schoolday events
    │   ├── timetable/             # Timetable management
    │   ├── user/                  # User management
    │   └── workbooks/             # Workbook management
    ├── _shared/                   # Shared models and endpoints
    ├── future_calls/              # Background tasks
    ├── generated/                 # Auto-generated code
    ├── helpers/                   # Helper functions
    ├── schemas/                   # Database schemas
    └── utils/                     # Utilities (mailer, logger, etc.)
config/                           # Environment configurations
migrations/                       # Database migration files
storage/                          # File storage
├── private/                      # Private files (avatars, documents, etc.)
└── public/                       # Public files
deploy/                           # Deployment configurations
├── aws/                          # AWS deployment (Terraform)
└── gcp/                          # GCP deployment
```

## Development

### Running the Server

Start the server in development mode:
```bash
make run
```

Or:
```bash
dart run bin/main.dart --apply-migrations
```

The `--apply-migrations` flag automatically applies any pending database migrations.

### Generating Code

When you modify models or endpoints, regenerate the code:
```bash
make generate
```

This runs:
1. `serverpod generate` - Generates protocol and client code
2. `serverpod create-migration` - Creates database migration
3. Applies the migration to the database

### Database Migrations

#### Creating Migrations

After modifying models, create a migration:
```bash
serverpod create-migration
```

#### Applying Migrations

Migrations are automatically applied when running with `--apply-migrations`, or manually:
```bash
dart run bin/main.dart --role maintenance --apply-migrations
```

#### Reviewing Migrations

Migrations are stored in `migrations/` directory. Each migration includes:
- `definition.json` - Model definitions
- `definition.sql` - SQL schema changes
- `migration.sql` - Migration SQL script

### Testing

Run tests:
```bash
dart test
```

For integration tests, ensure test services are running:
```bash
docker compose up -d
```

### Resetting the Development Environment

**Windows:**
```bash
make reset
```

**macOS/Linux:**
```bash
make reset_mac
```

This will:
- Remove all migrations and storage data
- Recreate directory structure
- Regenerate code and create new migrations
- Reset Docker volumes
- Apply migrations

⚠️ **Warning**: This deletes all data! Only use in development.

## Docker Management

### Accessing Database Containers

List running containers:
```bash
docker ps
```

Access PostgreSQL container shell:
```bash
docker exec -it <container_name> ash
```

Or using the service name:
```bash
docker exec -it school_data_hub_server-postgres-1 ash
```

### Database Access

Connect to PostgreSQL:
```bash
# Development database
docker exec -it school_data_hub_server-postgres-1 psql -U postgres -d school_data_hub

# Test database
docker exec -it school_data_hub_server-postgres_test-1 psql -U postgres -d school_data_hub_test
```

### Stopping Services

Stop all services:
```bash
docker compose down
```

Stop and remove volumes (⚠️ deletes data):
```bash
docker compose down --volumes
```

## Deployment

The server supports automated deployment via GitHub Actions. Multiple deployment strategies are available:

### GitHub Actions Deployment

GitHub Actions workflows are configured in `.github/workflows/`:

#### Docker Deployment (VPS)

Automated Docker deployment to Virtual Private Servers (VPS):

**Workflows:**
- `deployment-docker.yml` - Production deployment (triggers on `main` branch)
- `deployment-docker-staging.yml` - Staging deployment (triggers on `develop` or `staging` branches)

**How it works:**

1. **Build and Push**: Builds Docker image and pushes to GitHub Container Registry (ghcr.io)
2. **Deploy**: Connects to VPS via SSH and deploys using Docker Compose

**Prerequisites:**

Set up the following GitHub Secrets in your repository:

**SSH Configuration:**
- `SSH_PRIVATE_KEY` - Private SSH key for VPS access
- `SSH_USER` - SSH username (e.g., "github-actions")
- `SSH_HOST` - Production VPS hostname/IP
- `SSH_STAGING_HOST` - Staging VPS hostname/IP (for staging workflow)

**GitHub Access:**
- `PAT_GITHUB` or `PAT_TOKEN` - GitHub Personal Access Token
- `PAT_USER_GITHUB` - GitHub username for the PAT

**Production Server Configuration:**
- `SERVERPOD_DATABASE_NAME` - Database name
- `SERVERPOD_DATABASE_USER` - Database username
- `SERVERPOD_DATABASE_PASSWORD` - Database password
- `SERVERPOD_API_SERVER_PUBLIC_HOST` - API server domain
- `SERVERPOD_INSIGHTS_SERVER_PUBLIC_HOST` - Insights server domain
- `SERVERPOD_WEB_SERVER_PUBLIC_HOST` - Web server domain
- `SERVERPOD_MAX_REQUEST_SIZE` - Maximum request size in bytes
- `SERVERPOD_SERVICE_SECRET` - Service secret (minimum 20 characters)

**Staging Server Configuration:**
- `SERVERPOD_STAGING_DATABASE_NAME` - Staging database name
- `SERVERPOD_STAGING_DATABASE_USER` - Staging database username
- `SERVERPOD_STAGING_DATABASE_PASSWORD` - Staging database password
- `SERVERPOD_STAGING_API_SERVER_PUBLIC_HOST` - Staging API server domain
- `SERVERPOD_STAGING_INSIGHTS_SERVER_PUBLIC_HOST` - Staging Insights server domain
- `SERVERPOD_STAGING_WEB_SERVER_PUBLIC_HOST` - Staging Web server domain
- `SERVERPOD_STAGING_MAX_REQUEST_SIZE` - Staging max request size
- `SERVERPOD_STAGING_SERVICE_SECRET` - Staging service secret

**Optional Mail Configuration (Staging):**
- `SERVERPOD_MAIL_USERNAME` - SMTP username
- `SERVERPOD_MAIL_PASSWORD` - SMTP password
- `SERVERPOD_MAIL_SMTP_HOST` - SMTP host
- `SERVERPOD_MAIL_ADMIN` - Admin email address

**Deployment Process:**

1. **Automatic Trigger**: Pushes to `main` branch trigger production deployment
2. **Manual Trigger**: Go to **Actions** tab → Select workflow → **Run workflow**

The workflow will:
- Build Docker image for ARM64/ARMv7 architectures
- Push image to GitHub Container Registry
- Connect to VPS via SSH
- Pull latest image and restart services using Docker Compose

**Configuration:**

Update `.github/workflows/deployment-docker.yml`:
- `GHCR_ORG` - Your GitHub organization/username
- `branches` - Branches that trigger deployment

See `.github/workflows/deployment-docker.md` for detailed VPS setup instructions.

#### AWS Deployment

Deploy to AWS using CodeDeploy:

**Workflow:** `deployment-aws.yml`

**Trigger:**
- Pushes to `deployment-aws-production` or `deployment-aws-staging` branches
- Manual dispatch with target selection

**Prerequisites:**

Set up AWS secrets:
- `AWS_ACCESS_KEY_ID` - AWS access key
- `AWS_SECRET_ACCESS_KEY` - AWS secret key
- `SERVERPOD_PASSWORDS` - Serverpod passwords configuration (YAML content)

**Configuration:**

Update workflow variables:
- `DEPLOYMENT_BUCKET` - S3 bucket for deployments
- `AWS_NAME` - Application name in AWS

The workflow:
1. Compiles the server
2. Creates deployment package
3. Uploads to S3
4. Triggers AWS CodeDeploy deployment

**Infrastructure:**

Terraform configurations are available in `deploy/aws/terraform/` for:
- EC2 instances
- RDS database
- Redis cache
- CloudFront distribution

#### GCP Deployment

Deploy to Google Cloud Platform:

**Workflow:** `deployment-gcp.yml`

**Trigger:**
- Pushes to `deployment-gcp-production` or `deployment-gcp-staging` branches
- Manual dispatch with target selection

**Prerequisites:**

Set up GCP secrets:
- `GOOGLE_CREDENTIALS` - GCP service account credentials (JSON)
- `SERVERPOD_PASSWORDS` - Serverpod passwords configuration

**Configuration:**

Update workflow environment variables:
- `PROJECT` - GCP project ID
- `REGION` - GCP region (default: us-central1)
- `ZONE` - GCP zone (default: us-central1-c)

The workflow:
1. Authenticates to Google Cloud
2. Builds Docker image
3. Pushes to Google Container Registry
4. (Optional) Restarts instances in managed instance group

**Infrastructure:**

Terraform and Cloud Run configurations are available in `deploy/gcp/`.

### Manual Docker Deployment

For manual deployment without GitHub Actions:

Production Docker configuration is available in:
- `docker-compose.production.yaml`
- `docker-compose.staging.yaml`
- `Dockerfile.prod`

### Cloud Deployment

Deployment configurations are available in `deploy/`:
- **AWS**: Terraform configurations for EC2, RDS, Redis, and CloudFront
- **GCP**: Configurations for Cloud Run and GCE

See `deploy/` directories for platform-specific deployment instructions.

## Features

### Background Tasks (Future Calls)

The server supports background tasks:
- `database_backup_future_call.dart` - Automated database backups
- `increase_credit_future_call.dart` - Credit management tasks

### Mail Service

Email functionality is implemented via the `mailer` package. Configuration is managed through environment config files.

See `lib/src/utils/MAILER_README.md` for mail service documentation.

### Storage

File storage is organized in:
- `storage/private/` - Encrypted, private files (avatars, documents, events)
- `storage/public/` - Publicly accessible files

### UML Diagram Generation

Generate UML diagrams of your models:
```bash
make uml
```

This uses `uml_for_serverpod` to generate diagrams based on `uml_config.yaml`.

## Database Backups

Backups are stored in `database_backups/`. Automated backups can be configured through future calls.

## Logging

The server uses the `logging` package. Configure log levels and outputs in your environment configuration files.

## Security

- All sensitive data is encrypted
- Authentication via Serverpod Auth
- Authorization through user scopes
- Secure file storage for private documents

## Troubleshooting

### Common Issues

1. **Port Already in Use**: Change the port in your configuration file or stop the conflicting service.

2. **Database Connection Failed**: Ensure Docker containers are running:
   ```bash
   docker compose ps
   ```

3. **Migration Errors**: Review migration files in `migrations/` and ensure they're in the correct order.

4. **Storage Permission Errors**: Ensure the `storage/` directory has proper write permissions.

## Makefile Commands

- `make generate` - Generate code and apply migrations
- `make docker` - Start Docker containers
- `make reset` - Reset development environment (Windows)
- `make reset_mac` - Reset development environment (macOS/Linux)
- `make run` - Run the server
- `make uml` - Generate UML diagrams

## Resources

- [Serverpod Documentation](https://serverpod.dev)
- [Main README](../README.md)
- [Serverpod GitHub](https://github.com/serverpod/serverpod)
