BUILD_DIR ?= build
STATIC_DIR ?= static

all: erc schematics bom

.PHONY: schematics
schematics:
	kicad-cli sch export pdf amp/amp.kicad_sch --output $(STATIC_DIR)/amp.pdf
	kicad-cli sch export svg amp/amp.kicad_sch --output $(STATIC_DIR)

.PHONY: bom
bom:
	kicad-cli sch export bom amp/amp.kicad_sch \
		--group-by Value \
		--format-preset CSV \
		--output $(STATIC_DIR)/amp_bom.csv

.PHONY: bom-print
bom-print: bom
	csvlook $(STATIC_DIR)/amp_bom.csv

.PHONY: erc
erc:
	kicad-cli sch erc amp/amp.kicad_sch --output $(BUILD_DIR)/amp_erc.rpt
	cat $(BUILD_DIR)/amp_erc.rpt
