# User variables. type make to get some help
JOBS=0
TARGET=
GNAT_SOURCES=$(SRC_DIR)/../gnat
GCC_SOURCES=$(SRC_DIR)/../gcc

###################
# Other variables #
###################

SRC_DIR:=$(shell pwd)

#########################
# TARGET Configurations #
#########################

TARGETS=none

ifeq ($(TARGET), powerpc-elf)
    TARGETS=mpc8641 8349e
endif

ifeq ($(TARGET), powerpc-eabispe)
    TARGETS=p2020 p5566 mpc5634
endif

ifeq ($(TARGET), aarch64-elf)
    TARGETS=aarch64-qemu rpi3
endif

ifeq ($(TARGET), arm-eabi)
    TARGETS=zynq7000 rpi2 sam4s samg55 smartfusion2 openmv2 stm32f4 \
       stm32f429disco stm32f469disco stm32f746disco stm32f769disco stm32h7xx tms570 lm3s
endif

ifeq ($(TARGET), aarch64-elf)
    RTS_LIST=zfp-qemu
endif

ifeq ($(TARGET), leon-elf)
    TARGETS=leon
endif

ifeq ($(TARGET), leon3-elf)
    TARGETS=leon3
endif

ifeq ($(TARGET), visium-elf)
    TARGETS=mcm
endif

ifeq ($(TARGET), i686-pc-linux-gnu)
    TARGETS=x86-linux
endif

ifeq ($(TARGET), i686-pc-mingw32)
    TARGETS=x86-windows
endif

ifeq ($(TARGET), arm-sysgo-pikeos)
    TARGETS=arm-pikeos
endif

ifeq ($(TARGET), powerpc-sysgo-pikeos)
    TARGETS=ppc-pikeos
endif

ifeq ($(TARGET), i586-sysgo-pikeos)
    TARGETS=x86-pikeos
endif

ifeq ($(TARGETS), none)
  ifeq ($(TARGET),)
    $(error Error: TARGET is not defined)
  else
    $(error Error: unknown TARGET: '$(TARGET)')
  endif
endif

#########
# Tools #
#########

GCC_PREFIX:=$(abspath $(dir $(shell which $(TARGET)-gcc))/..)
ifneq ($(PREFIX),)
  GCC_PREFIX:=$(PREFIX)
endif

GPRINSTALL:=GPR_PROJECT_PATH=obj/$(TARGET)/lib/gnat gprinstall -p -f \
              --prefix=$(GCC_PREFIX)
GPRBUILD:=GPR_PROJECT_PATH=obj/$(TARGET)/lib/gnat gprbuild -j$(JOBS)

default:
	@echo "This makefile builds&install recompilable runtimes"
	@echo "Here is the list of variables:"
	@echo
	@echo "  TARGET           specifify the target (mandatory)"
	@echo "  JOBS             set number of jobs"
	@echo "  GNAT_SOURCES     location of GNAT sources"
	@echo "                   default is $(GNAT_SOURCES)"
	@echo "  GCC_SOURCES      location of GCC sources"
	@echo "                   default is $(GCC_SOURCES)"
	@echo "  PREFIX           overrides the default prefix (gcc dir)"
	@echo
	@echo "The makefile accepts the following targets:"
	@echo
	@echo "  make all          Build all runtimes for a given target"
	@echo "  make install      Install all runtimes for a given target"
	@echo "  make srcs         Build runtime sources in ./obj"
	@echo "  make <board>.build"
	@echo "                    Build the runtimes for the board"
	@echo "  make <board>.fullbuild"
	@echo "                    Build the full runtime for the board"
	@echo "  make <board>.sfpbuild"
	@echo "                    Build the sfp runtime for the board"
	@echo "  make <board>.zfpbuild"
	@echo "                    Build the zfp runtime for the board"
	@echo "  make <board>.install"
	@echo "                    Install the board's rts in gcc"
	@echo "  make <board>.fullinstall"
	@echo "                    Install the board's full rts in gcc"
	@echo "  make <board>.sfpinstall"
	@echo "                    Install the board's sfp rts in gcc"
	@echo "  make <board>.zfpinstall"
	@echo "                    Install the board's zfp rts in gcc"

.PHONY: force

obj/$(TARGET): force
	mkdir -p obj && rm -rf obj/$(TARGET)
	set -x; ./build-rts.py --output=obj/$(TARGET) --gnat-dir=$(GNAT_SOURCES) --gcc-dir=$(GCC_SOURCES) $(TARGETS)

srcs: obj/$(TARGET)

all: obj/$(TARGET)
	for f in obj/$(TARGET)/BSPs/*.gpr; do \
	  $(GPRBUILD) -P $$f; \
	done

install: all
	for f in obj/$(TARGET)/BSPs/*.gpr; do \
	  $(GPRINSTALL) -P $$f; \
	done

# powerpc-elf runtimes
zfp-mpc8641.src:
	@$(BUILD_RTS) zfp/8641d

ravenscar-sfp-mpc8641.src:
	@$(BUILD_RTS) ravenscar-sfp/8641d

ravenscar-full-mpc8641.src:
	@$(BUILD_RTS) ravenscar-full/8641d --gcc-dir=$(GCC_SOURCES)

# powerpc-eabispe runtimes
zfp-p2020.src:
	@$(BUILD_RTS) zfp/p2020

ravenscar-sfp-p2020.src:
	@$(BUILD_RTS) ravenscar-sfp/p2020

ravenscar-full-p2020.src:
	@$(BUILD_RTS) ravenscar-full/p2020 --gcc-dir=$(GCC_SOURCES)

ravenscar-sfp-p5566.src:
	@$(BUILD_RTS) ravenscar-sfp/p5566

ravenscar-full-p5566.src:
	@$(BUILD_RTS) ravenscar-full/p5566 --gcc-dir=$(GCC_SOURCES)

zfp-p5566.src:
	@$(BUILD_RTS) zfp/p5566

zfp-mpc5634.src:
	@$(BUILD_RTS) zfp/mpc5634

# aarch64-elf runtimes
zfp-qemu.src:
	$(BUILD_RTS) zfp/aarch64-qemu

# leon-elf runtimes
zfp-leon.src:
	$(BUILD_RTS) zfp/leon

ravenscar-sfp-leon.src:
	$(BUILD_RTS) ravenscar-sfp/leon

ravenscar-full-leon.src:
	$(BUILD_RTS) ravenscar-full/leon --gcc-dir=$(GCC_SOURCES)

# leon3-elf runtimes
zfp-leon3.src:
	$(BUILD_RTS) zfp/leon3

ravenscar-sfp-leon3.src:
	$(BUILD_RTS) ravenscar-sfp/leon3

ravenscar-full-leon3.src:
	$(BUILD_RTS) ravenscar-full/leon3 --gcc-dir=$(GCC_SOURCES)

# arm-eabi runtimes
zfp-tms570.src:
	@$(BUILD_RTS) zfp/tms570

ravenscar-sfp-tms570.src:
	@$(BUILD_RTS) ravenscar-sfp/tms570

ravenscar-full-tms570.src:
	@$(BUILD_RTS) ravenscar-full/tms570 --gcc-dir=$(GCC_SOURCES)

ravenscar-full-tms570-sci.src:
	@$(BUILD_RTS) ravenscar-full/tms570-sci --gcc-dir=$(GCC_SOURCES)

zfp-lm3s.src:
	@$(BUILD_RTS) zfp/lm3s

zfp-stm32f4.src:
	@$(BUILD_RTS) zfp/stm32f4

ravenscar-sfp-stm32f4.src:
	@$(BUILD_RTS) ravenscar-sfp/stm32f4

ravenscar-full-stm32f4.src:
	@$(BUILD_RTS) ravenscar-full/stm32f4

zfp-zynq7000.src:
	@$(BUILD_RTS) zfp/zynq7000

ravenscar-sfp-zynq7000.src:
	@$(BUILD_RTS) ravenscar-sfp/zynq7000

ravenscar-full-zynq7000.src:
	@$(BUILD_RTS) ravenscar-full/zynq7000

zfp-stm32f429disco.src:
	@$(BUILD_RTS) zfp/stm32f429disco

ravenscar-sfp-stm32f429disco.src:
	@$(BUILD_RTS) ravenscar-sfp/stm32f429disco

ravenscar-full-stm32f429disco.src:
	@$(BUILD_RTS) ravenscar-full/stm32f429disco

zfp-stm32f469disco.src:
	@$(BUILD_RTS) zfp/stm32f469disco

ravenscar-sfp-stm32f469disco.src:
	@$(BUILD_RTS) ravenscar-sfp/stm32f469disco

ravenscar-full-stm32f469disco.src:
	@$(BUILD_RTS) ravenscar-full/stm32f469disco

zfp-stm32f7disco.src:
	@$(BUILD_RTS) zfp/stm32f7disco

ravenscar-sfp-stm32f7disco.src:
	@$(BUILD_RTS) ravenscar-sfp/stm32f7disco

ravenscar-full-stm32f7disco.src:
	@$(BUILD_RTS) ravenscar-full/stm32f7disco

zfp-stm32f769disco.src:
	@$(BUILD_RTS) zfp/stm32f769disco

ravenscar-sfp-stm32f769disco.src:
	@$(BUILD_RTS) ravenscar-sfp/stm32f769disco

ravenscar-full-stm32f769disco.src:
	@$(BUILD_RTS) ravenscar-full/stm32f769disco

ravenscar-sfp-sam4s.src:
	@$(BUILD_RTS) ravenscar-sfp/sam4s

ravenscar-sfp-samg55.src:
	@$(BUILD_RTS) ravenscar-sfp/samg55

# visium-elf
zfp-mcm.src:
	@$(BUILD_RTS) zfp/mcm

# Native
zfp-x86-linux.src:
	@$(BUILD_RTS) zfp/x86-linux

zfp-x86-windows.src:
	@$(BUILD_RTS) zfp/x86-windows

# pikeos
zfp-arm-pikeos.src:
	@$(BUILD_RTS) zfp/arm-pikeos

ravenscar-sfp-arm-pikeos.src:
	@$(BUILD_RTS) ravenscar-sfp/arm-pikeos

%.fullbuild: obj/$(TARGET)
	if [ ! -f obj/$(TARGET)/BSPs/ravenscar_full_$*.gpr ]; then \
	  echo "no ravenscar-full runtime for $*"; \
	  exit 1; \
	fi
	$(GPRBUILD) -P obj/$(TARGET)/BSPs/ravenscar_full_$*.gpr

%.sfpbuild: obj/$(TARGET)
	if [ ! -f obj/$(TARGET)/BSPs/ravenscar_sfp_$*.gpr ]; then \
	  echo "no ravenscar-sfp runtime for $*"; \
	  exit 1; \
	fi
	$(GPRBUILD) -P obj/$(TARGET)/BSPs/ravenscar_sfp_$*.gpr

%.zfpbuild: obj/$(TARGET)
	if [ ! -f obj/$(TARGET)/BSPs/zfp_$*.gpr ]; then \
	  echo "no ravenscar-sfp runtime for $*"; \
	  exit 1; \
	fi
	$(GPRBUILD) -P obj/$(TARGET)/BSPs/zfp_$*.gpr

%.install: %.build
	for f in obj/$(TARGET)/BSPs/*_$*.gpr; do \
	  $(GPRINSTALL) -P $$f; \
	done

%.fullinstall: %.fullbuild
	$(GPRINSTALL) -P obj/$(TARGET)/BSPs/ravenscar_full_$*.gpr

%.sfpinstall: %.sfpbuild
	$(GPRINSTALL) -P obj/$(TARGET)/BSPs/ravenscar_sfp_$*.gpr

%.zfpinstall: %.zfpbuild
	$(GPRINSTALL) -P obj/$(TARGET)/BSPs/zfp_$*.gpr
