#include "cppdefs.h"
#include "DEBUG.h"

!-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
! MODEL  BFM - Biogeochemical Flux Model 
!-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
!BOP
!
! !ROUTINE: PelCO2Dynamics
!
! DESCRIPTION
!   !
!
! !INTERFACE
  program main
!
! !USES:

  use global_mem, ONLY: RLEN
  use constants,  ONLY: MW_C
  use mem, ONLY: O3h, O3c,     &
                 DIC, ALK,                     &
                 NO_BOXES, BoxNumber,   &
                  N1p,N5s,CO2, HCO3, CO3, pCO2, pH, ETW, ESW, ERHO, &
                  OCalc, OArag, EPR, ffCO2, patm3d, &
                  mem_init
  use mem_CSYS, ONLY : CarbonateSystem
  IMPLICIT NONE

!  
!
! !AUTHORS
!  T. Lovato 
!
! !REVISION_HISTORY
!
! !LOCAL VARIABLES:
  integer            :: error=0
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
!
  write(*,*) "initialization"
  call mem_init
  
  write(*,*) "Computation start"
  !
  !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  ! Compute carbonate system equilibria
  !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  ! To use the Pressure correction of CSYS here the pr_in=EPS value
    do BoxNumber=1,NO_BOXES
       ! convert DIC and alkalinity from model units to diagnostic output
       ! mg C/m3 --> umol/kg
       ! mmol eq/m3 --> umol/kg
       DIC(BoxNumber) = O3c(BoxNumber)/MW_C/ERHO(BoxNumber)*1000.0_RLEN
       ALK(BoxNumber) = O3h(BoxNumber)/ERHO(BoxNumber)*1000.0_RLEN

       error= CarbonateSystem( ESW(BoxNumber), ETW(BoxNumber),ERHO(BoxNumber), &
               N1p(BoxNumber), N5s(BoxNumber), DIC(BoxNumber), ALK(BoxNumber), &
               CO2(BoxNumber) ,HCO3(BoxNumber), CO3(BoxNumber), pH(BoxNumber), &
               pCO2(BoxNumber), patm=patm3d(BoxNumber), pr_in=EPR(BoxNumber), &
               OmegaC=OCalc(BoxNumber), OmegaA=OArag(BoxNumber),fCO2=ffCO2(BoxNumber))

       if ( error > 0 ) then
              write(*,*) "error in computation at index ", BoxNumber, ', ph = ', pH(BoxNumber)
       endif
    end do
    write(*,*) "Computation end"
    
#ifdef DEBUG
    do BoxNumber=1,NO_BOXES
       write(*,*) "outputs at index ", BoxNumber, ":"
       write(*,'(A,'' ='',f12.6)') 'ERHO',ERHO(BoxNumber)
       write(*,'(A,'' ='',f12.6)') 'ESW',ESW(BoxNumber)
       write(*,'(A,'' ='',f12.6)') 'N1p',N1p(BoxNumber)
       write(*,'(A,'' ='',f12.6)') 'N5s',N5s(BoxNumber)
       write(*,'(A,'' ='',f12.6)') 'DIC',DIC(BoxNumber)
       write(*,'(A,'' ='',f12.6)') 'ALK',ALK(BoxNumber)
       write(*,'(A,'' ='',f12.6)') 'OCalc',OCalc(BoxNumber)
       write(*,'(A,'' ='',f12.6)') 'OArag',OArag(BoxNumber)
       write(*,'(A,'' ='',f12.6)') 'ffCO2',  ffCO2(BoxNumber)
       write(*,'(A,'' ='',f12.6)') 'pH', pH(BoxNumber)
       write(*,*) ""
    end do
#endif

  end program


