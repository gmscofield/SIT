```
       _____ _____ _______ 
      / ____|_   _|__   __|
     | (___   | |    | |   
      \___ \  | |    | |   
      ____) |_| |_   | |   
     |_____/|_____|  |_|   
            

Usage:
  python -m SIT [-v] [--server] <subcommand> ...

Generate Software Bill of Materials (SBOM) for a software package.

Options:
  -v, --version  show program's version number and exit
  --server       Start SIT server mode

subcommands:
  <subcommand>
    generate     Generate SBOM for a software package
    merge        Merge SBOMs
    export       Export Sub-SBOM
    convert      Convert SBOM between different formats
```

# Install

We provide two ways for users to use SIT. The first one is to deploy locally, installing all the necessary libraries. The second one is to use docker.

## Create a virtual environment and install necessary libraries

Check your python version and pip version.

```shell
python3 -m pip --version
```

Then create a virtual environment.

```shell
sudo apt install python3-venv && \  
python3 -m pip install --user virtualenv && \  
python3 -m venv env && \
source ./env/bin/activate
```

Finally install all the needed libraries with requirements.txt.

```shell
python3 -m pip install -r ./SIT/requirements.txt
python3 -m pip install -r ./scancode_toolkit/requirements.txt
```

## SIT docker

Make sure you have already installed Docker. Login into Docker Hub.
```shell
docker login
```

Pull the docker image of SIT.
```shell
docker pull gmscofield/sit:latest
```

# Commands

## Server Mode

If you want SIT to run as a server, then just invode SIT with `--server` argument to run it in server mode. By default, it listens to port `9020`.

```shell
python -m SIT --server
```

Or use the container image.

```shell
docker run --rm -p 92:9020 sit --server
```

`--rm` argument can remove the container image automatically after using the container.


## Generate Command

Generate an SBOM for the given Python package.

```
Usage:
  python -m SIT generate [options]

Options:
  -i <INPUT>, --input <INPUT>
                        Input path of software package, default is current path
  -o <OUTPUT>, --output <OUTPUT>
                        Output file path of SBOM, default is stdout
  --model <MODEL>       SBOM Model, choose from SPDX, CycloneDX, OSSBOM or middleware, default is middleware
  --env <ENVIRONMENT>   Running environment of software package, default is None
```

### Examples

If you deploy SIT locally:
```shell
python -m SIT generate -i /input/project -o /output/sbom.json --model spdx --env /input/project/env
```

If you use SIT docker:
```shell
docker run --rm -v /localpath/input/project:/input -v /localpath/output:/output sit generate -i /input -o /output/sbom.json --model spdx --env /input/env
```

## Merge Command

Merge two SBOMs.

```
Usage:
  python -m SIT merge [options]

Options:
  -i <INPUT> <INPUT>, --input <INPUT> <INPUT>
                        Input path of SBOMs to be merged, 2 SBOMs are required. The first one is the root SBOM and the second one is sub-
                        SBOM, currently only support json format
  -o <OUTPUT>, --output <OUTPUT>
                        Output file path of SBOM, default is stdout
  --model <MODEL>       SBOM Model, choose from SPDX, CycloneDX, OSSBOM or middleware, default is middleware
```

### Examples

If you deploy SIT locally:
```shell
python -m SIT merge -i /input/sbom1.json /input/sbom2.json -o /output/sbom.json --model spdx
```

If you use SIT docker:
```shell
docker run --rm -v /localpath/input:/input -v /localpath/output:/output sit merge -i /input/sbom1.json /input/sbom2.json -o /output/sbom.json --model spdx
```

## Export Command

Export a sub-SBOM from the given SBOM.

```
Usage:
  python -m SIT export [options]

Options:
  -i <INPUT>, --input <INPUT>
                        Path of SBOM file to be exported
  -o <OUTPUT>, --output <OUTPUT>
                        Output file path of SBOM, default is stdout
  --id <ID> [<ID> ...]  ID of the top-level Component to be exported
  --model <MODEL>       SBOM Model, choose from SPDX, CycloneDX, OSSBOM or middleware, default is middleware
```

### Examples

If you deploy SIT locally:
```shell
python -m SIT export -i /input/sbom.json -o /output/sbom.json --id package-id --model spdx
```

If you use SIT docker:
```shell
docker run --rm -v /localpath/input:/input -v /localpath/output:/output sit export -i /input/sbom.json -o /output/sbom.json --id package-id --model spdx
```

## Convert Command

Convert between different SBOM formats.

```
Usage:
  python -m SIT convert [options]

Options:
  -i <INPUT>, --input <INPUT>
                        Input path of SBOM file to be converted
  -o <OUTPUT>, --output <OUTPUT>
                        Output file path of SBOM, default is stdout
  --model <MODEL>       SBOM Model, choose from SPDX, CycloneDX, OSSBOM or middleware, default is middleware
```

### Examples

If you deploy SIT locally:
```shell
python -m SIT convert -i /input/sbom.json -o /output/sbom.json --model spdx
```

If you use SIT docker:
```shell
docker run --rm -v /localpath/input:/input -v /localpath/output:/output sit convert -i /input/sbom.json -o /output/sbom.json --model spdx
```
