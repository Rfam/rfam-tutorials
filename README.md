# Annotating genomes with RNA families using Infernal

### **Requirements:**
A recent installation of Docker Desktop which is available [here](https://www.docker.com/products/docker-desktop).

### **HOW TO:**

1. Download or clone this repo and move to the directory:
```
git clone https://github.com/Rfam/rfam-tutorials.git
cd rfam-tutorials
```

2. Build a docker image from the `Dockerfile`:
```
docker image build -t rfam-tutorial .
```

3. Start a docker container from the `rfam-tutorial` image:
```
docker run -i -t rfam-tutorial:latest /bin/bash
```


