FROM python:3.13-slim-bookworm

ARG COMFYUI_VERSION
ARG COMFYUI_MANAGER_VERSION

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt update -qq && \
  apt -y dist-upgrade && \
  apt -y install --no-install-recommends --no-install-suggests wget unzip pkg-config cmake build-essential git && \
  apt clean && \
  apt -y autoremove && \
  rm -rf /var/lib/{apt,dpkg,cache,log} && \
  rm -rf /var/cache/* && \
  rm -rf /var/log/apt/* && \
  rm -rf /tmp/*

RUN pip install --upgrade pip
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu126

RUN wget https://github.com/comfyanonymous/ComfyUI/archive/refs/tags/v${COMFYUI_VERSION}.zip -O comfyui.zip && \
  unzip comfyui.zip && \
  mv ComfyUI-${COMFYUI_VERSION}/* . && \
  rm -rf ComfyUI-${COMFYUI_VERSION} comfyui.zip

RUN wget https://github.com/ltdrdata/ComfyUI-Manager/archive/refs/tags/${COMFYUI_MANAGER_VERSION}.zip -O manager.zip && \
  unzip manager.zip -d /app/custom_nodes && \
  mv /app/custom_nodes/ComfyUI-Manager-${COMFYUI_MANAGER_VERSION} /app/custom_nodes/comfyui-manager && \
  rm manager.zip

RUN pip install -r requirements.txt -r /app/custom_nodes/comfyui-manager/requirements.txt

EXPOSE 8188

CMD ["python", "main.py", "--listen", "0.0.0.0", "--front-end-version", "Comfy-Org/ComfyUI_frontend@latest"]
