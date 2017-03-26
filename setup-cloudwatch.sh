#!/bin/bash


# Download and install PIP
if [ ! -e "/usr/local/bin/pip" ]; then
  curl https://bootstrap.pypa.io/get-pip.py | python -
fi

# Install boto3
pip install boto3

# Symlink AWS credentials
if [ ! -d "$HOME/.aws" ]; then
  mkdir "$HOME/.aws"
fi

if [ ! -e "$HOME/.aws/credentials" ]; then
  ln -s /config/scripts/aws-credentials "$HOME/.aws/credentials"
fi