module mem
    
    use global_mem
    use mem_Param, ONLY: p_atm0

    implicit none
    integer NO_BOXES, BoxNumber
    
    real(RLEN),allocatable,dimension(:) :: O3h, O3c, DIC, ALK,   &
        N1p,N5s,CO2, HCO3, CO3, pCO2, pH, ETW, ESW, ERHO, &
        OCalc, OArag, EPR, ffCO2
    real(RLEN),allocatable,dimension(:) :: patm3d
                  
contains

subroutine mem_init

    NO_BOXES=2

    allocate(patm3d(NO_BOXES))
    patm3d = p_atm0
    
    allocate(O3h(NO_BOXES))
    allocate(O3c(NO_BOXES))
    allocate(DIC(NO_BOXES))
    allocate(ALK(NO_BOXES))
    allocate(N1p(NO_BOXES))
    allocate(N5s(NO_BOXES))
    allocate(CO2(NO_BOXES))
    allocate(HCO3(NO_BOXES))
    allocate(CO3(NO_BOXES))
    allocate(pCO2(NO_BOXES))
    allocate(pH(NO_BOXES))
    allocate(ETW(NO_BOXES))
    allocate(ESW(NO_BOXES))
    allocate(ERHO(NO_BOXES))
    allocate(OCalc(NO_BOXES))
    allocate(OArag(NO_BOXES))
    allocate(EPR(NO_BOXES))
    allocate(ffCO2(NO_BOXES))
    
    ESW=35
    ETW=25
    ERHO=1
    EPR=0
    N1p=0
    N5s=0
    pH=7

end subroutine

end module
