# Serverpod Deployment to a VPS using Docker

> 💡 Deploying Serverpod to a Virtual Private Server (VPS) using Docker is a
> cost-effective and scalable solution for startups and small- to medium-scale
> projects.

This guide walks you through deploying a server built using the Serverpod
framework to a Virtual Private Server (VPS) with Docker.

Serverpod is a Flutter/Dart backend framework offering database integration and
seamless client–server communication. VPS deployment provides a cost-effective
solution for small to medium projects.

The setup allows vertical scaling through VM upgrades and can be extended to
horizontal scaling with load balancers. This guide helps you create a
production-ready Docker Compose deployment.

To reduce the workload on the machine, we do not use Redis in this deployment.
(Redis becomes necessary when you want to scale your application horizontally.)

> 💡 In many cases, scaling vertically is sufficient and saves you the hassle of
> setting up a load balancer and additional infrastructure. Always start with
> vertical scaling and only scale horizontally if you need to.

## Prerequisites

- This guide assumes you have basic knowledge of Serverpod and command-line usage.
- This guide contains terminal commands that are specific to Unix-based systems (macOS & Linux).
- The `docker-compose.production.yaml` file is configured to run on ARM machines.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Table of Contents](#table-of-contents)
- [Preparing the server](#preparing-the-server)
  - [Registering at Hetzner Cloud](#registering-at-hetzner-cloud)
  - [Setting up an SSH key to connect to the server](#setting-up-an-ssh-key-to-connect-to-the-server)
  - [Creating a new server](#creating-a-new-server)
  - [Setting up the server](#setting-up-the-server)
    - [Step 1: Create the new user](#step-1-create-the-new-user)
    - [Step 2: Grant Docker permissions](#step-2-grant-docker-permissions)
    - [Step 3: Enable SSH access](#step-3-enable-ssh-access)
    - [Step 4: Set up SSH key-based authentication](#step-4-set-up-ssh-key-based-authentication)
  - [Firewall configuration](#firewall-configuration)
- [Preparing the domain](#preparing-the-domain)
- [Preparing the repository](#preparing-the-repository)
  - [Getting a GitHub Personal Access Token](#getting-a-github-personal-access-token)
  - [Adding the secrets to the repository](#adding-the-secrets-to-the-repository)
- [Creating the deployment files](#creating-the-deployment-files)
- [Configuring SSL-certificates](#configuring-ssl-certificates)
- [Configuring the GitHub-Action](#configuring-the-github-action)
- [Running the GitHub-Action](#running-the-github-action)
- [Using the Serverpod Insights app](#using-the-serverpod-insights-app)
- [Connecting your Flutter client](#connecting-your-flutter-client)
- [Connecting to the Database using DBeaver](#connecting-to-the-database-using-dbeaver)
- [Multi-Environment Setup (Staging + Production)](#multi-environment-setup-staging--production)

## Preparing the server

This guide uses Hetzner Cloud. You can use any server provider, but Hetzner is a
good and cost-effective option. If you want to use another architecture or
provider, check the Docker Compose file and the deployment script for any
necessary changes. Currently, the deployment is meant to run on ARM machines.

### Registering at Hetzner Cloud

Register an account at Hetzner Cloud and create a new project.  
[Use this referral link to get €20 credits for free at Hetzner Cloud](https://hetzner.cloud/?ref=BFdFFipLgfDs)

Next, go to the [Cloud Console](https://console.hetzner.cloud/) and create a project.

### Setting up an SSH key to connect to the server

In order to configure your server, you need to access it through SSH. Create an
SSH keypair if you don't have one yet. If you are not sure whether you already
have one, you can check by running:

```bash
cat ~/.ssh/id_rsa.pub
```

To create a new keypair, run the following command. Leave all options at their
default values by pressing enter.

```bash
ssh-keygen -t rsa -b 4096
```

When asked for a password, don't enter anything—just press enter. This will
create a keypair in `~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`.

Copy the public key to your clipboard:

```bash
cat ~/.ssh/id_rsa.pub
```

Select the output and copy it.

In your Hetzner project, follow these steps:

1. In the left-hand menu, click on **Security** > **SSH keys** > **Add SSH key**.
2. Paste the public key you generated earlier.

### Creating a new server

Continuing in your Hetzner project, create a new server:

1. In the left-hand menu, go to **Server** and click **Create server**.
2. In the **Image** section, click on **Apps** and select **Docker CE**.
3. **Type/Architecture:** Select **vCPU** and **Arm64 (Ampere)**. The smallest tier is sufficient for most projects—you can always upgrade the specs later.
4. Ensure that the public IPv4 address is enabled.
5. In the SSH-Keys section, make sure your SSH key is selected.
6. Name your server and create it.

### Setting up the server

Once the server is created, you can connect to it using SSH. Find the server IP
in the Hetzner Cloud Console and connect using the following command:

```bash
ssh root@<your-server-ip>
```

When prompted with "Are you sure you want to continue connecting? [...]" type "yes" and press enter.

> If you are asked for a password, it means the SSH key was not added correctly.
> Delete the corresponding entry from `~/.ssh/known_hosts` and delete the
> server. Then create a new server and ensure the SSH key is added correctly.

For security reasons, we will create a new user to manage the deployment. This user will not have root privileges.

#### Step 1: Create the new user

```bash
sudo adduser github-actions
```

Replace `github-actions` with your desired username. This command will prompt
you to set a password and enter user information.

#### Step 2: Grant Docker permissions

Add the user to the `docker` group so they can run Docker commands:

```bash
sudo usermod -aG docker github-actions
```

#### Step 3: Enable SSH access

SSH access is available by default for any user on the server. However, to ensure proper access, check the `sshd_config` file:

```bash
sudo nano /etc/ssh/sshd_config
```

Find or add the `AllowUsers` directive. This directive specifies which users are
allowed to SSH into the server. If it doesn't exist, add it at the end of the
file. If there are multiple users, separate them with spaces:

```text
AllowUsers root github-actions
```

To save and exit the file, press `Ctrl + X`, then `Y`, and finally `Enter`. Restart the SSH service to apply the changes:

```bash
sudo systemctl restart ssh
```

#### Step 4: Set up SSH key-based authentication

1. Log in as the new user:

   ```bash
   su - github-actions
   ```

2. Create an SSH keypair:

   ```bash
   ssh-keygen -t rsa -b 4096
   ```

   Leave the options at their default values by pressing enter.

3. Add the public SSH key to the `authorized_keys` file:

   ```bash
   cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
   ```

4. Copy the private key to your clipboard—including the lines `-----BEGIN OPENSSH PRIVATE KEY-----` and `-----END OPENSSH PRIVATE KEY-----`. Save this key in a secure location, as you will need it later. To display the private key, run:

   ```bash
   cat ~/.ssh/id_rsa
   ```

5. Logout from the github-actions user:

   ```bash
   exit
   ```

6. Restart the SSH service to apply changes:

   ```bash
   sudo systemctl restart ssh
   ```

### Firewall configuration

In the Hetzner Web Interface, enter your server configuration and click on **Firewalls**, then click **Create Firewall**.

By default, there will be two inbound rules: one for SSH (port 22) and one for ICMP. We will add two more for HTTP and HTTPS.

1. Click on **Add Rule**, name it HTTP, set the port to 80, and choose TCP as the protocol.
2. Click on **Add Rule**, name it HTTPS, set the port to 443, and choose TCP as the protocol.
3. In the "apply to" section, make sure your server is selected.
4. Click **Create Firewall**.

## Preparing the domain

To access your server, you need to have a domain. You can purchase a domain from
any provider (e.g., [Namecheap](https://www.namecheap.com/) or
[GoDaddy](https://www.godaddy.com/)).

Once you have a domain, set up the DNS records to point to your server. Create
the following DNS records, replacing `Your server IP` with the IP address of
your server:

| Type | Name     | Value          |
| ---- | -------- | -------------- |
| A    | api      | Your server IP |
| A    | web      | Your server IP |
| A    | insights | Your server IP |

The full domains will be `api.your-domain.com`, `web.your-domain.com`, and `insights.your-domain.com`.

## Preparing the repository

### Getting a GitHub Personal Access Token

1. Create a new Personal Access Token (PAT) on GitHub:
   - Click on your profile picture in the top-right corner.
   - Navigate to **Settings** > **Developer settings** > **Personal access tokens** > **Tokens (classic)**.
   - Click on **Generate new token**.

2. Fill in the required fields:
   - In the **Note** field, set a name for the token, e.g., "Serverpod Deployment".
   - Set the expiration to **No expiration**.

3. Select the necessary scopes:
   - **repo**: Required to read repositories, especially private ones.
   - **write:packages**: Required to push Docker images to the GitHub Package Registry.

4. Generate and save the token:
   - Scroll to the bottom and click **Generate token**.
   - Copy the token and save it in a secure place.

### Adding the secrets to the repository

Go to your Serverpod project repository, then navigate to **Settings** > **Secrets and variables** > **Actions** and create the following secrets:

| Secret Name     | Value                                                           |
| --------------- | --------------------------------------------------------------- |
| PAT_USER_GITHUB | Your GitHub username                                            |
| PAT_GITHUB      | Your GitHub PAT token                                           |
| SSH_HOST        | The IP address of your server                                   |
| SSH_USER        | The username you created on the server (e.g., "github-actions") |
| SSH_PRIVATE_KEY | The private key you generated on the server                     |

The following secrets configure Serverpod and the database:

| Secret Name                           | Value                                                                                                       |
| ------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| SERVERPOD_DATABASE_NAME               | The name of the database (e.g., "serverpod")                                                                |
| SERVERPOD_DATABASE_USER               | The database user (e.g., "serverpod")                                                                       |
| SERVERPOD_DATABASE_PASSWORD           | The database password                                                                                       |
| SERVERPOD_API_SERVER_PUBLIC_HOST      | The domain for the API server (e.g., api.my-domain.com)                                                     |
| SERVERPOD_WEB_SERVER_PUBLIC_HOST      | The domain for the Web server (e.g., web.my-domain.com)                                                     |
| SERVERPOD_INSIGHTS_SERVER_PUBLIC_HOST | The domain for the Insights server (e.g., insights.my-domain.com)                                           |
| SERVERPOD_SERVICE_SECRET              | The same value as in your local `passwords.yaml` file, required to connect using the Serverpod Insights app |

## Creating the deployment files

The CLI will generate all necessary deployment files for your project.

1. Install the Serverpod VPS CLI:

   ```bash
   dart pub global activate serverpod_vps
   ```

2. Navigate to your Serverpod project directory:

   ```bash
   cd my_serverpod_project
   ```

3. Run the CLI to generate deployment files:

   ```bash
   serverpod_vps
   ```

4. When prompted, enter your email address for SSL certificate notifications.

## Configuring SSL-certificates

All external connections are secured by Traefik through HTTPS. Traefik uses
[Let's Encrypt](https://letsencrypt.org/) to automatically generate SSL
certificates for your domains.

If you need to change the email address that Let's Encrypt uses for certificate
notifications, edit the email address in the `docker-compose.production.yaml`
file. Open the file and modify the value of the parameter
`certificatesresolvers.myresolver.acme.email`.

## Configuring the GitHub-Action

From the root of your repository, open the `.github/workflows/deployment-docker.yml` file and adjust the following settings:

- Update the `GHCR_ORG` variable by replacing `<ORGANIZATION>` with your GitHub username or organization name.
- At the top of the file, you can change the branches that automatically trigger the deployment. By default, it is set to `main`. You can also trigger the action manually on a different branch.

## Running the GitHub-Action

Push your changes to the repository on the configured branch.

To manually trigger the action, go to the **Actions** tab in your repository,
click on the **Deploy to Docker** workflow, then click **Run workflow** and
select the branch you want to deploy.

## Using the Serverpod Insights app

To enable the [Serverpod Insights app](https://docs.serverpod.dev/tools/insights),
adjust the insights server host in `production.yaml` to the domain you set up in
your DNS records. Ensure that the service secret specified in the repository
secrets matches the one in your local `passwords.yaml` file for production.

## Connecting your Flutter client

To connect with your generated client, use the domain you set up in the DNS.
Make sure to use HTTPS without any port numbers (e.g.,
`https://api.my-domain.com`).

## Connecting to the Database using DBeaver

To manage your database, you can use a tool like [DBeaver](https://dbeaver.io/).
To connect to the database, set up an SSH tunnel to the server using the
following example:

1. Open DBeaver and click the **New Database Connection** button (usually in the top-left corner).
2. Select **PostgreSQL** and click **Next**.
3. Click the **SSH** tab.
4. Check **Use SSH tunnel**.
5. Set the following values:
   - **Host/IP:** Your server IP
   - **Port:** 22
   - **Username:** root
   - **Authentication method:** Public key
   - **Private key:** The private key on your machine you [generated earlier](#setting-up-an-ssh-key-to-connect-to-the-server)
6. Click **Test tunnel** to verify the connection.
7. Return to the **Main** tab.
8. Set the following values:
   - **Host:** localhost
   - **Port:** 5432
   - **Database:** The database name you set in the [repository secrets](#adding-the-secrets-to-the-repository)
   - **User name:** The database user you set in the [repository secrets](#adding-the-secrets-to-the-repository)
   - **Password:** The database password you set in the [repository secrets](#adding-the-secrets-to-the-repository)
9. Test the connection and save it.

---

## Multi-Environment Setup (Staging + Production)

The Serverpod VPS generator now supports multiple deployment environments for a **omplete Development Pipeline**.

### Overview

- **Production Environment**: For live production deployments (main branch)
- **Staging Environment**: For testing and staging deployments (develop/staging branch)

### Commands

#### Production Environment
```bash
serverpod_vps_production
```
or
```bash
serverpod_vps  # Default behavior
```

#### Staging Environment
```bash
serverpod_vps_staging
```

### Generated Files

#### Production Environment
- `.github/workflows/deployment-docker-production.yml`
- `{{school_data_hub}}_server/docker-compose.production.yaml`
- `{{school_data_hub}}_server/Dockerfile.prod`

#### Staging Environment
- `.github/workflows/deployment-docker-staging.yml`
- `{{school_data_hub}}_server/docker-compose.staging.yaml`
- `{{school_data_hub}}_server/Dockerfile.prod` (shared)

### GitHub Secrets Configuration for Multi-Environment

You'll need to configure the following secrets in your GitHub repository:

#### Shared Secrets
- `SSH_PRIVATE_KEY`: SSH private key for connecting to both VPS servers
- `SSH_USER`: SSH username for connecting to VPS servers
- `PAT_GITHUB`: GitHub personal access token
- `PAT_USER_GITHUB`: GitHub username for the PAT

#### Production Secrets (Legacy Names - No Prefix)
- `SSH_HOST`: Production VPS hostname/IP (for backward compatibility)
- `SERVERPOD_DATABASE_NAME`: Production database name
- `SERVERPOD_DATABASE_USER`: Production database username
- `SERVERPOD_DATABASE_PASSWORD`: Production database password
- `SERVERPOD_API_SERVER_PUBLIC_HOST`: Production API server hostname
- `SERVERPOD_INSIGHTS_SERVER_PUBLIC_HOST`: Production Insights server hostname
- `SERVERPOD_WEB_SERVER_PUBLIC_HOST`: Production Web server hostname
- `SERVERPOD_MAX_REQUEST_SIZE`: Production max request size
- `SERVERPOD_SERVICE_SECRET`: Production service secret (min 20 chars)

#### Staging Secrets
- `SSH_STAGING_HOST`: Staging VPS hostname/IP
- `SERVERPOD_STAGING_DATABASE_NAME`: Staging database name
- `SERVERPOD_STAGING_DATABASE_USER`: Staging database username
- `SERVERPOD_STAGING_DATABASE_PASSWORD`: Staging database password
- `SERVERPOD_STAGING_API_SERVER_PUBLIC_HOST`: Staging API server hostname
- `SERVERPOD_STAGING_INSIGHTS_SERVER_PUBLIC_HOST`: Staging Insights server hostname
- `SERVERPOD_STAGING_WEB_SERVER_PUBLIC_HOST`: Staging Web server hostname
- `SERVERPOD_STAGING_MAX_REQUEST_SIZE`: Staging max request size
- `SERVERPOD_STAGING_SERVICE_SECRET`: Staging service secret (min 20 chars)

### Branch Strategy

#### Production Deployment
- Triggered by pushes to the `main` branch
- Uses the `latest` Docker image tag
- Deploys to production VPS

#### Staging Deployment
- Triggered by pushes to `develop` or `staging` branches
- Uses the `staging` Docker image tag
- Deploys to staging VPS

### VPS Setup Requirements

You'll need two VPS servers:

1. **Production VPS**: For live production environment
2. **Staging VPS**: For testing and staging environment

Both servers should be configured with:
- Docker and Docker Compose installed
- SSH access configured
- Same SSH key for GitHub Actions access
- Appropriate firewall rules for ports 80 and 443

### Setting Up Both Servers with Shared SSH Key

#### Step 1: Set Up Your First Server (Production)

Follow the complete server setup steps described in the main guide above for your production server, including:
- Creating the `github-actions` user
- Setting up Docker permissions
- Generating the SSH keypair
- Configuring SSH access

#### Step 2: Copy SSH Key to Second Server (Staging)

After setting up your first server, you'll use the same SSH key for your staging server:

1. **Get the public key from your production server:**
   ```bash
   # SSH into your production server
   ssh github-actions@your-production-server-ip
   
   # Display and copy the public key
   cat ~/.ssh/id_rsa.pub
   ```
   Copy the entire public key output to your clipboard.

2. **Set up the staging server:**
   ```bash
   # SSH into your staging server as root
   ssh root@your-staging-server-ip
   
   # Create the github-actions user
   sudo adduser github-actions
   sudo usermod -aG docker github-actions
   
   # Configure SSH access (add to /etc/ssh/sshd_config if needed)
   # AllowUsers root github-actions
   
   # Switch to the github-actions user
   su - github-actions
   
   # Create the .ssh directory with proper permissions
   mkdir -p ~/.ssh
   chmod 700 ~/.ssh
   
   # Add the public key from your production server
   echo "paste-your-public-key-here" >> ~/.ssh/authorized_keys
   chmod 600 ~/.ssh/authorized_keys
   
   # Exit back to root
   exit
   
   # Restart SSH service
   sudo systemctl restart ssh
   ```

3. **Test SSH access to both servers:**
   ```bash
   # Test production server
   ssh github-actions@your-production-server-ip "echo Production SSH working"
   
   # Test staging server  
   ssh github-actions@your-staging-server-ip "echo Staging SSH working"
   ```

4. **Get the private key for GitHub secrets:**
   ```bash
   # From your production server, display the private key
   ssh github-actions@your-production-server-ip "cat ~/.ssh/id_rsa"
   ```
   Copy the entire private key (including `-----BEGIN OPENSSH PRIVATE KEY-----` and `-----END OPENSSH PRIVATE KEY-----` lines) and use this as your `SSH_PRIVATE_KEY` secret in GitHub.

#### Step 3: Configure GitHub Secrets

With the shared SSH key approach, your GitHub secrets will be:

**Shared Secrets:**
- `SSH_PRIVATE_KEY`: The private key from your production server
- `SSH_USER`: `github-actions` (same username for both servers)
- `PAT_GITHUB` and `PAT_USER_GITHUB`: GitHub access tokens

**Production Secrets:**
- `SSH_HOST`: Your production server IP
- All other `SERVERPOD_*` secrets (without prefix)

**Staging Secrets:**
- `SSH_STAGING_HOST`: Your staging server IP  
- All `SERVERPOD_STAGING_*` secrets

> **💡 Workflow Implementation**: The generated GitHub Actions workflows are already configured to use the shared SSH key approach. Both workflows use the same `SSH_PRIVATE_KEY` and `SSH_USER` secrets, differing only in the target server (`SSH_HOST` vs `SSH_STAGING_HOST`).

This approach simplifies key management while maintaining security isolation between environments.


