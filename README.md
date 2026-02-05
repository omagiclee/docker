# docker

## Build Docker Image
### Install Docker

### Pull NVIDIA CUDA Base Image

```shell
docker pull nvidia/cuda:13.1.1-cudnn-devel-ubuntu24.04
```

### Download oh-my-zsh & plugins
```shell
mkdir oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o oh-my-zsh/oh-my-zsh-install.sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions oh-my-zsh
```

### Download Miniconda
```shell
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

### Download Torch Wheels
```zsh
mkdir torch_wheels
pip3 download torch torchvision --index-url https://download.pytorch.org/whl/cu130 -d torch_wheels
```

### Docker Build 
```shell
# docker build
DOCKER_BUILDKIT=1 docker build -t ubuntu24.04-cuda13.1.1-torch2.10.0:v1 .
```

## Docker Run
### Install nvidia-container-toolkit

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#

### Docker Run
```shell
# 仅本地 shell（不启用 SSH）
docker run --gpus all -it ubuntu24.04-cuda13.1.1-torch2.10.0:v1

# 启用 SSH：映射 22，可通过 -e PASSWORD=xxx 设 root 密码
docker run -d --gpus all -p 2222:22 -e PASSWORD=yourpassword ubuntu24.04-cuda13.1.1-torch2.10.0:v1
# PyTorch DataLoader 常需更大共享内存，建议加上：
docker run -d --gpus all -p 2222:22 --shm-size=16g -e PASSWORD=yourpassword ubuntu24.04-cuda13.1.1-torch2.10.0:v1
```