# Sample Public DICOM Dataset Downloader

Here, a simple Makefile (and Dockerfile) is provided for downloading a variety of permissively-licensed, publicly-available DICOM data.

## Dependencies

- `tar`: typically pre-installed on Linux and MacOS
- `curl`: https://curl.se
- `make`: https://www.gnu.org/software/make/
- `parallel`: https://www.gnu.org/software/parallel/
- `s5cmd`: https://github.com/peak/s5cmd

Alternatively, use the container image `ghcr.io/fnndsc/utils:fc56615` which contains all of the above pre-installed.

Run `make` as:

```shell
# using docker
docker run --rm -u "$(id -u):$(id -g)" -v "$PWD:/app" -w /app ghcr.io/fnndsc/utils:fc56615 make

# using podman
podman run --rm --userns=host -v "$PWD:/app" -w /app ghcr.io/fnndsc/utils:fc56615 make
```

## Usage

```shell
# download a little bit of brain MRI data
make

# download some breast tomography data
make upmc

# download 26.6GiB of brain caner MR data from ReMIND
make remind
```

## Lists

- https://talk.openmrs.org/t/sources-for-sample-dicom-images/6019
- https://support.dcmtk.org/redmine/projects/dcmtk/wiki/DICOM_images
- https://portal.imaging.datacommons.cancer.gov/explore/
