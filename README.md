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

# Installation

We provide two ways for users to use SIT: deploying locally by installing all necessary libraries, or using Docker.

## Create a Virtual Environment and Install Libraries

Check your python version and pip version.

```shell
python3 -m pip --version
```

Create a virtual environment.

```shell
sudo apt install python3-venv && \  
python3 -m pip install --user virtualenv && \  
python3 -m venv env && \
source ./env/bin/activate
```

Finally install required libraries with requirements.txt.

```shell
python3 -m pip install -r ./SIT/requirements.txt
python3 -m pip install -r ./scancode_toolkit/requirements.txt
```

## SIT docker

Make sure you have Docker installed. Then login to Docker Hub:
```shell
docker login
```

Pull the docker image of SIT.
```shell
docker pull gmscofield/sit:latest
```

# Commands

## Server Mode

To run SIT as a server, invoke SIT with `--server` argument. By default, it listens to port `9020`.

```shell
python -m SIT --server
```

Or use the container image.

```shell
docker run --rm -it -p 9020:9020 gmscofield/sit --server
```
Note: The `--rm` argument automatically removes the container after it stops.


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
docker run --rm -v /localpath/input/project:/input -v /localpath/output:/output gmscofield/sit generate -i /input -o /output/sbom.json --model spdx --env /input/env
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
docker run --rm -v /localpath/input:/input -v /localpath/output:/output gmscofield/sit merge -i /input/sbom1.json /input/sbom2.json -o /output/sbom.json --model spdx
```

## Export Command

Export a sub-SBOM from a given SBOM.

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
docker run --rm -v /localpath/input:/input -v /localpath/output:/output gmscofield/sit export -i /input/sbom.json -o /output/sbom.json --id package-id --model spdx
```

## Convert Command

Convert an SBOM between different SBOM formats.

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
docker run --rm -v /localpath/input:/input -v /localpath/output:/output gmscofield/sit convert -i /input/sbom.json -o /output/sbom.json --model spdx
```
