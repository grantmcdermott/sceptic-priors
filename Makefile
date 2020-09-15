## Directory vars (usually only these need changing)
rawdir = data/raw/
datdir = data/
rdir = R/
standir = stan/
resdir = results/

## See note about new grouped targets method, i.e. replacing ":" with "&:"
## https://stackoverflow.com/a/59877127/4115816

## Headline build
all: $(resdir)main/tcr.fst $(resdir)main/gmst2100.fst \
 $(resdir)main/params-tab.csv $(resdir)main/had-dev.csv
clean:
	rm -f $(results_main) $(datdir)* $(rawdir)*

## Helpers
.PHONY: all clean data
.DELETE_ON_ERROR:
.SECONDARY:

## Raw Data
raw: $(rdir)00-data-raw.R
	Rscript $<
	rm Rplots.pdf

## Prep Data
$(datdir)climate.csv: $(rdir)01-data-prep.R $(rawdir)*
	Rscript $<
	rm Rplots.pdf

$(datdir)priors.csv: $(rdir)01-data-prep.R $(datdir)climate.csv
	Rscript $<
	rm Rplots.pdf

$(datdir)df18.fst: $(rdir)01-data-prep.R $(rawdir)df18.idlsave
	Rscript $<
	rm Rplots.pdf

## Results

### Main results
results_main = $(resdir)main/tcr.fst $(resdir)main/gmst2100.fst $(resdir)gmst-pred.csv \
 $(resdir)main/params-tab.csv $(resdir)main/had-dev.csv
$(results_main) &: $(rdir)02-main.R $(standir)mod-pred.stan $(datdir)climate.csv
	Rscript $<