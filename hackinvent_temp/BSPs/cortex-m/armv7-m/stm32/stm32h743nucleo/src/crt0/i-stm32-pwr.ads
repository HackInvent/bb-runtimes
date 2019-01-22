--
--  Copyright (C) 2017, AdaCore
--

--  This spec has been automatically generated from STM32F7x9.svd

pragma Ada_2012;
pragma Style_Checks (Off);

with System;

package Interfaces.STM32.PWR is
   pragma Preelaborate;
   pragma No_Elaboration_Code_All;

   ---------------
   -- Registers --
   ---------------

   subtype PWR_CR1_LPDS_Field is Interfaces.STM32.Bit;
   subtype PWR_CR1_PVDE_Field is Interfaces.STM32.Bit;
   subtype PWR_CR1_PLS_Field is Interfaces.STM32.UInt3;
   subtype PWR_CR1_DBP_Field is Interfaces.STM32.Bit;
   subtype PWR_CR1_FLPS_Field is Interfaces.STM32.Bit;
   subtype PWR_CR1_SVOS_Field is Interfaces.STM32.UInt2;
   subtype PWR_CR1_AVDEN_Field is Interfaces.STM32.Bit;
   subtype PWR_CR1_ALS_Field is Interfaces.STM32.UInt2;

   --  PWR control register 1
   type PWR_CR1_Register is record
      --  Low-power Deepsleep with SVOS3 (SVOS4 and SVOS5 always use low-power,
      --  regardless of the setting of this bit)
      LPDS           : PWR_CR1_LPDS_Field := 16#0#;
      --  unspecified
      Reserved_1_3   : Interfaces.STM32.UInt3 := 16#0#;
      --  Programmable voltage detector enable
      PVDE           : PWR_CR1_PVDE_Field := 16#0#;
      --  Programmable voltage detector level selection These bits select the
      --  voltage threshold detected by the PVD. Note: Refer to Section
      --  Electrical characteristics of the product datasheet for more details.
      PLS            : PWR_CR1_PLS_Field := 16#0#;
      --  Disable backup domain write protection In reset state, the RCC_BDCR
      --  register, the RTC registers (including the backup registers), BREN
      --  and MOEN bits in PWR_CR2 register, are protected against parasitic
      --  write access. This bit must be set to enable write access to these
      --  registers.
      DBP            : PWR_CR1_DBP_Field := 16#0#;
      --  Flash low-power mode in DStop mode This bit allows to obtain the best
      --  trade-off between low-power consumption and restart time when exiting
      --  from DStop mode. When it is set, the Flash memory enters low-power
      --  mode when D1 domain is in DStop mode.
      FLPS           : PWR_CR1_FLPS_Field := 16#0#;
      --  unspecified
      Reserved_10_13 : Interfaces.STM32.UInt4 := 16#0#;
      --  System Stop mode voltage scaling selection These bits control the
      --  VCORE voltage level in system Stop mode, to obtain the best trade-off
      --  between power consumption and performance.
      SVOS           : PWR_CR1_SVOS_Field := 16#3#;
      --  Peripheral voltage monitor on VDDA enable
      AVDEN          : PWR_CR1_AVDEN_Field := 16#0#;
      --  Analog voltage detector level selection These bits select the voltage
      --  threshold detected by the AVD.
      ALS            : PWR_CR1_ALS_Field := 16#0#;
      --  unspecified
      Reserved_19_31 : Interfaces.STM32.UInt13 := 16#1E00#;
   end record
     with Volatile_Full_Access, Size => 32,
          Bit_Order => System.Low_Order_First;

   for PWR_CR1_Register use record
      LPDS           at 0 range 0 .. 0;
      Reserved_1_3   at 0 range 1 .. 3;
      PVDE           at 0 range 4 .. 4;
      PLS            at 0 range 5 .. 7;
      DBP            at 0 range 8 .. 8;
      FLPS           at 0 range 9 .. 9;
      Reserved_10_13 at 0 range 10 .. 13;
      SVOS           at 0 range 14 .. 15;
      AVDEN          at 0 range 16 .. 16;
      ALS            at 0 range 17 .. 18;
      Reserved_19_31 at 0 range 19 .. 31;
   end record;

   subtype PWR_CSR1_PVDO_Field is Interfaces.STM32.Bit;
   subtype PWR_CSR1_ACTVOSRDY_Field is Interfaces.STM32.Bit;
   subtype PWR_CSR1_ACTVOS_Field is Interfaces.STM32.UInt2;
   subtype PWR_CSR1_AVDO_Field is Interfaces.STM32.Bit;

   --  PWR control status register 1
   type PWR_CSR1_Register is record
      --  unspecified
      Reserved_0_3   : Interfaces.STM32.UInt4;
      --  Read-only. Programmable voltage detect output This bit is set and
      --  cleared by hardware. It is valid only if the PVD has been enabled by
      --  the PVDE bit. Note: since the PVD is disabled in Standby mode, this
      --  bit is equal to 0 after Standby or reset until the PVDE bit is set.
      PVDO           : PWR_CSR1_PVDO_Field;
      --  unspecified
      Reserved_5_12  : Interfaces.STM32.Byte;
      --  Read-only. Voltage levels ready bit for currently used VOS and
      --  SDLEVEL This bit is set to 1 by hardware when the voltage regulator
      --  and the SD converter are both disabled and Bypass mode is selected in
      --  PWR control register 3 (PWR_CR3).
      ACTVOSRDY      : PWR_CSR1_ACTVOSRDY_Field;
      --  Read-only. VOS currently applied for VCORE voltage scaling selection.
      --  These bits reflect the last VOS value applied to the PMU.
      ACTVOS         : PWR_CSR1_ACTVOS_Field;
      --  Read-only. Analog voltage detector output on VDDA This bit is set and
      --  cleared by hardware. It is valid only if AVD on VDDA is enabled by
      --  the AVDEN bit. Note: Since the AVD is disabled in Standby mode, this
      --  bit is equal to 0 after Standby or reset until the AVDEN bit is set.
      AVDO           : PWR_CSR1_AVDO_Field;
      --  unspecified
      Reserved_17_31 : Interfaces.STM32.UInt15;
   end record
     with Volatile_Full_Access, Size => 32,
          Bit_Order => System.Low_Order_First;

   for PWR_CSR1_Register use record
      Reserved_0_3   at 0 range 0 .. 3;
      PVDO           at 0 range 4 .. 4;
      Reserved_5_12  at 0 range 5 .. 12;
      ACTVOSRDY      at 0 range 13 .. 13;
      ACTVOS         at 0 range 14 .. 15;
      AVDO           at 0 range 16 .. 16;
      Reserved_17_31 at 0 range 17 .. 31;
   end record;

   subtype PWR_CR2_BREN_Field is Interfaces.STM32.Bit;
   subtype PWR_CR2_MONEN_Field is Interfaces.STM32.Bit;
   subtype PWR_CR2_BRRDY_Field is Interfaces.STM32.Bit;
   subtype PWR_CR2_VBATL_Field is Interfaces.STM32.Bit;
   subtype PWR_CR2_VBATH_Field is Interfaces.STM32.Bit;
   subtype PWR_CR2_TEMPL_Field is Interfaces.STM32.Bit;
   subtype PWR_CR2_TEMPH_Field is Interfaces.STM32.Bit;

   --  This register is not reset by wakeup from Standby mode, RESET signal and
   --  VDD POR. It is only reset by VSW POR and VSWRST reset. This register
   --  shall not be accessed when VSWRST bit in RCC_BDCR register resets the
   --  VSW domain.After reset, PWR_CR2 register is write-protected. Prior to
   --  modifying its content, the DBP bit in PWR_CR1 register must be set to
   --  disable the write protection.
   type PWR_CR2_Register is record
      --  Backup regulator enable When set, the Backup regulator (used to
      --  maintain the backup RAM content in Standby and VBAT modes) is
      --  enabled. If BREN is reset, the backup regulator is switched off. The
      --  backup RAM can still be used in Run and Stop modes. However, its
      --  content will be lost in Standby and VBAT modes. If BREN is set, the
      --  application must wait till the Backup Regulator Ready flag (BRRDY) is
      --  set to indicate that the data written into the SRAM will be
      --  maintained in Standby and VBAT modes.
      BREN           : PWR_CR2_BREN_Field := 16#0#;
      --  unspecified
      Reserved_1_3   : Interfaces.STM32.UInt3 := 16#0#;
      --  VBAT and temperature monitoring enable When set, the VBAT supply and
      --  temperature monitoring is enabled.
      MONEN          : PWR_CR2_MONEN_Field := 16#0#;
      --  unspecified
      Reserved_5_15  : Interfaces.STM32.UInt11 := 16#0#;
      --  Read-only. Backup regulator ready This bit is set by hardware to
      --  indicate that the Backup regulator is ready.
      BRRDY          : PWR_CR2_BRRDY_Field := 16#0#;
      --  unspecified
      Reserved_17_19 : Interfaces.STM32.UInt3 := 16#0#;
      --  Read-only. VBAT level monitoring versus low threshold
      VBATL          : PWR_CR2_VBATL_Field := 16#0#;
      --  Read-only. VBAT level monitoring versus high threshold
      VBATH          : PWR_CR2_VBATH_Field := 16#0#;
      --  Read-only. Temperature level monitoring versus low threshold
      TEMPL          : PWR_CR2_TEMPL_Field := 16#0#;
      --  Read-only. Temperature level monitoring versus high threshold
      TEMPH          : PWR_CR2_TEMPH_Field := 16#0#;
      --  unspecified
      Reserved_24_31 : Interfaces.STM32.Byte := 16#0#;
   end record
     with Volatile_Full_Access, Size => 32,
          Bit_Order => System.Low_Order_First;

   for PWR_CR2_Register use record
      BREN           at 0 range 0 .. 0;
      Reserved_1_3   at 0 range 1 .. 3;
      MONEN          at 0 range 4 .. 4;
      Reserved_5_15  at 0 range 5 .. 15;
      BRRDY          at 0 range 16 .. 16;
      Reserved_17_19 at 0 range 17 .. 19;
      VBATL          at 0 range 20 .. 20;
      VBATH          at 0 range 21 .. 21;
      TEMPL          at 0 range 22 .. 22;
      TEMPH          at 0 range 23 .. 23;
      Reserved_24_31 at 0 range 24 .. 31;
   end record;

   subtype PWR_CR3_BYPASS_Field is Interfaces.STM32.Bit;
   subtype PWR_CR3_LDOEN_Field is Interfaces.STM32.Bit;
   subtype PWR_CR3_SDEN_Field is Interfaces.STM32.Bit;
   subtype PWR_CR3_VBE_Field is Interfaces.STM32.Bit;
   subtype PWR_CR3_VBRS_Field is Interfaces.STM32.Bit;
   subtype PWR_CR3_USB33DEN_Field is Interfaces.STM32.Bit;
   subtype PWR_CR3_USBREGEN_Field is Interfaces.STM32.Bit;
   subtype PWR_CR3_USB33RDY_Field is Interfaces.STM32.Bit;

   --  Reset only by POR only, not reset by wakeup from Standby mode and RESET
   --  pad. The lower byte of this register is written once after POR and shall
   --  be written before changing VOS level or ck_sys clock frequency. No
   --  limitation applies to the upper bytes.Programming data corresponding to
   --  an invalid combination of SDLEVEL, SDEXTHP, SDEN, LDOEN and BYPASS bits
   --  (see Table9) will be ignored: data will not be written, the written-once
   --  mechanism will lock the register and any further write access will be
   --  ignored. The default supply configuration will be kept and the ACTVOSRDY
   --  bit in PWR control status register 1 (PWR_CSR1) will go on indicating
   --  invalid voltage levels. The system shall be power cycled before writing
   --  a new value.
   type PWR_CR3_Register is record
      --  Power management unit bypass
      BYPASS         : PWR_CR3_BYPASS_Field := 16#0#;
      --  Low drop-out regulator enable
      LDOEN          : PWR_CR3_LDOEN_Field := 16#1#;
      --  SD converter Enable
      SDEN           : PWR_CR3_SDEN_Field := 16#1#;
      --  unspecified
      Reserved_3_7   : Interfaces.STM32.UInt5 := 16#0#;
      --  VBAT charging enable
      VBE            : PWR_CR3_VBE_Field := 16#0#;
      --  VBAT charging resistor selection
      VBRS           : PWR_CR3_VBRS_Field := 16#0#;
      --  unspecified
      Reserved_10_23 : Interfaces.STM32.UInt14 := 16#0#;
      --  Write-only. VDD33USB voltage level detector enable.
      USB33DEN       : PWR_CR3_USB33DEN_Field := 16#0#;
      --  USB regulator enable.
      USBREGEN       : PWR_CR3_USBREGEN_Field := 16#0#;
      --  Read-only. USB supply ready.
      USB33RDY       : PWR_CR3_USB33RDY_Field := 16#0#;
      --  unspecified
      Reserved_27_31 : Interfaces.STM32.UInt5 := 16#0#;
   end record
     with Volatile_Full_Access, Size => 32,
          Bit_Order => System.Low_Order_First;

   for PWR_CR3_Register use record
      BYPASS         at 0 range 0 .. 0;
      LDOEN          at 0 range 1 .. 1;
      SDEN           at 0 range 2 .. 2;
      Reserved_3_7   at 0 range 3 .. 7;
      VBE            at 0 range 8 .. 8;
      VBRS           at 0 range 9 .. 9;
      Reserved_10_23 at 0 range 10 .. 23;
      USB33DEN       at 0 range 24 .. 24;
      USBREGEN       at 0 range 25 .. 25;
      USB33RDY       at 0 range 26 .. 26;
      Reserved_27_31 at 0 range 27 .. 31;
   end record;

   --  PWR_CPUCR_PDDS_D array element
   subtype PWR_CPUCR_PDDS_D_Element is Interfaces.STM32.Bit;

   --  PWR_CPUCR_PDDS_D array
   type PWR_CPUCR_PDDS_D_Field_Array is array (1 .. 3)
     of PWR_CPUCR_PDDS_D_Element
     with Component_Size => 1, Size => 3;

   --  Type definition for PWR_CPUCR_PDDS_D
   type PWR_CPUCR_PDDS_D_Field
     (As_Array : Boolean := False)
   is record
      case As_Array is
         when False =>
            --  PDDS_D as a value
            Val : Interfaces.STM32.UInt3;
         when True =>
            --  PDDS_D as an array
            Arr : PWR_CPUCR_PDDS_D_Field_Array;
      end case;
   end record
     with Unchecked_Union, Size => 3;

   for PWR_CPUCR_PDDS_D_Field use record
      Val at 0 range 0 .. 2;
      Arr at 0 range 0 .. 2;
   end record;

   subtype PWR_CPUCR_STOPF_Field is Interfaces.STM32.Bit;
   subtype PWR_CPUCR_SBF_Field is Interfaces.STM32.Bit;
   --  PWR_CPUCR_SBF_D array element
   subtype PWR_CPUCR_SBF_D_Element is Interfaces.STM32.Bit;

   --  PWR_CPUCR_SBF_D array
   type PWR_CPUCR_SBF_D_Field_Array is array (1 .. 2)
     of PWR_CPUCR_SBF_D_Element
     with Component_Size => 1, Size => 2;

   --  Type definition for PWR_CPUCR_SBF_D
   type PWR_CPUCR_SBF_D_Field
     (As_Array : Boolean := False)
   is record
      case As_Array is
         when False =>
            --  SBF_D as a value
            Val : Interfaces.STM32.UInt2;
         when True =>
            --  SBF_D as an array
            Arr : PWR_CPUCR_SBF_D_Field_Array;
      end case;
   end record
     with Unchecked_Union, Size => 2;

   for PWR_CPUCR_SBF_D_Field use record
      Val at 0 range 0 .. 1;
      Arr at 0 range 0 .. 1;
   end record;

   subtype PWR_CPUCR_CSSF_Field is Interfaces.STM32.Bit;
   subtype PWR_CPUCR_RUN_D3_Field is Interfaces.STM32.Bit;

   --  This register allows controlling CPU1 power.
   type PWR_CPUCR_Register is record
      --  D1 domain Power Down Deepsleep selection. This bit allows CPU1 to
      --  define the Deepsleep mode for D1 domain.
      PDDS_D         : PWR_CPUCR_PDDS_D_Field :=
                        (As_Array => False, Val => 16#0#);
      --  unspecified
      Reserved_3_4   : Interfaces.STM32.UInt2 := 16#0#;
      --  Read-only. STOP flag This bit is set by hardware and cleared only by
      --  any reset or by setting the CPU1 CSSF bit.
      STOPF          : PWR_CPUCR_STOPF_Field := 16#0#;
      --  Read-only. System Standby flag This bit is set by hardware and
      --  cleared only by a POR (Power-on Reset) or by setting the CPU1 CSSF
      --  bit
      SBF            : PWR_CPUCR_SBF_Field := 16#0#;
      --  Read-only. D1 domain DStandby flag This bit is set by hardware and
      --  cleared by any system reset or by setting the CPU1 CSSF bit. Once
      --  set, this bit can be cleared only when the D1 domain is no longer in
      --  DStandby mode.
      SBF_D          : PWR_CPUCR_SBF_D_Field :=
                        (As_Array => False, Val => 16#0#);
      --  Clear D1 domain CPU1 Standby, Stop and HOLD flags (always read as 0)
      --  This bit is cleared to 0 by hardware.
      CSSF           : PWR_CPUCR_CSSF_Field := 16#0#;
      --  unspecified
      Reserved_10_10 : Interfaces.STM32.Bit := 16#0#;
      --  Keep system D3 domain in Run mode regardless of the CPU sub-systems
      --  modes
      RUN_D3         : PWR_CPUCR_RUN_D3_Field := 16#0#;
      --  unspecified
      Reserved_12_31 : Interfaces.STM32.UInt20 := 16#0#;
   end record
     with Volatile_Full_Access, Size => 32,
          Bit_Order => System.Low_Order_First;

   for PWR_CPUCR_Register use record
      PDDS_D         at 0 range 0 .. 2;
      Reserved_3_4   at 0 range 3 .. 4;
      STOPF          at 0 range 5 .. 5;
      SBF            at 0 range 6 .. 6;
      SBF_D          at 0 range 7 .. 8;
      CSSF           at 0 range 9 .. 9;
      Reserved_10_10 at 0 range 10 .. 10;
      RUN_D3         at 0 range 11 .. 11;
      Reserved_12_31 at 0 range 12 .. 31;
   end record;

   subtype PWR_D3CR_VOSRDY_Field is Interfaces.STM32.Bit;
   subtype PWR_D3CR_VOS_Field is Interfaces.STM32.UInt2;

   --  This register allows controlling D3 domain power.Following reset VOSRDY
   --  will be read 1 by software
   type PWR_D3CR_Register is record
      --  unspecified
      Reserved_0_12  : Interfaces.STM32.UInt13 := 16#0#;
      --  Read-only. VOS Ready bit for VCORE voltage scaling output selection.
      --  This bit is set to 1 by hardware when Bypass mode is selected in PWR
      --  control register 3 (PWR_CR3).
      VOSRDY         : PWR_D3CR_VOSRDY_Field := 16#0#;
      --  Voltage scaling selection according to performance These bits control
      --  the VCORE voltage level and allow to obtains the best trade-off
      --  between power consumption and performance: When increasing the
      --  performance, the voltage scaling shall be changed before increasing
      --  the system frequency. When decreasing performance, the system
      --  frequency shall first be decreased before changing the voltage
      --  scaling.
      VOS            : PWR_D3CR_VOS_Field := 16#1#;
      --  unspecified
      Reserved_16_31 : Interfaces.STM32.UInt16 := 16#0#;
   end record
     with Volatile_Full_Access, Size => 32,
          Bit_Order => System.Low_Order_First;

   for PWR_D3CR_Register use record
      Reserved_0_12  at 0 range 0 .. 12;
      VOSRDY         at 0 range 13 .. 13;
      VOS            at 0 range 14 .. 15;
      Reserved_16_31 at 0 range 16 .. 31;
   end record;

   subtype PWR_WKUPCR_WKUPC_Field is Interfaces.STM32.UInt6;

   --  reset only by system reset, not reset by wakeup from Standby mode5 wait
   --  states are required when writing this register (when clearing a WKUPF
   --  bit in PWR_WKUPFR, the AHB write access will complete after the WKUPF
   --  has been cleared).
   type PWR_WKUPCR_Register is record
      --  Clear Wakeup pin flag for WKUP. These bits are always read as 0.
      WKUPC         : PWR_WKUPCR_WKUPC_Field := 16#0#;
      --  unspecified
      Reserved_6_31 : Interfaces.STM32.UInt26 := 16#0#;
   end record
     with Volatile_Full_Access, Size => 32,
          Bit_Order => System.Low_Order_First;

   for PWR_WKUPCR_Register use record
      WKUPC         at 0 range 0 .. 5;
      Reserved_6_31 at 0 range 6 .. 31;
   end record;

   --  PWR_WKUPFR_WKUPF array element
   subtype PWR_WKUPFR_WKUPF_Element is Interfaces.STM32.Bit;

   --  PWR_WKUPFR_WKUPF array
   type PWR_WKUPFR_WKUPF_Field_Array is array (1 .. 6)
     of PWR_WKUPFR_WKUPF_Element
     with Component_Size => 1, Size => 6;

   --  Type definition for PWR_WKUPFR_WKUPF
   type PWR_WKUPFR_WKUPF_Field
     (As_Array : Boolean := False)
   is record
      case As_Array is
         when False =>
            --  WKUPF as a value
            Val : Interfaces.STM32.UInt6;
         when True =>
            --  WKUPF as an array
            Arr : PWR_WKUPFR_WKUPF_Field_Array;
      end case;
   end record
     with Unchecked_Union, Size => 6;

   for PWR_WKUPFR_WKUPF_Field use record
      Val at 0 range 0 .. 5;
      Arr at 0 range 0 .. 5;
   end record;

   --  reset only by system reset, not reset by wakeup from Standby mode
   type PWR_WKUPFR_Register is record
      --  Wakeup pin WKUPF flag. This bit is set by hardware and cleared only
      --  by a Reset pin or by setting the WKUPCn+1 bit in the PWR wakeup clear
      --  register (PWR_WKUPCR).
      WKUPF         : PWR_WKUPFR_WKUPF_Field :=
                       (As_Array => False, Val => 16#0#);
      --  unspecified
      Reserved_6_31 : Interfaces.STM32.UInt26 := 16#0#;
   end record
     with Volatile_Full_Access, Size => 32,
          Bit_Order => System.Low_Order_First;

   for PWR_WKUPFR_Register use record
      WKUPF         at 0 range 0 .. 5;
      Reserved_6_31 at 0 range 6 .. 31;
   end record;

   --  PWR_WKUPEPR_WKUPEN array element
   subtype PWR_WKUPEPR_WKUPEN_Element is Interfaces.STM32.Bit;

   --  PWR_WKUPEPR_WKUPEN array
   type PWR_WKUPEPR_WKUPEN_Field_Array is array (1 .. 6)
     of PWR_WKUPEPR_WKUPEN_Element
     with Component_Size => 1, Size => 6;

   --  Type definition for PWR_WKUPEPR_WKUPEN
   type PWR_WKUPEPR_WKUPEN_Field
     (As_Array : Boolean := False)
   is record
      case As_Array is
         when False =>
            --  WKUPEN as a value
            Val : Interfaces.STM32.UInt6;
         when True =>
            --  WKUPEN as an array
            Arr : PWR_WKUPEPR_WKUPEN_Field_Array;
      end case;
   end record
     with Unchecked_Union, Size => 6;

   for PWR_WKUPEPR_WKUPEN_Field use record
      Val at 0 range 0 .. 5;
      Arr at 0 range 0 .. 5;
   end record;

   --  PWR_WKUPEPR_WKUPP array element
   subtype PWR_WKUPEPR_WKUPP_Element is Interfaces.STM32.Bit;

   --  PWR_WKUPEPR_WKUPP array
   type PWR_WKUPEPR_WKUPP_Field_Array is array (1 .. 6)
     of PWR_WKUPEPR_WKUPP_Element
     with Component_Size => 1, Size => 6;

   --  Type definition for PWR_WKUPEPR_WKUPP
   type PWR_WKUPEPR_WKUPP_Field
     (As_Array : Boolean := False)
   is record
      case As_Array is
         when False =>
            --  WKUPP as a value
            Val : Interfaces.STM32.UInt6;
         when True =>
            --  WKUPP as an array
            Arr : PWR_WKUPEPR_WKUPP_Field_Array;
      end case;
   end record
     with Unchecked_Union, Size => 6;

   for PWR_WKUPEPR_WKUPP_Field use record
      Val at 0 range 0 .. 5;
      Arr at 0 range 0 .. 5;
   end record;

   --  PWR_WKUPEPR_WKUPPUPD array element
   subtype PWR_WKUPEPR_WKUPPUPD_Element is Interfaces.STM32.UInt2;

   --  PWR_WKUPEPR_WKUPPUPD array
   type PWR_WKUPEPR_WKUPPUPD_Field_Array is array (1 .. 6)
     of PWR_WKUPEPR_WKUPPUPD_Element
     with Component_Size => 2, Size => 12;

   --  Type definition for PWR_WKUPEPR_WKUPPUPD
   type PWR_WKUPEPR_WKUPPUPD_Field
     (As_Array : Boolean := False)
   is record
      case As_Array is
         when False =>
            --  WKUPPUPD as a value
            Val : Interfaces.STM32.UInt12;
         when True =>
            --  WKUPPUPD as an array
            Arr : PWR_WKUPEPR_WKUPPUPD_Field_Array;
      end case;
   end record
     with Unchecked_Union, Size => 12;

   for PWR_WKUPEPR_WKUPPUPD_Field use record
      Val at 0 range 0 .. 11;
      Arr at 0 range 0 .. 11;
   end record;

   --  Reset only by system reset, not reset by wakeup from Standby mode
   type PWR_WKUPEPR_Register is record
      --  Enable Wakeup Pin WKUPn+1 Each bit is set and cleared by software.
      --  Note: An additional wakeup event is detected if WKUPn+1 pin is
      --  enabled (by setting the WKUPENn+1 bit) when WKUPn+1 pin level is
      --  already high when WKUPPn+1 selects rising edge, or low when WKUPPn+1
      --  selects falling edge.
      WKUPEN         : PWR_WKUPEPR_WKUPEN_Field :=
                        (As_Array => False, Val => 16#0#);
      --  unspecified
      Reserved_6_7   : Interfaces.STM32.UInt2 := 16#0#;
      --  Wakeup pin polarity bit for WKUPn-7 These bits define the polarity
      --  used for event detection on WKUPn-7 external wakeup pin.
      WKUPP          : PWR_WKUPEPR_WKUPP_Field :=
                        (As_Array => False, Val => 16#0#);
      --  unspecified
      Reserved_14_15 : Interfaces.STM32.UInt2 := 16#0#;
      --  Wakeup pin pull configuration
      WKUPPUPD       : PWR_WKUPEPR_WKUPPUPD_Field :=
                        (As_Array => False, Val => 16#0#);
      --  unspecified
      Reserved_28_31 : Interfaces.STM32.UInt4 := 16#0#;
   end record
     with Volatile_Full_Access, Size => 32,
          Bit_Order => System.Low_Order_First;

   for PWR_WKUPEPR_Register use record
      WKUPEN         at 0 range 0 .. 5;
      Reserved_6_7   at 0 range 6 .. 7;
      WKUPP          at 0 range 8 .. 13;
      Reserved_14_15 at 0 range 14 .. 15;
      WKUPPUPD       at 0 range 16 .. 27;
      Reserved_28_31 at 0 range 28 .. 31;
   end record;

   -----------------
   -- Peripherals --
   -----------------

   --  PWR
   type PWR_Peripheral is record
      --  PWR control register 1
      PWR_CR1     : aliased PWR_CR1_Register;
      --  PWR control status register 1
      PWR_CSR1    : aliased PWR_CSR1_Register;
      --  This register is not reset by wakeup from Standby mode, RESET signal
      --  and VDD POR. It is only reset by VSW POR and VSWRST reset. This
      --  register shall not be accessed when VSWRST bit in RCC_BDCR register
      --  resets the VSW domain.After reset, PWR_CR2 register is
      --  write-protected. Prior to modifying its content, the DBP bit in
      --  PWR_CR1 register must be set to disable the write protection.
      PWR_CR2     : aliased PWR_CR2_Register;
      --  Reset only by POR only, not reset by wakeup from Standby mode and
      --  RESET pad. The lower byte of this register is written once after POR
      --  and shall be written before changing VOS level or ck_sys clock
      --  frequency. No limitation applies to the upper bytes.Programming data
      --  corresponding to an invalid combination of SDLEVEL, SDEXTHP, SDEN,
      --  LDOEN and BYPASS bits (see Table9) will be ignored: data will not be
      --  written, the written-once mechanism will lock the register and any
      --  further write access will be ignored. The default supply
      --  configuration will be kept and the ACTVOSRDY bit in PWR control
      --  status register 1 (PWR_CSR1) will go on indicating invalid voltage
      --  levels. The system shall be power cycled before writing a new value.
      PWR_CR3     : aliased PWR_CR3_Register;
      --  This register allows controlling CPU1 power.
      PWR_CPUCR   : aliased PWR_CPUCR_Register;
      --  This register allows controlling D3 domain power.Following reset
      --  VOSRDY will be read 1 by software
      PWR_D3CR    : aliased PWR_D3CR_Register;
      --  reset only by system reset, not reset by wakeup from Standby mode5
      --  wait states are required when writing this register (when clearing a
      --  WKUPF bit in PWR_WKUPFR, the AHB write access will complete after the
      --  WKUPF has been cleared).
      PWR_WKUPCR  : aliased PWR_WKUPCR_Register;
      --  reset only by system reset, not reset by wakeup from Standby mode
      PWR_WKUPFR  : aliased PWR_WKUPFR_Register;
      --  Reset only by system reset, not reset by wakeup from Standby mode
      PWR_WKUPEPR : aliased PWR_WKUPEPR_Register;
   end record
     with Volatile;

   for PWR_Peripheral use record
      PWR_CR1     at 16#0# range 0 .. 31;
      PWR_CSR1    at 16#4# range 0 .. 31;
      PWR_CR2     at 16#8# range 0 .. 31;
      PWR_CR3     at 16#C# range 0 .. 31;
      PWR_CPUCR   at 16#10# range 0 .. 31;
      PWR_D3CR    at 16#18# range 0 .. 31;
      PWR_WKUPCR  at 16#20# range 0 .. 31;
      PWR_WKUPFR  at 16#24# range 0 .. 31;
      PWR_WKUPEPR at 16#28# range 0 .. 31;
   end record;

   --  PWR
   PWR_Periph : aliased PWR_Peripheral
     with Import, Address => System'To_Address (16#58024800#);

end Interfaces.STM32.PWR;
