#
# Makefile - Generic makefile for building the Simulink Test Demos
#
COMPONENT := simulinktest_demos
include $(MAKE_INCLUDE_DIR)/build_component.mk

# This makefile will auto-generate Contents.m from Contents.m_template
#TEMPLATE_TARGETS := Contents.m
#prebuild : $(TEMPLATE_TARGETS)
#include $(MAKE_INCLUDE_DIR)/template_rules.gnu

