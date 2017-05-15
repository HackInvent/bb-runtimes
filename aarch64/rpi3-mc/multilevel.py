#! /usr/bin/env python
#
# Copyright (C) 2016, AdaCore
#
# Python script to generate MMU tables.

import getopt
import sys
import xml.etree.ElementTree as ET

import sys
sys.path.append('../../arm')
import memmap


class vcpu(object):
    def __init__(self, rom_size, ram_size):
        self.rom_size = rom_size
        self.ram_size = ram_size


def usage():
    print "usage: multilevel.py [--gen-regions | --gen-mmu] OPTIONS [INPUT]"
    print "Options are:"
    print " --arch=ARCH      set architecture"
    print "    architectures are: %s" % ", ".join(arches.keys())


def main():
    arch = None
    gen_regions = False
    gen_mmu = False

    try:
        opts, args = getopt.getopt(
            sys.argv[1:], "h", ["help", "arch=", "gen-regions", "gen-mmu"])
    except getopt.GetoptError, e:
        sys.stderr.write("error: " + str(e) + '\n')
        sys.stderr.write("Try --help\n")
        sys.exit(2)
    for opt, arg in opts:
        if opt == "--arch":
            arch = arg
        elif opt in ("-h", "--help"):
            usage()
            sys.exit()
        elif opt == "--gen-regions":
            gen_regions = True
        elif opt == "--gen-mmu":
            gen_mmu = True
        else:
            sys.abort()

    if len(args) == 0:
        filename = "memmap.xml"
    elif len(args) == 1:
        filename = args[0]
    else:
        sys.stderr.write("error: too many arguments\n")
        sys.stderr.write("Try --help\n")
        sys.exit(2)

    tree = ET.parse(filename)
    root = tree.getroot()

    if root.tag != "multi-image":
        sys.stderr.write("document tag must be 'multi-image'")
        sys.exit(2)

    mmu = memmap.create_mmu_from_xml(root, arch, "el2")

    memmap_el = root.find('include')
    memmap_tree = ET.parse(memmap_el.get('file'))
    regions = memmap.parse_memmap(mmu, memmap_tree.getroot())

    image_el = root.find('image')
    main_region_name = image_el.get('region')
    main_region = [r for r in regions if r.name == main_region_name][0]

    cpus = {}
    base = main_region.phys
    for child in image_el:
        num = child.attrib['num']
        ram_size = memmap.parse_addr(child.attrib['ram_size'])
        rom_size = memmap.parse_addr(child.attrib['rom_size'])
        v = vcpu(rom_size, ram_size)
        v.ram_paddr = base
        v.ram_vaddr = 0
        base += ram_size
        v.rom_paddr = base
        v.rom_vaddr = ram_size
        base += rom_size
        cpus[num] = v

    if base > main_region.size:
        sys.stderr.write("image size is too large")
        sys.exit(2)

    if gen_regions:
        for k, v in cpus.iteritems():
            filename = 'cpu_{}.ld'.format(k)
            print "Writing {}".format(filename)
            with open(filename, 'w') as f:
                f.write("MEMORY\n")
                f.write("{\n")
                f.write("  RAM (rwx): ORIGIN = {:#x}, LENGTH = {:#x}\n".format(
                    v.ram_vaddr, v.ram_size))
                f.write("  ROM (rx):  ORIGIN = {:#x}, LENGTH = {:#x}\n".format(
                    v.rom_vaddr, v.rom_size))
                f.write("}\n")

    if gen_mmu:
        for r in regions:
            mmu.insert(r.name, r.virt, r.phys, r.size, r.cache, r.access)
        mmu.generate("__mmu")

        for k, v in cpus.iteritems():
            mmu = memmap.create_mmu_from_xml(root, arch, "stage2")
            mmu.insert("ram", v.ram_vaddr, v.ram_paddr, v.ram_size,
                       "wb", "rwx---")
            mmu.insert("rom", v.rom_vaddr, v.rom_paddr, v.rom_size,
                       "wb", "r-x---")
            mmu.generate("__mmu_cpu_{}".format(k))


if __name__ == '__main__':
    main()
