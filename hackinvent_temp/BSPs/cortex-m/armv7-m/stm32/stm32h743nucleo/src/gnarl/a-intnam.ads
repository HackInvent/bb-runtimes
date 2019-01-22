--
--  Copyright (C) 2017, AdaCore
--

--  This spec has been automatically generated from STM32F7x9.svd

--  This is a version for the STM32F7x9 MCU
package Ada.Interrupts.Names is

   --  All identifiers in this unit are implementation defined

   pragma Implementation_Defined;

   ----------------
   -- Interrupts --
   ----------------

   --  System tick
   Sys_Tick_Interrupt            : constant Interrupt_ID := -1;

   --  Window Watchdog interrupt
   WWDG1                             : constant := 0;

   --  PVD through EXTI line
   PVD_PVM                           : constant := 1;

   --  RTC tamper, timestamp
   RTC_TAMP_STAMP_CSS_LSE            : constant := 2;

   --  RTC Wakeup interrupt
   RTC_WKUP                          : constant := 3;

   --  Flash memory
   FLASH                             : constant := 4;

   --  RCC global interrupt
   RCC                               : constant := 5;

   --  EXTI Line 0 interrupt
   EXTI0                             : constant := 6;

   --  EXTI Line 1 interrupt
   EXTI1                             : constant := 7;

   --  EXTI Line 2 interrupt
   EXTI2                             : constant := 8;

   --  EXTI Line 3interrupt
   EXTI3                             : constant := 9;

   --  EXTI Line 4interrupt
   EXTI4                             : constant := 10;

   --  DMA1 Stream0
   DMA_STR0                          : constant := 11;

   --  DMA1 Stream1
   DMA_STR1                          : constant := 12;

   --  DMA1 Stream2
   DMA_STR2                          : constant := 13;

   --  DMA1 Stream3
   DMA_STR3                          : constant := 14;

   --  DMA1 Stream4
   DMA_STR4                          : constant := 15;

   --  DMA1 Stream5
   DMA_STR5                          : constant := 16;

   --  DMA1 Stream6
   DMA_STR6                          : constant := 17;

   --  ADC1 and ADC2
   ADC1_2                            : constant := 18;

   --  FDCAN1 Interrupt 0
   FDCAN1_IT0                        : constant := 19;

   --  FDCAN2 Interrupt 0
   FDCAN2_IT0                        : constant := 20;

   --  FDCAN1 Interrupt 1
   FDCAN1_IT1                        : constant := 21;

   --  FDCAN2 Interrupt 1
   FDCAN2_IT1                        : constant := 22;

   --  EXTI Line[9:5] interrupts
   EXTI9_5                           : constant := 23;

   --  TIM1 break interrupt
   TIM1_BRK                          : constant := 24;

   --  TIM1 update interrupt
   TIM1_UP                           : constant := 25;

   --  TIM1 trigger and commutation
   TIM1_TRG_COM                      : constant := 26;

   --  TIM1 capture / compare
   TIM_CC                            : constant := 27;

   --  TIM2 global interrupt
   TIM2                              : constant := 28;

   --  TIM3 global interrupt
   TIM3                              : constant := 29;

   --  TIM4 global interrupt
   TIM4                              : constant := 30;

   --  I2C1 event interrupt
   I2C1_EV                           : constant := 31;

   --  I2C1 error interrupt
   I2C1_ER                           : constant := 32;

   --  I2C2 event interrupt
   I2C2_EV                           : constant := 33;

   --  I2C2 error interrupt
   I2C2_ER                           : constant := 34;

   --  SPI1 global interrupt
   SPI1                              : constant := 35;

   --  SPI2 global interrupt
   SPI2                              : constant := 36;

   --  USART1 global interrupt
   USART1                            : constant := 37;

   --  USART2 global interrupt
   USART2                            : constant := 38;

   --  USART3 global interrupt
   USART3                            : constant := 39;

   --  EXTI Line[15:10] interrupts
   EXTI15_10                         : constant := 40;

   --  RTC alarms (A and B)
   RTC_ALARM                         : constant := 41;

   --  TIM8 and 12 break global
   TIM8_BRK_TIM12                    : constant := 43;

   --  TIM8 and 13 update global
   TIM8_UP_TIM13                     : constant := 44;

   --  TIM8 and 14 trigger /commutation and global
   TIM8_TRG_COM_TIM14                : constant := 45;

   --  TIM8 capture / compare
   TIM8_CC                           : constant := 46;

   --  DMA1 Stream7
   DMA1_STR7                         : constant := 47;

   --  FMC global interrupt
   FMC                               : constant := 48;

   --  SDMMC global interrupt
   SDMMC1                            : constant := 49;

   --  TIM5 global interrupt
   TIM5                              : constant := 50;

   --  SPI3 global interrupt
   SPI3                              : constant := 51;

   --  UART4 global interrupt
   UART4                             : constant := 52;

   --  UART5 global interrupt
   UART5                             : constant := 53;

   --  TIM6 global interrupt
   TIM6_DAC                          : constant := 54;

   --  TIM7 global interrupt
   TIM7                              : constant := 55;

   --  DMA2 Stream0 interrupt
   DMA2_STR0                         : constant := 56;

   --  DMA2 Stream1 interrupt
   DMA2_STR1                         : constant := 57;

   --  DMA2 Stream2 interrupt
   DMA2_STR2                         : constant := 58;

   --  DMA2 Stream3 interrupt
   DMA2_STR3                         : constant := 59;

   --  DMA2 Stream4 interrupt
   DMA2_STR4                         : constant := 60;

   --  Ethernet global interrupt
   ETH                               : constant := 61;

   --  Ethernet wakeup through EXTI
   ETH_WKUP                          : constant := 62;

   --  CAN2TX interrupts
   FDCAN_CAL                         : constant := 63;

   --  DMA2 Stream5 interrupt
   DMA2_STR5                         : constant := 68;

   --  DMA2 Stream6 interrupt
   DMA2_STR6                         : constant := 69;

   --  DMA2 Stream7 interrupt
   DMA2_STR7                         : constant := 70;

   --  USART6 global interrupt
   USART6                            : constant := 71;

   --  I2C3 event interrupt
   I2C3_EV                           : constant := 72;

   --  I2C3 error interrupt
   I2C3_ER                           : constant := 73;

   --  OTG_HS out global interrupt
   OTG_HS_EP1_OUT                    : constant := 74;

   --  OTG_HS in global interrupt
   OTG_HS_EP1_IN                     : constant := 75;

   --  OTG_HS wakeup interrupt
   OTG_HS_WKUP                       : constant := 76;

   --  OTG_HS global interrupt
   OTG_HS                            : constant := 77;

   --  DCMI global interrupt
   DCMI                              : constant := 78;

   --  CRYP global interrupt
   CRYP                              : constant := 79;

   --  HASH and RNG
   HASH_RNG                          : constant := 80;

   --  CPU FPU
   FPU                               : constant := 81;

   --  UART7 global interrupt
   UART7                             : constant := 82;

   --  UART8 global interrupt
   UART8                             : constant := 83;

   --  SPI4 global interrupt
   SPI4                              : constant := 84;

   --  SPI5 global interrupt
   SPI5                              : constant := 85;

   --  SPI6 global interrupt
   SPI6                              : constant := 86;

   --  SAI1 global interrupt
   SAI1                              : constant := 87;

   --  LCD-TFT global interrupt
   LTDC                              : constant := 88;

   --  LCD-TFT error interrupt
   LTDC_ER                           : constant := 89;

   --  DMA2D global interrupt
   DMA2D                             : constant := 90;

   --  SAI2 global interrupt
   SAI2                              : constant := 91;

   --  QuadSPI global interrupt
   QUADSPI                           : constant := 92;

   --  LPTIM1 global interrupt
   LPTIM1                            : constant := 93;

   --  HDMI-CEC global interrupt
   CEC                               : constant := 94;

   --  I2C4 event interrupt
   I2C4_EV                           : constant := 95;

   --  I2C4 error interrupt
   I2C4_ER                           : constant := 96;

   --  SPDIFRX global interrupt
   SPDIF                             : constant := 97;

   --  OTG_FS out global interrupt
   OTG_FS_EP1_OUT                    : constant := 98;

   --  OTG_FS in global interrupt
   OTG_FS_EP1_IN                     : constant := 99;

   --  OTG_FS wakeup
   OTG_FS_WKUP                       : constant := 100;

   --  OTG_FS global interrupt
   OTG_FS                            : constant := 101;

   --  DMAMUX1 overrun interrupt
   DMAMUX1_OV                        : constant := 102;

   --  HRTIM1 master timer interrupt
   HRTIM1_MST                        : constant := 103;

   --  HRTIM1 timer A interrupt
   HRTIM1_TIMA                       : constant := 104;

   --  HRTIM1 timer B interrupt
   HRTIM_TIMB                        : constant := 105;

   --  HRTIM1 timer C interrupt
   HRTIM1_TIMC                       : constant := 106;

   --  HRTIM1 timer D interrupt
   HRTIM1_TIMD                       : constant := 107;

   --  HRTIM1 timer E interrupt
   HRTIM_TIME                        : constant := 108;

   --  HRTIM1 fault interrupt
   HRTIM1_FLT                        : constant := 109;

   --  DFSDM1 filter 0 interrupt
   DFSDM1_FLT0                       : constant := 110;

   --  DFSDM1 filter 1 interrupt
   DFSDM1_FLT1                       : constant := 111;

   --  DFSDM1 filter 2 interrupt
   DFSDM1_FLT2                       : constant := 112;

   --  DFSDM1 filter 3 interrupt
   DFSDM1_FLT3                       : constant := 113;

   --  SAI3 global interrupt
   SAI3                              : constant := 114;

   --  SWPMI global interrupt
   SWPMI1                            : constant := 115;

   --  TIM15 global interrupt
   TIM15                             : constant := 116;

   --  TIM16 global interrupt
   TIM16                             : constant := 117;

   --  TIM17 global interrupt
   TIM17                             : constant := 118;

   --  MDIOS wakeup
   MDIOS_WKUP                        : constant := 119;

   --  MDIOS global interrupt
   MDIOS                             : constant := 120;

   --  JPEG global interrupt
   JPEG                              : constant := 121;

   --  MDMA
   MDMA                              : constant := 122;

   --  SDMMC global interrupt
   SDMMC                             : constant := 124;

   --  HSEM global interrupt 1
   HSEM0                             : constant := 125;

   --  ADC3 global interrupt
   ADC3                              : constant := 127;

   --  DMAMUX2 overrun interrupt
   DMAMUX2_OVR                       : constant := 128;

   --  BDMA channel 1 interrupt
   BDMA_CH1                          : constant := 129;

   --  BDMA channel 2 interrupt
   BDMA_CH2                          : constant := 130;

   --  BDMA channel 3 interrupt
   BDMA_CH3                          : constant := 131;

   --  BDMA channel 4 interrupt
   BDMA_CH4                          : constant := 132;

   --  BDMA channel 5 interrupt
   BDMA_CH5                          : constant := 133;

   --  BDMA channel 6 interrupt
   BDMA_CH6                          : constant := 134;

   --  BDMA channel 7 interrupt
   BDMA_CH7                          : constant := 135;

   --  BDMA channel 8 interrupt
   BDMA_CH8                          : constant := 136;

   --  COMP1 and COMP2
   COMP                              : constant := 137;

   --  LPTIM2 timer interrupt
   LPTIM2                            : constant := 138;

   --  LPTIM2 timer interrupt
   LPTIM3                            : constant := 139;

   --  LPTIM2 timer interrupt
   LPTIM4                            : constant := 140;

   --  LPTIM2 timer interrupt
   LPTIM5                            : constant := 141;

   --  LPUART global interrupt
   LPUART                            : constant := 142;

   --  Window Watchdog interrupt
   WWDG1_RST                         : constant := 143;

   --  Clock Recovery System globa
   CRS                               : constant := 144;

   --  SAI4 global interrupt
   SAI4                              : constant := 146;

   --  WKUP1 to WKUP6 pins
   WKUP                              : constant := 149;

end Ada.Interrupts.Names;
