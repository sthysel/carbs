# Ollama

Local LLM server for running models like LLaMA, Mistral, and vision models like LLaVA.

## Installation

```bash
caifs add -d targets ollama
```

## GPU Support (NVIDIA)

On Arch Linux, install both packages for GPU acceleration:

```bash
yay -S ollama ollama-cuda
sudo systemctl restart ollama
```

The `ollama-cuda` package provides `/usr/lib/ollama/libggml-cuda.so` which the base package loads at runtime.

Verify GPU is being used:

```bash
ollama ps
# Should show "100% GPU" not "100% CPU"
```

## Usage

```bash
# Pull a model
ollama pull llava           # Vision model, ~4GB
ollama pull llava:13b       # Larger/better, ~8GB
ollama pull gemma:2b        # Small text model

# Run interactively
ollama run llava "describe this image"

# List models
ollama list

# Check running models
ollama ps
```

## Model Storage

| OS              | Path                               |
|-----------------|------------------------------------|
| Linux           | `~/.ollama/models`                 |
| Linux (systemd) | `/usr/share/ollama/.ollama/models` |

Change storage location:

```bash
sudo systemctl edit ollama
```

Add:
```ini
[Service]
Environment="OLLAMA_MODELS=/mnt/bigdrive/ollama/models"
```

## Troubleshooting

### "Timed out waiting for llama runner to start"

Increase timeout and reduce parallelism:

```bash
sudo systemctl edit ollama
```

Add:
```ini
[Service]
Environment="OLLAMA_KEEP_ALIVE=10m"
Environment="OLLAMA_NUM_PARALLEL=1"
```

Then:
```bash
sudo systemctl daemon-reload
sudo systemctl restart ollama
```

### Debug Mode

```bash
sudo systemctl stop ollama
OLLAMA_DEBUG=1 ollama serve
```

### Enable NVIDIA Persistence Mode

Prevents GPU from entering low-power state:

```bash
sudo nvidia-smi -pm 1
```

### CUDA API Image Processing Bug

If API calls with images crash but interactive mode works:

```bash
# Temporary workaround - force CPU for single command
CUDA_VISIBLE_DEVICES="" your-command

# Permanent workaround - disable GPU globally
sudo systemctl edit ollama
# Add:
# [Service]
# Environment="CUDA_VISIBLE_DEVICES="
```

## Open WebUI (Web Interface)

ChatGPT-like interface for Ollama:

```bash
docker run -d -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  ghcr.io/open-webui/open-webui:main
```

Visit `http://localhost:3000`

If Open WebUI can't connect, ensure Ollama binds to all interfaces:

```bash
sudo systemctl edit ollama
# Add:
# [Service]
# Environment="OLLAMA_HOST=0.0.0.0"
```

## Other Web UIs

| UI        | Install              |
|-----------|----------------------|
| Hollama   | `yay -S hollama-bin` |
| Chatbox   | `yay -S chatbox-bin` |

## Model Recommendations (8GB VRAM)

| Model        | VRAM    | Notes                |
|--------------|---------|----------------------|
| `llava` (7B) | ~4-5GB  | Best fit for 8GB GPU |
| `llava:13b`  | ~8-10GB | May offload to RAM   |
| `llava:34b`  | ~20GB   | Won't fit            |

## API

Ollama exposes REST API at `http://localhost:11434`:

```bash
# List models
curl http://localhost:11434/api/tags

# Generate text
curl http://localhost:11434/api/generate -d '{
  "model": "llava",
  "prompt": "Hello"
}'
```
