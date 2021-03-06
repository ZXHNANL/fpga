#
# Copyright 2018 Ettus Research LLC
#

# NOTE: All comments prefixed with a "##" will be displayed as a part of the "make help" target
##-------------------
##USRP E3XX FPGA Help
##-------------------
##Usage:
## make <Targets> <Options>
##
##Output:
## build/usrp_<product>_fpga_<image_type>.bit:    Configuration bitstream with header
## build/usrp_<product>_fpga_<image_type>.dts:    Device tree source file
## build/usrp_<product>_fpga_<image_type>.rpt:    Build report (includes utilization and timing summary)

1G_DEFS=SFP_1GBE=1   BUILD_1G=1     $(OPTIONS)
XG_DEFS=SFP_10GBE=1  BUILD_10G=1    $(OPTIONS)
AA_DEFS=SFP_AURORA=1 BUILD_AURORA=1 $(OPTIONS)

# Option to stop after RTL elaboration. Use this flag as a synthesis check.
ifdef CHECK
TARGET = rtl
else
TARGET = bin
endif
TOP ?= e320

# vivado_build($1=Device, $2=Definitions)
vivado_build = make -f Makefile.e320.inc $(TARGET) NAME=$@ ARCH=$(XIL_ARCH_$1) PART_ID=$(XIL_PART_ID_$1) $2 TOP_MODULE=$(TOP) EXTRA_DEFS="$2"

# vivado_build($1=Device, $2=Option)
post_build = @\
	mkdir -p build; \
	echo "Exporting bitstream file..."; \
	cp build-$(1)_$(2)/e320.bit build/usrp_`echo $(1) | tr A-Z a-z`_fpga_$(2).bit; \
	echo "Exporting build report..."; \
	cp build-$(1)_$(2)/build.rpt build/usrp_`echo $(1) | tr A-Z a-z`_fpga_$(2).rpt; \
	echo "Build DONE ... $(1)_$(2)";

##
##Supported Targets
##-----------------

all:      E320_1G E320_XG ##(Default target)

##E320_1G:  1GigE on SFP+ Port.
E320_1G:  build/usrp_e320_fpga_1G.dts
	$(call vivado_build,E320,$(1G_DEFS) E320=1)
	$(call post_build,E320,1G)

##E320_XG:  10GigE on SFP+ Port.
E320_XG: build/usrp_e320_fpga_XG.dts
	$(call vivado_build,E320,$(XG_DEFS) E320=1)
	$(call post_build,E320,XG)

##E320_AA:  Aurora on SFP+ Port.
E320_AA: build/usrp_e320_fpga_AA.dts
	$(call vivado_build,E320,$(AA_DEFS) E320=1)
	$(call post_build,E320,AA)

##E320_RFNOC_1G:  1GigE on SFP+ Port. RFNOC CEs enabled.
E320_RFNOC_1G:  build/usrp_e320_fpga_1G.dts
	$(call vivado_build,E320,$(1G_DEFS) RFNOC=1 E320=1)
	$(call post_build,E320,RFNOC_1G)

##E320_RFNOC_XG:  10GigE on SFP+ Port. RFNOC CEs enabled.
E320_RFNOC_XG: build/usrp_e320_fpga_XG.dts
	$(call vivado_build,E320,$(XG_DEFS) RFNOC=1 E320=1)
	$(call post_build,E320,RFNOC_XG)

##E320_RFNOC_AA:  Aurora on SFP+ Port. RFNOC CEs enabled.
E320_RFNOC_AA: build/usrp_e320_fpga_AA.dts
	$(call vivado_build,E320,$(AA_DEFS) RFNOC=1 E320=1)
	$(call post_build,E320,RFNOC_AA)

build/%.dts: dts/%.dts dts/*.dtsi
	-mkdir -p build
	${CC} -o $@ -E -I dts -nostdinc -undef -x assembler-with-cpp -D__DTS__ $<

clean:    ##Clean up all target build outputs.
	@echo "Cleaning targets..."
	@rm -rf build-E3*_*
	@rm -rf build

cleanall: ##Clean up all target and ip build outputs.
	@echo "Cleaning targets and IP..."
	@rm -rf build-ip
	@rm -rf build-E3*_*
	@rm -rf build

help:     ##Show this help message.
	@grep -h "##" Makefile | grep -v "\"##\"" | sed -e 's/\\$$//' | sed -e 's/##//'

##
##Supported Options
##-----------------
##GUI=1        Launch the build in the Vivado GUI.
##CHECK=1      Launch the syntax checker instead of building a bitfile.
##TOP=<module> Specify a top module for syntax checking. (Optional. Default is the bitfile top)

.PHONY: all clean cleanall help
