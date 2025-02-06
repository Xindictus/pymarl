# Installation instructions

## Docker

Build the Docker container using the `Dockerfile`:

```shell
cwd=$(pwd) && cd docker && docker build -t pymarl:1.0 . && cd "${cwd}"
```

If you would like to rebuild without using `docker` cache, then:

```shell
cwd=$(pwd) && cd docker && docker build --no-cache -t pymarl:1.0 . && cd "${cwd}"
```

To run experiments using the Docker container:

```shell
# bash run.sh 0 python3 src/main.py --config=qmix --env-config=sc2 with env_args.map_name=2s3z
./run.sh python3 src/main.py --config=qmix --env-config=sc2 with env_args.map_name=2s3z
```

## Local Setup

1. Install `uv` dependency manager. Follow installation instructions [here](https://docs.astral.sh/uv/getting-started/installation/).
2. Install `Python` dependencies:

   ```shell
   uv sync
   ```

3. Set up StarCraft II and SMAC:

   ```shell
   ./install_sc2.sh
   ```

   This will download SC2 into the 3rdparty folder and copy the maps necessary to run over.

4. Enable `venv`:

   ```shell
   . .venv/bin/activate
   ```

5. Run an experiment

   ```shell
   python src/main.py --config=qmix --env-config=sc2 with env_args.map_name=2s3z
   ```
