#!/usr/bin/env bash
set -euo pipefail

# script default options
RECREATE=false         # Whether to delete and recreate the minikube cluster. If true, runs `minikube delete` before `minikube start`.
NUM_NODE=3             # Number of nodes (including the control-plane node) to create in the cluster.
DRIVER=docker          # VM/container driver to use for minikube (e.g., docker, virtualbox, hyperkit, kvm).
CPUS=10                # Number of CPUs to allocate to the minikube VM/container.
MEM=8096               # Amount of memory (in MB) to allocate to the minikube VM/container.
PROXY_PORT=10808       # Proxy port to be used (currently not passed to `minikube start`, likely used elsewhere or reserved for future use).
unset FEATURE_GATES    # Unset the FEATURE_GATES env var so it doesn't accidentally influence the `minikube start` command.

# --- Recreate cluster if RECREATE ---
if [ ${RECREATE} == "true" ]; then
    minikube delete
fi

minikube start \
  --driver="${DRIVER}" \   # VM/container driver to use (e.g., docker).
  --nodes "${NUM_NODE}" \  # Total number of nodes in the cluster (1 control-plane + workers).
  --cpus ${CPUS} \         # Number of CPUs to allocate to each node.
  --memory ${MEM} \        # Memory in MB to allocate to each node.
  --embed-certs \          # Embed the certificates directly into the kubeconfig file instead of referencing external certificate files on disk.
  --cni=cilium             # Use Cilium as the CNI (Container Network Interface) plugin instead of the default.
