# Use NVIDIA CUDA runtime as base (choose matching CUDA version for vllm)
FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip git \
 && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# Copy your code into the image
WORKDIR /workspace
COPY . .

# Install MergeKit (editable install, evolve & vllm extras)
RUN pip install -e .[evolve,vllm]

# Install optional extras
RUN pip install wandb

# Set default command to bash (so the container starts without exiting)
CMD ["/bin/bash"]
