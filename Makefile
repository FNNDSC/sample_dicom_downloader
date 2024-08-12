# Setup
# ----------------------------------------------------------------------------------------------------

DATA = ./data

# Dataset download directories
# ----------------------------------------------------------------------------------------------------

DATALAD_EXAMPLE_DICOM_STRUCTURAL = $(DATA)/datalad-example-dicom-structural-f077bcc
PRINCETON_HANDBOOK_SAMPLE_DATA = $(DATA)/0219191_mystudy-0219-1114
FNNDSC_SAG_ANON = $(DATA)/FNNDSC-SAG-anon-3d6e850

UPMC_BREAST_TOMOGRAPHY = $(DATA)/upmc_breast_tomography
REMIND = $(DATA)/ReMIND_BRAIN_MR

# Make command aliases
# ----------------------------------------------------------------------------------------------------

neuro: $(DATALAD_EXAMPLE_DICOM_STRUCTURAL) $(PRINCETON_HANDBOOK_SAMPLE_DATA) $(FNNDSC_SAG_ANON)

all: neuro upmc remind

# warning: UPMC_BREAST_TOMOGRAPHY is slow to download!
upmc: $(UPMC_BREAST_TOMOGRAPHY)

remind: $(REMIND)

clean:
	$(RM) -r $(DATA)

.PHONY: all neuro clean upmc remind


# Download instructions
# ----------------------------------------------------------------------------------------------------

# https://github.com/datalad/example-dicom-structural
$(DATALAD_EXAMPLE_DICOM_STRUCTURAL):
	curl -sSfL https://api.github.com/repos/datalad/example-dicom-structural/tarball/f077bcc8d502ce8155507bd758cb3b7ccc887f40 | tar xz --directory=$(DATA)

# https://zenodo.org/records/3677090
$(PRINCETON_HANDBOOK_SAMPLE_DATA):
	curl -sSfL 'https://zenodo.org/records/3677090/files/0219191_mystudy-0219-1114.tar.gz?download=1' | tar xz --directory=$(DATA)

# https://github.com/FNNDSC/SAG-anon
$(FNNDSC_SAG_ANON):
	curl -sSfL 'https://api.github.com/repos/FNNDSC/SAG-anon/tarball/3d6e850b625e940aab02f0120cf5fb15977216bc' | tar xz --directory=$(DATA)

# http://www.dclunie.com/pixelmedimagearchive/upmcdigitalmammotomocollection/index.html
$(UPMC_BREAST_TOMOGRAPHY):
	mkdir "$@"
	curl -sSfL 'http://www.dclunie.com/pixelmedimagearchive/upmcdigitalmammotomocollection/index.html' \
	    | grep -o 'https://dl.dropbox.com/.*\.tar\.bz2?dl=1' \
		| parallel "curl -sSfL '{}' | tar xj --directory=$@"

# https://doi.org/10.7937/3RAG-D070
# Brain MR from the ReMIND dataset
$(REMIND):
	mkdir "$@"
	$(eval $@_TMP := $(shell realpath s3manifests/ReMIND_BRAIN_MR/gcs.s5cmd))
	cd "$@" && s5cmd --no-sign-request --endpoint-url https://storage.googleapis.com run "$($@_TMP)"
