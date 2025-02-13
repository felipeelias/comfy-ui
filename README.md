# ComfyUI with ComfyUI-Manager Docker Image

This repository contains a Dockerfile to build an image for running [ComfyUI](https://github.com/comfyanonymous/ComfyUI) along with [ComfyUI-Manager](https://github.com/ltdrdata/ComfyUI-Manager).

This specifically focus on the [NVIDIA GPU support](https://github.com/comfyanonymous/ComfyUI?tab=readme-ov-file#nvidia).

## Using the Image

To use the image, you can pull it from GitHub Container Registry:

```bash
docker pull ghcr.io/felipeelias/comfy-ui:latest
```

Or use a specific version:

```bash
docker pull ghcr.io/felipeelias/comfy-ui:comfyui-0.3.14-comfyui-manager-3.18.1
```

If you have a docker compose file, you can use the following:

```yaml
services:
  comfyui:
    image: ghcr.io/felipeelias/comfy-ui:latest
    ports:
      - 8188:8188
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              capabilities: [ "gpu" ]
              count: all
```

## Building the Image

To build the image, you can use the following command:

```bash
docker build \
  --build-arg COMFYUI_VERSION=... \
  --build-arg COMFYUI_MANAGER_VERSION=... \
  -t comfyui-manager:latest .
```

Check the versions of ComfyUI and ComfyUI-Manager you want to use in:

* https://github.com/comfyanonymous/ComfyUI/releases
* https://github.com/ltdrdata/ComfyUI-Manager/tags
