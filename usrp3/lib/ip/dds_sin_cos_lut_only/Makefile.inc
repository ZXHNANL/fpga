#
# Copyright 2018 Ettus Research
#

include $(TOOLS_DIR)/make/viv_ip_builder.mak

LIB_IP_DDS_SIN_COS_LUT_ONLY_SRCS = $(IP_BUILD_DIR)/dds_sin_cos_lut_only/dds_sin_cos_lut_only.xci

LIB_IP_DDS_SIN_COS_LUT_ONLY_OUTS = $(addprefix $(IP_BUILD_DIR)/dds_sin_cos_lut_only/, \
dds_sin_cos_lut_only.xci.out \
synth/dds_sin_cos_lut_only.vhd \
) 

$(LIB_IP_DDS_SIN_COS_LUT_ONLY_SRCS) $(LIB_IP_DDS_SIN_COS_LUT_ONLY_OUTS) : $(LIB_IP_DIR)/dds_sin_cos_lut_only/dds_sin_cos_lut_only.xci
	$(call BUILD_VIVADO_IP,dds_sin_cos_lut_only,$(ARCH),$(PART_ID),$(LIB_IP_DIR),$(IP_BUILD_DIR),0)