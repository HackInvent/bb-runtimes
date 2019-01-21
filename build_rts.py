#! /usr/bin/env python
#
# Copyright (C) 2016, AdaCore
#
# Python script to gather files for the bareboard runtime.
# Don't use any fancy features.  Ideally, this script should work with any
# Python version starting from 2.6 (yes, it's very old but that's the system
# python on oldest host).

from support.files_holder import FilesHolder
from support.bsp_sources.installer import Installer
from support.rts_sources import SourceTree
from support.rts_sources.sources import all_scenarios, sources
from support.docgen import docgen

# PikeOS
from pikeos import ArmPikeOS

# Cortex-M runtimes
from arm.cortexm import Stm32, Sam, SmartFusion2, LM3S, M1AGL, Microbit, \
     CortexM0, CortexM0P, CortexM1, CortexM3, CortexM4, CortexM4F, \
     CortexM7F, CortexM7DF

# Cortex-A/R runtimes
from arm.cortexar import TMS570, Rpi2, Rpi2Mc, Zynq7000

# Aarch64
from aarch64 import Rpi3, Rpi3Mc, ZynqMP

# leon
from sparc import Leon2, Leon3, Leon4

# powerpc
from powerpc import MPC8641, MPC8349e, P2020, P5566, P5634

# riscv
from riscv import Spike, HiFive1, PicoRV32

# visium
from visium import Visium

# native
from native import X86Native, X8664Native

    def __init__(self):
        super(ArmBBTarget, self).__init__(
            mem_routines=True,
            libc_files=False,
            arm_zcx=True)
        self.build_flags['target'] = 'arm-eabi'

    def amend_zfp(self):
        super(ArmBBTarget, self).amend_zfp()
        self.pairs.update({
            'system.ads': 'system-xi-arm.ads',
            's-macres.adb': 's-macres-cortexm3.adb'})

    def amend_ravenscar_sfp(self):
        super(ArmBBTarget, self).amend_ravenscar_sfp()
        self.pairs.update({
            'system.ads': 'system-xi-cortexm4-sfp.ads',
            's-bbcppr.adb': 's-bbcppr-armv7m.adb',
            's-bbbosu.adb': 's-bbbosu-armv7m.adb',
            's-parame.ads': 's-parame-xi-small.ads'})

    def amend_ravenscar_full(self):
        super(ArmBBTarget, self).amend_ravenscar_full()
        self.pairs.update({
            'system.ads': 'system-xi-cortexm4-full.ads',
            's-traceb.adb': 's-traceb-xi-armeabi.adb'})
        self.common += ['newlib-bb.c']
        self.config_files['runtime.xml'] = \
            self.config_files['runtime.xml'].replace(
                '"-nolibc", ', '"-lc", "-lgnat", ')


class LM3S(ArmBBTarget):
    @property
    def has_single_precision_fpu(self):
        return False

    @property
    def has_fpu(self):
        # Still add floating point attributes
        return True

    def amend_zfp(self):
        super(LM3S, self).amend_zfp()
        self.arch += [
            'arm/lm3s/lm3s-rom.ld',
            'arm/lm3s/lm3s-ram.ld',
            'arm/lm3s/start-rom.S',
            'arm/lm3s/start-ram.S',
            'arm/lm3s/setup_pll.adb',
            'arm/lm3s/setup_pll.ads']
        self.pairs.update({
            's-textio.adb': 's-textio-lm3s.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('arm/lm3s/runtime.xml')})


class Stm32(ArmBBTarget):
    _to_mcu = {
        'stm32f4': 'stm32f40x',
        'stm32f429disco': 'stm32f429x',
        'stm32f469disco': 'stm32f469x',
        'stm32f7disco': 'stm32f7x',
        'stm32f769disco': 'stm32f7x9'}

    def __init__(self, board):
        super(Stm32, self).__init__()

        assert board in Stm32._to_mcu, 'Unknown STM32 board: %s' % board
        self.mcu = Stm32._to_mcu[board]

    @property
    def has_double_precision_fpu(self):
        return self.mcu == 'stm32f7x9'

    def amend_zfp(self):
        super(Stm32, self).amend_zfp()
        self.common += [
            's-bb.ads']

        if 's-bbpara.ads' not in self.gnarl_arch:
            self.gnarl_arch.append('s-bbpara.ads')

        self.bsp += [
            's-stm32.ads',
            's-stm32.adb',
            'arm/stm32/common-RAM.ld',
            'arm/stm32/common-ROM.ld',
            'arm/stm32/start-rom.S',
            'arm/stm32/start-ram.S',
            'arm/stm32/start-common.S',
            'arm/stm32/setup_pll.adb',
            'arm/stm32/setup_pll.ads',
            'arm/stm32/%s/memory-map.ld' % self.mcu,
            'arm/stm32/%s/s-bbmcpa.ads' % self.mcu,
            'arm/stm32/%s/s-bbmcpa.adb' % self.mcu,
            'arm/stm32/%s/s-bbbopa.ads' % self.mcu,
            'arm/stm32/%s/svd/i-stm32.ads' % self.mcu,
            'arm/stm32/%s/svd/i-stm32-flash.ads' % self.mcu,
            'arm/stm32/%s/svd/i-stm32-gpio.ads' % self.mcu,
            'arm/stm32/%s/svd/i-stm32-pwr.ads' % self.mcu,
            'arm/stm32/%s/svd/i-stm32-rcc.ads' % self.mcu,
            'arm/stm32/%s/svd/i-stm32-syscfg.ads' % self.mcu,
            'arm/stm32/%s/svd/i-stm32-usart.ads' % self.mcu]

        self.pairs.update({
            's-bbpara.ads': 's-bbpara-stm32f4.ads'})

        if self.mcu == 'stm32f40x':
            self.pairs.update({
                's-stm32.adb': 's-stm32-f40x.adb',
                's-textio.adb': 's-textio-stm32f4.adb'})
        elif self.mcu == 'stm32f429x':
            self.pairs.update({
                's-stm32.adb': 's-stm32-f4x9x.adb',
                's-textio.adb': 's-textio-stm32f4.adb'})
        elif self.mcu == 'stm32f469x':
            self.pairs.update({
                's-stm32.adb': 's-stm32-f4x9x.adb',
                's-textio.adb': 's-textio-stm32f469.adb'})
        elif self.mcu in ('stm32f7x', 'stm32f7x9'):
            self.pairs.update({
                's-stm32.adb': 's-stm32-f7x.adb',
                's-textio.adb': 's-textio-stm32f7.adb'})

        runtime_xml = readfile('arm/stm32/runtime.xml')
        if self.mcu in ('stm32f7x', 'stm32f7x9'):
            runtime_xml = runtime_xml.replace('cortex-m4', 'cortex-m7')

        if self.mcu == 'stm32f7x9':
            # double precision cortex-m7 fpu
            runtime_xml = runtime_xml.replace('fpv4-sp-d16', 'fpv5-d16')
        elif self.mcu == 'stm32f7x':
            # single precision cortex-m7 fpu
            runtime_xml = runtime_xml.replace('fpv4-sp-d16', 'fpv5-sp-d16')

        self.config_files.update({'runtime.xml': runtime_xml})

    def amend_ravenscar_sfp(self):
        super(Stm32, self).amend_ravenscar_sfp()
        self.gnarl_common.remove('s-bb.ads')
        self.gnarl_common += ['s-bbsumu.adb']
        self.bsp += [
            'arm/stm32/%s/svd/handler.S' % self.mcu]
        self.pairs.update({
            'a-intnam.ads': 'arm/stm32/%s/svd/a-intnam.ads' % self.mcu})


class Sam(ArmBBTarget):
    def __init__(self, board):
        super(Sam, self).__init__()

        assert board in ('sam4s', 'samg55'), 'Unknown SAM board: %s' % board
        self.board = board

    @property
    def has_single_precision_fpu(self):
        return self.board != 'sam4s'

    def amend_zfp(self):
        super(Sam, self).amend_zfp()
        self.bsp += [
            's-sam4s.ads',
            'arm/sam/common-SAMBA.ld',
            'arm/sam/common-ROM.ld',
            'arm/sam/start-rom.S',
            'arm/sam/start-ram.S',
            'arm/sam/setup_pll.ads',
            'arm/sam/%s/board_config.ads' % self.board,
            'arm/sam/%s/setup_pll.adb' % self.board,
            'arm/sam/%s/memory-map.ld' % self.board,
            'arm/sam/%s/svd/i-sam.ads' % self.board,
            'arm/sam/%s/svd/i-sam-efc.ads' % self.board,
            'arm/sam/%s/svd/i-sam-pmc.ads' % self.board,
            'arm/sam/%s/svd/i-sam-sysc.ads' % self.board]

        self.pairs.update({
            's-textio.adb': 's-textio-sam4s.adb'})

        if self.has_fpu:
            fp = 'hardfloat'
        else:
            fp = 'softfloat'
        self.config_files.update(
            {'runtime.xml': readfile('arm/sam/%s/runtime.xml' % fp)})

    def amend_ravenscar_sfp(self):
        super(Sam, self).amend_ravenscar_sfp()
        self.bsp += [
            'arm/sam/%s/svd/handler.S' % self.board,
            'arm/sam/%s/s-bbbopa.ads' % self.board,
            'arm/sam/%s/s-bbmcpa.ads' % self.board]

        self.pairs.update({
            'a-intnam.ads': 'arm/sam/%s/svd/a-intnam.ads' % self.board,
            's-bbpara.ads': 's-bbpara-sam4s.ads'})


class DFBBTarget(Target):
    "BB target with single and double FPU"
    @property
    def is_bareboard(self):
        return True

    @property
    def has_single_precision_fpu(self):
        return True

    @property
    def has_double_precision_fpu(self):
        return True


class TMS570(DFBBTarget):
    def __init__(self):
        super(TMS570, self).__init__(
            mem_routines=True,
            libc_files=False,
            arm_zcx=True)
        self.build_flags['target'] = 'arm-eabi'

    def amend_zfp(self):
        super(TMS570, self).amend_zfp()
        self.bsp += [
            'arm/tms570/sys_startup.S',
            'arm/tms570/crt0.S',
            'arm/tms570/start-ram.S',
            'arm/tms570/start-rom.S']
        self.arch += [
            'arm/tms570/tms570.ld',
            'arm/tms570/flash.ld',
            'arm/tms570/monitor.ld',
            'arm/tms570/hiram.ld',
            'arm/tms570/loram.ld',
            'arm/tms570/common.ld']
        self.pairs.update(
            {'system.ads': 'system-xi-arm.ads',
             's-textio.adb': 's-textio-tms570.adb',
             's-macres.adb': 's-macres-tms570.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('arm/tms570/runtime.xml')})

    def amend_ravenscar_sfp(self):
        super(TMS570, self).amend_ravenscar_sfp()

        self.gnarl_common += ['s-bbcpsp.ads', 's-bbsumu.adb']
        self.pairs.update({
            'system.ads': 'system-xi-arm-sfp.ads',
            's-bbcppr.adb': 's-bbcppr-arm.adb',
            's-bbcpsp.ads': 's-bbcpsp-arm.ads',
            'a-intnam.ads': 'a-intnam-xi-tms570.ads',
            's-bbbosu.adb': 's-bbbosu-tms570.adb',
            's-bbpara.ads': 's-bbpara-tms570.ads',
            's-parame.ads': 's-parame-xi-small.ads'})

    def amend_ravenscar_full(self):
        super(TMS570, self).amend_ravenscar_full()
        self.pairs.update({
            'system.ads': 'system-xi-arm-full.ads',
            's-traceb.adb': 's-traceb-xi-armeabi.adb'})
        self.common += ['newlib-bb.c']
        self.config_files['runtime.xml'] = \
            self.config_files['runtime.xml'].replace(
                '"-nolibc", ', '"-lc", "-lgnat", ')


class Zynq7000(DFBBTarget):
    def __init__(self):
        super(Zynq7000, self).__init__(
            mem_routines=True,
            libc_files=False,
            arm_zcx=True)
        self.build_flags['target'] = 'arm-eabi'

    def amend_zfp(self):
        super(Zynq7000, self).amend_zfp()
        self.bsp += [
            'arm/zynq/ram.ld',
            'arm/zynq/start-ram.S',
            'arm/zynq/memmap.s']
        self.pairs.update(
            {'system.ads': 'system-xi-arm.ads',
             's-textio.adb': 's-textio-zynq.adb',
             's-macres.adb': 's-macres-zynq.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('arm/zynq/runtime.xml')})

    def amend_ravenscar_sfp(self):
        super(Zynq7000, self).amend_ravenscar_sfp()

        self.gnarl_common += ['s-bbcpsp.ads']
        self.pairs.update({
            'system.ads': 'system-xi-cortexa-sfp.ads',
            's-bbcppr.adb': 's-bbcppr-arm.adb',
            's-bbcpsp.ads': 's-bbcpsp-arm.ads',
            'a-intnam.ads': 'a-intnam-dummy.ads',
            's-bbbosu.adb': 's-bbbosu-cortexa9.adb',
            's-bbtime.adb': 's-bbtime-ppc.adb',
            's-bbpara.ads': 's-bbpara-cortexa9.ads'})

    def amend_ravenscar_full(self):
        super(Zynq7000, self).amend_ravenscar_full()
        self.pairs.update({
            'system.ads': 'system-xi-cortexa-full.ads',
            's-traceb.adb': 's-traceb-xi-armeabi.adb'})
        self.common += ['newlib-bb.c']
        self.config_files['runtime.xml'] = \
            self.config_files['runtime.xml'].replace(
                '"-nolibc", ', '"-lc", "-lgnat", ')


class RPI2(DFBBTarget):
    def __init__(self):
        super(RPI2, self).__init__(
            mem_routines=True,
            libc_files=False,
            arm_zcx=True)
        self.build_flags['target'] = 'arm-eabi'

    def amend_zfp(self):
        super(RPI2, self).amend_zfp()
        self.bsp += [
            'arm/rpi2/ram.ld',
            'arm/rpi2/start-ram.S',
            'arm/rpi2/memmap.s',
            'i-raspberry_pi.ads',
            'i-arm_v7ar.ads',
            'i-arm_v7ar.adb']
        self.pairs.update(
            {'system.ads': 'system-xi-arm.ads',
             's-textio.adb': 's-textio-rpi2.adb',
             's-macres.adb': 's-macres-rpi2.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('arm/rpi2/runtime.xml')})

    def amend_ravenscar_sfp(self):
        super(RPI2, self).amend_ravenscar_sfp()

        self.gnarl_common += ['s-bbcpsp.ads']
        self.pairs.update({
            'system.ads': 'system-xi-arm-sfp.ads',
            's-bbcppr.adb': 's-bbcppr-arm.adb',
            's-bbcpsp.ads': 's-bbcpsp-arm.ads',
            'a-intnam.ads': 'a-intnam-dummy.ads',
            's-bbbosu.adb': 's-bbbosu-rpi2.adb',
            's-bbtime.adb': 's-bbtime-ppc.adb',
            's-bbpara.ads': 's-bbpara-rpi2.ads'})


class RPI3(DFBBTarget):
    def __init__(self):
        super(RPI3, self).__init__(
            mem_routines=True,
            libc_files=False,
            arm_zcx=True)
        self.build_flags['target'] = 'arm-eabi'

    def amend_zfp(self):
        super(RPI3, self).amend_zfp()
        self.bsp += [
            'aarch64/rpi3/ram.ld',
            'aarch64/rpi3/start-ram.S',
            'aarch64/rpi3/trap_dump.ads',
            'aarch64/rpi3/trap_dump.adb',
            'i-raspberry_pi.ads']
        self.pairs.update(
            {'system.ads': 'system-xi-aarch64.ads',
             's-textio.adb': 's-textio-rpi2.adb',
             's-macres.adb': 's-macres-rpi2.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('aarch64/rpi3/runtime.xml')})


class AARCH64QEMU(DFBBTarget):
    def __init__(self):
        super(AARCH64QEMU, self).__init__(
            mem_routines=True,
            libc_files=False,
            arm_zcx=True)
        self.build_flags['target'] = 'aarch64-elf'

    def amend_zfp(self):
        super(AARCH64QEMU, self).amend_zfp()
        self.bsp += [
            'aarch64/qemu/ram.ld',
            'aarch64/qemu/mcpart.ld',
            'aarch64/qemu/start-ram.S',
            'aarch64/qemu/start-part.S']
        self.pairs.update(
            {'system.ads': 'system-xi-aarch64.ads',
             's-textio.adb': 's-textio-zynq.adb',
             's-macres.adb': 's-macres-zynq.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('aarch64/qemu/runtime.xml')})


class SparcBBTarget(DFBBTarget):
    def __init__(self):
        super(SparcBBTarget, self).__init__(
            mem_routines=True,
            libc_files=False,
            arm_zcx=False)

    def amend_zfp(self):
        super(SparcBBTarget, self).amend_zfp()
        self.common += [
            'sparc.h']
        self.pairs.update({
            'system.ads': 'system-xi-sparc.ads',
            's-macres.adb': 's-macres-leon.adb',
            'sparc.h': 'sparc-bb.h'})
        # Add s-bb and s-bbbopa (needed by zfp for uart address)
        self.common.append('s-bb.ads')
        self.bsp.append('s-bbbopa.ads')

        # Was not present on erc32:
        self.build_flags['c_flags'] += ['-DLEON']

    def amend_ravenscar_sfp(self):
        super(SparcBBTarget, self).amend_ravenscar_sfp()
        self.gnarl_common.remove('s-bb.ads')
        self.gnarl_common += [
            'context_switch.S',
            'trap_handler.S',
            'interrupt_masking.S',
            'floating_point.S',
            's-bcpith.adb',
            # Were not present in erc32:
            's-bbcaco.ads', 's-bbcaco.adb']
        self.pairs.update({
            'system.ads': 'system-xi-sparc-ravenscar.ads',
            's-bbcppr.adb': 's-bbcppr-sparc.adb',
            's-bcpith.adb': 's-bcpith-bb-sparc.adb',
            'context_switch.S': 'context_switch-bb-sparc.S',
            'trap_handler.S': 'trap_handler-bb-sparc.S',
            'interrupt_masking.S': 'interrupt_masking-bb-sparc.S',
            'floating_point.S': 'floating_point-bb-sparc.S',
            's-bbcaco.adb': 's-bbcaco-leon.adb',
            's-musplo.adb': 's-musplo-leon.adb'})

    def amend_ravenscar_full(self):
        super(SparcBBTarget, self).amend_ravenscar_full()
        self.pairs.update({
            'system.ads': 'system-xi-sparc-full.ads',
            's-traceb.adb': 's-traceb-xi-sparc.adb'})
        self.common += ['newlib-bb.c']
        # Use leon-zcx.specs to link with -lc.
        self.config_files.update(
            {'link-zcx.spec':
             readfile(os.path.join(crossdir, 'leon-elf/leon-zcx.specs'))})
        self.config_files['runtime.xml'] = \
            self.config_files['runtime.xml'].replace(
                '"-nostartfiles",',
                '"--specs=${RUNTIME_DIR(ada)}/link-zcx.spec",')


class Leon2(SparcBBTarget):
    def __init__(self):
        super(Leon2, self).__init__()
        self.build_flags['target'] = 'leon-elf'

    def amend_zfp(self):
        super(Leon2, self).amend_zfp()
        self.arch += [
            'leon-elf/leon.ld',
            'leon-elf/crt0.S']
        self.bsp += [
            'sparc/leon/hw_init.S']
        self.pairs.update({
            's-textio.adb': 's-textio-leon.adb',
            's-bbbopa.ads': 's-bbbopa-leon.ads'})
        self.config_files.update(
            {'runtime.xml': readfile('sparc/leon/runtime.xml')})
        self.build_flags['c_flags'] += ['-DLEON2']

    def amend_ravenscar_sfp(self):
        super(Leon2, self).amend_ravenscar_sfp()
        self.gnarl_common += [
            's-bbsule.ads', 's-bbsumu.adb']
        self.pairs.update({
            's-bbbosu.adb': 's-bbbosu-leon.adb',
            's-bbpara.ads': 's-bbpara-leon.ads',
            'a-intnam.ads': 'a-intnam-xi-leon.ads'})


class Leon3(SparcBBTarget):
    def __init__(self):
        super(Leon3, self).__init__()
        self.build_flags['target'] = 'leon3-elf'

    def amend_zfp(self):
        super(Leon3, self).amend_zfp()
        self.arch += [
            'leon3-elf/leon.ld',
            'leon-elf/crt0.S']
        self.bsp += [
            'sparc/leon/hw_init.S']
        self.pairs.update({
            's-textio.adb': 's-textio-leon3.adb',
            's-bbbopa.ads': 's-bbbopa-leon3.ads'})
        self.config_files.update(
            {'runtime.xml': readfile('sparc/leon3/runtime.xml')})
        self.build_flags['c_flags'] += ['-DLEON3']

    def amend_ravenscar_sfp(self):
        super(Leon3, self).amend_ravenscar_sfp()
        self.gnarl_common += [
            's-bbsle3.ads']
        self.pairs.update({
            's-bbbosu.adb': 's-bbbosu-leon3.adb',
            's-bbpara.ads': 's-bbpara-leon.ads',
            'a-intnam.ads': 'a-intnam-xi-leon3.ads'})

    def amend_ravenscar_full(self):
        super(Leon3, self).amend_ravenscar_full()
        # Single precision sqrt is buggy on UT699
        self.pairs.update({'s-lisisq.adb': 's-lisisq-ada.adb'})


class PPC6XXBBTarget(DFBBTarget):
    def __init__(self):
        super(PPC6XXBBTarget, self).__init__(
            mem_routines=True,
            libc_files=True,
            arm_zcx=False)
        self.build_flags['target'] = 'powerpc-elf'

    def amend_zfp(self):
        super(PPC6XXBBTarget, self).amend_zfp()
        self.pairs.update({
            'system.ads': 'system-xi-ppc.ads',
            's-lidosq.adb': 's-lidosq-ada.adb',
            's-lisisq.adb': 's-lisisq-ada.adb'})

    def amend_ravenscar_sfp(self):
        super(PPC6XXBBTarget, self).amend_ravenscar_sfp()
        self.gnarl_common += [
            'powerpc/6xx/context_switch.S',
            'powerpc/6xx/handler.S',
            's-bbcpsp.ads', 's-bbcpsp.adb']
        self.pairs.update({
            'system.ads': 'system-xi-ppc-sfp.ads',
            's-bbcppr.adb': 's-bbcppr-ppc.adb',
            's-bbcppr.ads': 's-bbcppr-ppc.ads',
            's-bbinte.adb': 's-bbinte-ppc.adb',
            's-bbtime.adb': 's-bbtime-ppc.adb',
            's-bbcpsp.ads': 's-bbcpsp-6xx.ads',
            's-bbcpsp.adb': 's-bbcpsp-6xx.adb'})

    def amend_ravenscar_full(self):
        super(PPC6XXBBTarget, self).amend_ravenscar_full()
        self.pairs.update({
            'system.ads': 'system-xi-ppc-full.ads',
            's-traceb.adb': 's-traceb-xi-ppc.adb'})


class MPC8641(PPC6XXBBTarget):
    def amend_zfp(self):
        super(MPC8641, self).amend_zfp()
        self.arch += [
            'powerpc/8641d/qemu-rom.ld',
            'powerpc/8641d/ram.ld']
        self.bsp += [
            'powerpc/8641d/start-rom.S',
            'powerpc/8641d/setup.S']
        # Add s-bb and s-bbbopa (needed by zfp for uart address)
        self.common.append('s-bb.ads')
        self.bsp.append('s-bbbopa.ads')
        self.pairs.update({
            's-macres.adb': 's-macres-p2020.adb',
            's-bbbopa.ads': 's-bbbopa-8641d.ads',
            's-textio.adb': 's-textio-p2020.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('powerpc/8641d/runtime.xml')})

    def amend_ravenscar_sfp(self):
        super(MPC8641, self).amend_ravenscar_sfp()
        self.gnarl_common.remove('s-bb.ads')
        self.gnarl_common += ['s-bbsuti.adb', 's-bbsumu.adb']
        self.pairs.update({
            's-bbbosu.adb': 's-bbbosu-ppc-openpic.adb',
            's-bbsuti.adb': 's-bbsuti-ppc.adb',
            's-bbsumu.adb': 's-bbsumu-8641d.adb',
            's-bbpara.ads': 's-bbpara-8641d.ads',
            'a-intnam.ads': 'a-intnam-xi-ppc-openpic.ads'})

    def amend_ravenscar_full(self):
        super(MPC8641, self).amend_ravenscar_full()
        self.config_files.update(
            {'link-zcx.spec':
             readfile('powerpc/prep/link-zcx.spec')})
        self.config_files['runtime.xml'] = \
            self.config_files['runtime.xml'].replace(
                '"-nolibc"',
                '"-nolibc",\n' +
                '         "-lgnat", "-lgcc", "-lgnat",\n' +
                '         "--specs=${RUNTIME_DIR(ada)}/link-zcx.spec"')


class MPC8349e(PPC6XXBBTarget):
    def amend_zfp(self):
        super(MPC8349e, self).amend_zfp()
        self.arch += [
            'powerpc/8349e/ram.ld']
        self.bsp += [
            'powerpc/8349e/start-ram.S',
            'powerpc/8349e/setup.S']
        # Add s-bb and s-bbbopa (needed by zfp for uart address)
        self.common.append('s-bb.ads')
        self.bsp.append('s-bbbopa.ads')
        self.pairs.update({
            's-macres.adb': 's-macres-8349e.adb',
            's-bbbopa.ads': 's-bbbopa-8349e.ads',
            's-textio.adb': 's-textio-p2020.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('powerpc/8349e/runtime.xml')})

    def amend_ravenscar_sfp(self):
        super(MPC8349e, self).amend_ravenscar_sfp()
        self.gnarl_common.remove('s-bb.ads')
        self.pairs.update({
            's-bbbosu.adb': 's-bbbosu-8349e.adb',
            's-bbpara.ads': 's-bbpara-ppc.ads',
            'a-intnam.ads': 'a-intnam-xi-8349e.ads'})


class PPCSPEBBTarget(DFBBTarget):
    def __init__(self):
        super(PPCSPEBBTarget, self).__init__(
            mem_routines=True,
            libc_files=True,
            arm_zcx=False)
        self.build_flags['target'] = 'powerpc-eabispe'

    def amend_zfp(self):
        super(PPCSPEBBTarget, self).amend_zfp()
        self.pairs.update({
            'system.ads': 'system-xi-e500v2.ads',
            's-lidosq.adb': 's-lidosq-ada.adb',
            's-lisisq.adb': 's-lisisq-ada.adb'})

    def amend_ravenscar_sfp(self):
        super(PPCSPEBBTarget, self).amend_ravenscar_sfp()
        self.gnarl_common += [
            'powerpc/spe/handler.S',
            'powerpc/spe/context_switch.S',
            's-bbcpsp.ads', 's-bbcpsp.adb']
        self.pairs.update({
            'system.ads': 'system-xi-e500v2-sfp.ads',
            's-bbcppr.adb': 's-bbcppr-ppc.adb',
            's-bbcppr.ads': 's-bbcppr-ppc.ads',
            's-bbinte.adb': 's-bbinte-ppc.adb',
            's-bbtime.adb': 's-bbtime-ppc.adb',
            's-bbcpsp.ads': 's-bbcpsp-spe.ads',
            's-bbcpsp.adb': 's-bbcpsp-spe.adb'})

    def amend_ravenscar_full(self):
        super(PPCSPEBBTarget, self).amend_ravenscar_full()
        self.pairs.update({
            'system.ads': 'system-xi-e500v2-full.ads',
            's-traceb.adb': 's-traceb-xi-ppc.adb'})


class P2020(PPCSPEBBTarget):
    def amend_zfp(self):
        super(P2020, self).amend_zfp()
        self.arch += [
            'powerpc/p2020/p2020.ld']
        self.bsp += [
            'powerpc/p2020/start-ram.S',
            'powerpc/p2020/setup.S']
        # Add s-bb and s-bbbopa (needed by zfp for uart address)
        self.common.append('s-bb.ads')
        self.bsp.append('s-bbbopa.ads')
        self.pairs.update({
            's-macres.adb': 's-macres-p2020.adb',
            's-bbbopa.ads': 's-bbbopa-p2020.ads',
            's-textio.adb': 's-textio-p2020.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('powerpc/p2020/runtime.xml')})

    def amend_ravenscar_sfp(self):
        super(P2020, self).amend_ravenscar_sfp()
        self.gnarl_common.remove('s-bb.ads')
        self.gnarl_common += ['s-bbsuti.adb', 's-bbsumu.adb']
        self.pairs.update({
            's-bbbosu.adb': 's-bbbosu-ppc-openpic.adb',
            's-bbsuti.adb': 's-bbsuti-ppc.adb',
            's-bbpara.ads': 's-bbpara-ppc.ads',
            'a-intnam.ads': 'a-intnam-xi-ppc-openpic.ads'})

    def amend_ravenscar_full(self):
        super(P2020, self).amend_ravenscar_full()
        self.config_files.update(
            {'link-zcx.spec':
             readfile('powerpc/prep/link-zcx.spec')})
        self.config_files['runtime.xml'] = \
            self.config_files['runtime.xml'].replace(
                '"-nolibc"',
                '"-nolibc",\n' +
                '         "-lgnat", "-lgcc", "-lgnat",\n' +
                '         "--specs=${RUNTIME_DIR(ada)}/link-zcx.spec"')


class P5566(PPCSPEBBTarget):
    def amend_zfp(self):
        super(P5566, self).amend_zfp()
        self.arch += [
            'powerpc/p5566/bam.ld',
            'powerpc/p5566/flash.ld',
            'powerpc/p5566/ram.ld']
        self.bsp += [
            'powerpc/p5566/start-bam.S',
            'powerpc/p5566/start-ram.S',
            'powerpc/p5566/start-flash.S',
            'powerpc/p5566/setup.S',
            'powerpc/p5566/setup-pll.S']
        self.pairs.update({
            's-macres.adb': 's-macres-p55.adb',
            's-textio.adb': 's-textio-p55.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('powerpc/p5566/runtime.xml')})

    def amend_ravenscar_sfp(self):
        super(P5566, self).amend_ravenscar_sfp()
        self.gnarl_bsp.append('s-bbbopa.ads')
        self.gnarl_common += ['s-bbsuti.adb', 's-bbsumu.adb']
        self.pairs.update({
            's-bbbopa.ads': 's-bbbopa-p55.ads',
            's-bbbosu.adb': 's-bbbosu-p55.adb',
            's-bbsuti.adb': 's-bbsuti-ppc.adb',
            's-bbpara.ads': 's-bbpara-p55.ads',
            'a-intnam.ads': 'a-intnam-xi-p55.ads'})

    def amend_ravenscar_full(self):
        super(P5566, self).amend_ravenscar_full()
        self.config_files.update(
            {'link-zcx.spec':
             readfile('powerpc/prep/link-zcx.spec')})
        self.config_files['runtime.xml'] = \
            self.config_files['runtime.xml'].replace(
                ' "-nostartfiles"',
                '\n' +
                '         "-lgnat", "-lgcc", "-lgnat",\n' +
                '         "--specs=${RUNTIME_DIR(ada)}/link-zcx.spec"')


class P5634(PPCSPEBBTarget):
    def amend_zfp(self):
        super(P5634, self).amend_zfp()
        self.arch += [
            'powerpc/mpc5634/5634.ld']
        self.bsp += [
            'powerpc/mpc5634/start.S']
        self.pairs.update({
            's-macres.adb': 's-macres-p55.adb',
            's-textio.adb': 's-textio-p55.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('powerpc/mpc5634/runtime.xml')})


class Visium(DFBBTarget):
    def __init__(self):
        super(Visium, self).__init__(
            mem_routines=False,
            libc_files=False,
            arm_zcx=False)
        self.build_flags['target'] = 'visium-elf'

    def amend_zfp(self):
        super(Visium, self).amend_zfp()
        self.pairs.update(
            {'system.ads': 'system-xi-visium.ads',
             's-textio.adb': 's-textio-stdio.adb',
             's-macres.adb': 's-macres-native.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('visium/mcm/runtime.xml'),
             'target_options.gpr': readfile('visium/mcm/target_options.gpr')})


class X86Native(DFBBTarget):
    def __init__(self):
        super(X86Native, self).__init__(
            mem_routines=False,
            libc_files=False,
            arm_zcx=False)

    def amend_zfp(self):
        super(X86Native, self).amend_zfp()
        self.pairs.update(
            {'system.ads': 'system-xi-x86.ads',
             's-textio.adb': 's-textio-stdio.adb',
             's-macres.adb': 's-macres-native.adb'})
        self.config_files.update(
            {'runtime.xml': readfile('native/runtime.xml')})


class X86Linux(X86Native):
    def __init__(self):
        super(X86Linux, self).__init__()
        self.build_flags['target'] = 'x86-linux'


class X86Windows(X86Native):
    def __init__(self):
        super(X86Windows, self).__init__()
        self.build_flags['target'] = 'x86-windows'


def build_configs(target):
    if target == 'arm-pikeos':
        t = ArmPikeOS()
    elif target == 'zynq7000':
        t = Zynq7000()
    elif target == 'rpi2':
        t = Rpi2()
    elif target == 'rpi2mc':
        t = Rpi2Mc()
    elif target == 'rpi3':
<<<<<<< HEAD
        t = RPI3()
    elif target == 'aarch64-qemu':
        t = AARCH64QEMU()
    elif target.startswith('stm32'):
        t = Stm32(target)
=======
        t = Rpi3()
    elif target == 'rpi3mc':
        t = Rpi3Mc()
    elif target == 'zynqmp':
        t = ZynqMP()
>>>>>>> upstream/18.0
    elif target.startswith('sam'):
        t = Sam(target)
    elif target.startswith('smartfusion2'):
        t = SmartFusion2()
    elif target.startswith('stm32'):
        t = Stm32(target)
    elif target == 'openmv2':
        t = Stm32(target)
    elif target == 'tms570':
        # by default, the TMS570LS3137 HDK board
        t = TMS570('tms570ls31')
    elif target == 'tms570_sci':
        # by default, the TMS570LS3137 HDK board
        t = TMS570('tms570ls31', uart_io=True)
    elif target == 'tms570lc':
        # alias for the TMS570LC43x HDK board
        t = TMS570('tms570lc43')
    elif target == 'tms570lc_sci':
        t = TMS570('tms570lc43', uart_io=True)
    elif target == 'lm3s':
        t = LM3S()
    elif target == 'm1agl':
        t = M1AGL()
    elif target == 'microbit':
        t = Microbit()
    elif target == 'cortex-m0':
        t = CortexM0()
    elif target == 'cortex-m0p':
        t = CortexM0P()
    elif target == 'cortex-m1':
        t = CortexM1()
    elif target == 'cortex-m3':
        t = CortexM3()
    elif target == 'cortex-m4':
        t = CortexM4()
    elif target == 'cortex-m4f':
        t = CortexM4F()
    elif target == 'cortex-m7f':
        t = CortexM7F()
    elif target == 'cortex-m7df':
        t = CortexM7DF()
    elif target == 'leon2' or target == 'leon':
        t = Leon2()
    elif target == 'leon3':
        t = Leon3(smp=False)
    elif target == 'leon3-smp':
        t = Leon3(smp=True)
    elif target == 'leon4':
        t = Leon4(smp=False)
    elif target == 'leon4-smp':
        t = Leon4(smp=True)
    elif target == 'mpc8641':
        t = MPC8641()
    elif target == '8349e':
        t = MPC8349e()
    elif target == 'p2020':
        t = P2020()
    elif target == 'p5566':
        t = P5566()
    elif target == 'mpc5634':
        t = P5634()
    elif target == 'mcm':
        t = Visium()
    elif target == 'spike':
        t = Spike()
    elif target == 'hifive1':
        t = HiFive1()
    elif target == 'picorv32':
        t = PicoRV32()
    elif target == 'x86-linux':
        t = X86Native()
    elif target == 'x86-windows':
        t = X86Native()
    elif target == 'x86_64-linux':
        t = X8664Native()
    elif target == 'x86_64-windows':
        t = X8664Native()
    else:
        print 'Error: undefined target %s' % target
        sys.exit(2)

    return t


def usage():
    print "usage: build-rts.py OPTIONS board1 board2 ..."
    print "Options are:"
    print " -v --verbose      be verbose"
    print " --bsps-only       generate only the BSPs"
    print " --gen-doc         generate the runtime documentation"
    print " --output=DIR      where to generate the source tree"
    print " --prefix=DIR      where built rts will be installed."
    print " --gcc-dir=DIR     gcc source directory"
    print " --gnat-dir=DIR    gnat source directory"
    print " --link            create symbolic links"
    print ""
    print "By default, the build infrastructure is performed in:"
    print "  $PWD/install:                 default output"
    print "  <output>/BSPs:                The bsps"
    print "  <output>/lib/gnat:            projects for the shared runtime"
    print "  <output>/include/rts-sources: sources for the shared runtime"
    print ""
    print "The prefix controls where the built runtimes are installed."
    print "By default, the generated project files will install rts in:"
    print "  <gnat>/<target>/lib/gnat"
    print ""
    print "when generating the runtime source tree together with the BSPs, the"
    print "boards specified on command line must use the same toolchain"
    print "target."


def main():
    # global link, gccdir, gnatdir, verbose, create_common

    dest = "install"
    dest_bsps = None
    dest_prjs = None
    dest_srcs = None
    prefix = None
    gen_rts_srcs = True
    gen_doc = False

    try:
        opts, args = getopt.getopt(
            sys.argv[1:], "hvl",
            ["help", "verbose", "bsps-only", "gen-doc",
             "output=", "output-bsps=", "output-prjs=", "output-srcs=",
             "prefix=", "gcc-dir=", "gnat-dir=", "link"])
    except getopt.GetoptError, e:
        print "error: " + str(e)
        print ""
        usage()
        sys.exit(2)
    for opt, arg in opts:
        if opt in ("-v", "--verbose"):
            FilesHolder.verbose = True
        elif opt in ("-h", "--help"):
            usage()
            sys.exit()
        elif opt in ("-l", "--link"):
            FilesHolder.link = True
        elif opt == "--output":
            dest = arg
        elif opt == "--output-bsps":
            dest_bsps = arg
        elif opt == "--output-prjs":
            dest_prjs = arg
        elif opt == "--output-srcs":
            dest_srcs = arg
        elif opt == "--gcc-dir":
            FilesHolder.gccdir = arg
        elif opt == "--gnat-dir":
            FilesHolder.gnatdir = arg
        elif opt == "--prefix":
            prefix = arg
        elif opt == "--bsps-only":
            gen_rts_srcs = False
        elif opt == "--gen-doc":
            gen_doc = True
        else:
            print "unexpected switch: %s" % opt
            sys.exit(2)

    if len(args) < 1:
        print "error: missing configuration"
        print ""
        usage()
        sys.exit(2)

    boards = []

    for arg in args:
        board = build_configs(arg)
        boards.append(board)

    # figure out the target
    target = boards[0].target
    if target is None:
        target = "native"
    for board in boards:
        if board.target is None and target == "native":
            continue
        if board.target != target:
            target = None

    dest = os.path.abspath(dest)
    if not os.path.exists(dest):
        os.makedirs(dest)

    # README file generation
    if gen_doc:
        doc_dir = os.path.join(dest, 'doc')
        docgen(boards, target, doc_dir)
        # and do nothing else
        return

    # default paths in case not specified from the command-line:
    if dest_bsps is None:
        dest_bsps = os.path.join(dest, 'BSPs')
    if not os.path.exists(dest_bsps):
        os.makedirs(dest_bsps)

    # Install the BSPs
    for board in boards:
        install = Installer(board)
        install.install(dest_bsps, prefix)

    # post-processing, install ada_object_path and ada_source_path to be
    # installed in all runtimes by gprinstall
    bsp_support = os.path.join(dest_bsps, 'support')
    if not os.path.exists(bsp_support):
        os.mkdir(bsp_support)
        with open(os.path.join(bsp_support, 'ada_source_path'), 'w') as fp:
            fp.write('gnat\ngnarl\n')
        with open(os.path.join(bsp_support, 'ada_object_path'), 'w') as fp:
            fp.write('adalib\n')

    if gen_rts_srcs:
        assert target is not None, \
            "cannot generate rts sources for mixed cross compilers"
        is_pikeos = target is not None and 'pikeos' in target

        # determining what runtime sources we need:
        # - 'pikeos': all profiles, and a specific rts sources organisation
        # - 'ravenscar-full': all profiles support
        # - 'ravenscar-sfp': sfp + zfp profiles support
        # - 'zfp': just zfp support

        if is_pikeos:
            rts_profile = 'ravenscar-full'
        else:
            rts_profile = 'zfp'

            for board in boards:
                if 'ravenscar-full' in board.system_ads:
                    # install everything
                    rts_profile = 'ravenscar-full'
                    break
                else:
                    for rts in board.system_ads:
                        if 'ravenscar-' in rts:
                            rts_profile = 'ravenscar-sfp'

        # Compute rts sources subdirectories

        if dest_prjs is None:
            dest_prjs = os.path.join(dest, 'lib', 'gnat')
        if dest_srcs is None:
            dest_srcs = os.path.join(dest, 'include', 'rts-sources')
        if not os.path.exists(dest_prjs):
            os.makedirs(dest_prjs)
        if not os.path.exists(dest_srcs):
            os.makedirs(dest_srcs)

        # Install the shared runtime sources
        SourceTree.dest_sources = dest_srcs
        SourceTree.dest_prjs = dest_prjs

        # create the rts sources object. This uses a slightly different set
        # on pikeos.
        rts_srcs = SourceTree(
            is_bb=not is_pikeos, profile=rts_profile,
            rts_sources=sources, rts_scenarios=all_scenarios)
        rts_srcs.install()


if __name__ == '__main__':
    main()
