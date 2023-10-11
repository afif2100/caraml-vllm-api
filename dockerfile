# Stage 1: Base image
FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime as base
# FROM nvidia/cuda:11.8.0-devel-ubuntu22.04 as base

# Set environment variables
# ENV LLM_MODEL_NAME="meta-llama/Llama-2-7b-chat-hf"
ENV TRANSFORMERS_OFFLINE=1
ENV HF_HUB_OFFLINE=1

# Install additional packages
RUN apt-get update && apt-get install -y \
    make \
    gcc \
    g++ \
    curl \
    wget 

# Set working directory
FROM base as requirement-installer
WORKDIR /app

# Copy Python requirements file and install dependencies
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

FROM requirement-installer as model-builder

# Stage 2: Copy model and code
WORKDIR /app
COPY . .

# Define the default command to run when the container starts
CMD [ "make", "run" ]
