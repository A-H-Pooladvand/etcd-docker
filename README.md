## Etcd using Docker Compose

This project sets up an Etcd container for distributed key-value storage.

## Prerequisites

*   Docker installed and running ([https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/))
*   Docker Compose installed and running ([https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/))

## Environment Variables

This docker-compose.yml file utilizes environment variables to customize configurations. You can set these variables before running commands:

*   **(Optional)** `ETCD_ROOT_PASSWORD`: Password for the Etcd root user (**Not recommended for production due to security risks**)
*   **(Optional)** `ALLOW_NONE_AUTHENTICATION`: Enable unauthenticated access to Etcd (**Highly insecure, not recommended for production**)
*   `ETCD_ADVERTISE_CLIENT_URLS`: URL clients can use to advertise themselves (defaults to `http://etcd:2379`)
*   `ETCD_LISTEN_CLIENT_URLS`: URL clients can use to connect (defaults to `https://0.0.0.0:2379`)
*   `ETCD_ADVERTISE_PEER_URLS`: URL peers can use to advertise themselves (defaults to `https://localhost:2379`)
*   `ETCD_LISTEN_PEER_URLS`: URL peers can use to connect (defaults to `https://0.0.0.0:2380`)
*   `ETCD_INITIAL_ADVERTISE_PEER_URLS`: Initial URL for peer discovery (defaults to `https://localhost:2380`)
*   `ETCD_INITIAL_CLUSTER`: Comma-separated list of initial cluster members (defaults to `etcd0=https://localhost:2380`)
*   `ETCD_INITIAL_CLUSTER_STATE`: Cluster state (`new` or `existing`)
*   `ETCD_CERT_FILE`: Path to the server certificate file (requires volume mount for `/certs`)
*   `ETCD_KEY_FILE`: Path to the server key file (requires volume mount for `/certs`)
*   `ETCD_TRUSTED_CA_FILE`: Path to the trusted certificate authority file (requires volume mount for `/certs`)
*   `ETCD_CLIENT_CERT_AUTH`: Enable client certificate authentication (requires certificate files)
*   `ETCD_PEER_CERT_FILE`: Path to the peer certificate file (requires volume mount for `/certs`)
*   `ETCD_PEER_KEY_FILE`: Path to the peer key file (requires volume mount for `/certs`)
*   `ETCD_PEER_TRUSTED_CA_FILE`: Path to the trusted CA file for peer authentication (requires volume mount for `/certs`)
*   `ETCD_PEER_CLIENT_CERT_AUTH`: Enable peer client certificate authentication (requires certificate files)

**Security Note:** Disabling authentication or using a root password is highly insecure and not recommended for production environments.

## Usage

1.  **Create a `.env` file (optional):**

*   Create a file named `.env` in the same directory as your `docker-compose.yml` file.

*   Add environment variable definitions in the format `KEY=VALUE`, one per line. For example, to configure client certificate authentication:

    ```
    ETCD_CLIENT_CERT_AUTH=true
    ETCD_CERT_FILE=/certs/server.pem
    ETCD_KEY_FILE=/certs/server-key.pem
    ETCD_TRUSTED_CA_FILE=/certs/ca.pem
    # ... (similar definitions for peer certificate files)
    ```


2.  **Prepare certificates (if using certificate authentication):**

*   Generate and mount the necessary certificates (server, client, peer, and CA) to the `/certs` volume.

3.  **Start the service:**

Bash

```
docker-compose up -d
```

Use code [with caution.](/faq#coding)

This will create and start the Etcd container in detached mode (background).

## Stopping and Removing Services

*   Stop:

Code snippet

```
docker-compose stop
```

Use code [with caution.](/faq#coding)

*   Remove:

Code snippet

```
docker-compose down
```

Use code [with caution.](/faq#coding)

## Configuration

This docker-compose file defines various configurations for the Etcd container:

*   **Environment Variables:** As mentioned earlier, you can customize settings by overriding environment variables.
*   **Volumes:**
    *   `./certs:/certs:rw`: Mounts the local `certs` directory containing certificates (if used).
    *   `etcd-data:/bitnami/etcd/data`: Persistent storage for Etcd data.
*   **Ports:**
    *   `2379:2379`: Exposes