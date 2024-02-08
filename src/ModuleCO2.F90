#include "cppdefs.h"

!-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
! MODEL  BFM - Biogeochemical Flux Model 
!-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
!BOP
!
! !ROUTINE: ModulePelCO2
!
! DESCRIPTION
! Module to simulate the Carbonate system dynamics in Pelagic compartment
!
! !INTERFACE
  module mem_CO2
!
! !USES:
  use global_mem
!   use SystemForcing, only :ForcingName, ForcingField, FieldInit, FieldClose
  IMPLICIT NONE
!  
!
! !AUTHORS
!   T. Lovato (CMCC) 2017
!
! !REVISION_HISTORY
!
! COPYING
!   
!   Copyright (C) 2020 BFM System Team (bfm_st@cmcc.it)
!
!   This program is free software; you can redistribute it and/or modify
!   it under the terms of the GNU General Public License as published by
!   the Free Software Foundation;
!   This program is distributed in the hope that it will be useful,
!   but WITHOUT ANY WARRANTY; without even the implied warranty of
!   MERCHANTEABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!   GNU General Public License for more details.
!
!EOP
!-------------------------------------------------------------------------!
!BOC

  !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  ! Default all is public
  !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  public
  !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  !NAMELIST PelCO2_parameters
  !-------------------------------------------------------------------------!
  ! CARBONATE SYSYEM SETTING
  ! NAME            [UNIT]/KIND             DESCRIPTION
  ! AtmCO20         [ppmv]           Initial atmospheric concentration of CO2
  ! calcAtmpCO2     logical          Compute the partial pressure of Atmospheric CO2
  ! CalcBioAlk      logical          Compute biological processes corrections on total alkalinity
  ! CO2fluxfac      real             Multipling factor for CO2 flux to accelerate air-sea exchange
  !              ---------  SolveSAPHE parameters  -----------
  ! MaxIterPHsolver integer          Maximum number of iterations (default 50)
  !              ---------  Parameters for calcium and calcite ---------
  ! p_kdca          [d-1]            Calcite dissolution rate constant
  ! p_nomega        [-]              Order of the dissolution rate dependence on Omega
  !              ---------  EXTERNAL DATA INPUT STRUCTURES -----------
  ! AtmCO2_N       structure        Read external data for atmospheric CO2 values
  ! AtmSLP_N       structure        Read external data for atmospheric sea level pressure
  ! Example of general input structure for the data structure:
  !          ! Read  !   File                               ! NetCDF  !  Var    !
  !          ! Input !   name                               ! Logical !  name   !
  !AtmCO2_N  =    0  , 'CMIP5_Historical_GHG_1765_2005.dat' , .FALSE.  , 'CO2'  ,
  !          !  RefTime          ! Input      !   Time   !
  !          !  yyyymmdd         ! Frequency  !  interp  !
  !           '1764-07-01 00:00' ,  'yearly'  ,  .TRUE.
  !
  ! Convention for Input reading : 0 = use constant value (default if struct is not initialized)
  !                                1 = read timeseries file ( e.g. CO2 mixing ratios)
  !                                2 = read 2D fields using NEMO fldread 
  ! NOTE: The file "CMIP5_Historical_GHG_1765_2005.dat" is located in "$BFMDIR/tools" folder
  !-----------------------------------------------------------------------------------!
   real(RLEN)           :: AtmCO20 = 365.0_RLEN ! ppm 
   integer              :: MaxIterPHsolver = 50
   real(RLEN)           :: p_kdca
   integer              :: p_nomega
   logical              :: CalcBioAlk = .FALSE.
   real(RLEN)           :: Co2fluxfac = 1.0_RLEN
!    type(ForcingName)    :: AtmCO2_N, AtmSLP_N
!    type(ForcingField)   :: AtmCO2, AtmSLP
   ! ancillary
   real(RLEN),allocatable,dimension(:) :: patm3d ! atm. pressure over NO_BOXES
  !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  ! SHARED PUBLIC FUNCTIONS (must be explicited below "contains")

  

  !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  end module mem_CO2

