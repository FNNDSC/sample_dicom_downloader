# Sample Public DICOM Dataset Downloader

Here, a simple all-in-one Makefile is provided for downloading a variety of permissively-licensed, publicly-available DICOM data.

The only requirements are `make`, `curl`, `tar`, and `bash`.

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
