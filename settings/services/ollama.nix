{user, ...}: {
  services.ollama = {
    enable = true;

    loadModels = [
      "llama3.1:8b" # Chat model
      "qwen2.5-coder:1.5b-base" # Autocomplete model
      "nomic-embed-text:latest" # Embeddings model
    ];

    acceleration = "rocm"; # Use GPU for Ollama models
  };
}
