! This file is part of xtb.
! SPDX-Identifier: LGPL-3.0-or-later
!
! xtb is free software: you can redistribute it and/or modify it under
! the terms of the GNU Lesser General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! xtb is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU Lesser General Public License for more details.
!
! You should have received a copy of the GNU Lesser General Public License
! along with xtb.  If not, see <https://www.gnu.org/licenses/>.

module test_dftd3
   use testdrive, only : new_unittest, unittest_type, error_type, check, test_failed
   implicit none
   private

   public :: collect_dftd3

contains

!> Collect all exported unit tests
subroutine collect_dftd3(testsuite)
   !> Collection of tests
   type(unittest_type), allocatable, intent(out) :: testsuite(:)

   testsuite = [ &
      new_unittest("2b-nl-pbc3d", test_dftd3_pbc3d_neighbourlist), &
      new_unittest("2b-lp-pbc3d", test_dftd3_pbc3d_latticepoints), &
      new_unittest("3b-nl-pbc3d", test_dftd3_pbc3d_threebody_neighs), &
      new_unittest("3b-lp-pbc3d", test_dftd3_pbc3d_threebody_latp) &
      ]

end subroutine collect_dftd3


subroutine test_dftd3_pbc3d_neighbourlist(error)
   use xtb_mctc_accuracy, only : wp

   use xtb_mctc_convert, only : aatoau

   use xtb_type_environment, only : TEnvironment, init
   use xtb_type_molecule, only : TMolecule, init, len
   use xtb_type_neighbourlist, only : TNeighbourList, init
   use xtb_type_latticepoint, only : TLatticePoint, init
   use xtb_type_param, only : dftd_parameter

   use xtb_disp_coordinationnumber, only : getCoordinationNumber, cnType
!   use xtb_disp_dftd3, only : d3_gradient
   use xtb_disp_dftd3param, only : copy_c6, reference_c6

   type(error_type), allocatable, intent(out) :: error

   real(wp),parameter :: thr = 1.0e-10_wp
   integer, parameter :: nat = 32
   integer, parameter :: at(nat) = [8, 8, 8, 8, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, &
      & 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
   real(wp),parameter :: xyz(3,nat) = reshape(&
      &[4.5853168464880421_wp,  4.9392326929575878_wp,  4.1894081210748118_wp,  &
      & 5.8862267152491423_wp,  1.1425258978245871_wp,  6.5015058204768126_wp,  &
      & 1.4284279616220412_wp,  4.6017511285540875_wp,  3.1465884436348119_wp,  &
      & 2.3323404704521411_wp,  1.4471801154820869_wp,  0.7121932185858125_wp,  &
      & 4.7333543155561415_wp,  2.7747291872305868_wp,  3.1951352976178122_wp,  &
      & 5.6617754419101418_wp,  2.2133191164485870_wp,  2.1235404838618126_wp,  &
      & 5.3107598618381422_wp,  2.6902988056185868_wp,  0.7384466319968125_wp,  &
      & 4.4947071071761426_wp,  3.9530790692635867_wp,  0.6801776747598124_wp,  &
      & 4.8005171923760424_wp,  4.9185102874975870_wp,  1.8186363449528122_wp,  &
      & 4.6951362687070421_wp,  4.2781752812835867_wp,  3.1816411821728123_wp,  &
      & 1.3838574419160412_wp,  5.2817805008910863_wp,  4.1482702947948136_wp,  &
      & 1.0268974195990415_wp,  4.7234752637800881_wp,  5.4989995400388123_wp,  &
      & 2.0852659694760409_wp,  5.0956317453800875_wp,  6.5351699846458127_wp,  &
      & 2.3344644666691412_wp, -0.0736561690909131_wp,  6.4245628001158135_wp,  &
      & 2.4894017448231409_wp,  0.6213510313930869_wp,  5.0967297417158131_wp,  &
      & 1.5745272273791413_wp,  0.1243470825760870_wp,  3.9731040773988129_wp,  &
      & 5.8221065925130420_wp,  5.3013563342055878_wp,  1.7264876737078123_wp,  &
      & 3.4487807319551416_wp,  3.6355832152975864_wp,  0.7429568016758125_wp,  &
      & 4.8499393376520423_wp,  3.4713855169305874_wp,  6.4691872586348129_wp,  &
      & 0.2495364434351412_wp,  2.4795455690160870_wp,  2.1043557230378123_wp,  &
      & 5.6691068338331423_wp,  1.1234174220755870_wp,  2.1414388326468128_wp,  &
      & 3.7072009289431418_wp,  2.4357632918535872_wp,  3.0094700999208119_wp,  &
      & 4.1414520030430415_wp,  5.7877262477775879_wp,  1.7803680119358125_wp,  &
      & 5.0142851411171421_wp,  2.4165926460955873_wp,  4.1857610486448129_wp,  &
      & 3.0280930003030413_wp,  4.6201081184690871_wp,  6.2533190952188136_wp,  &
      & 0.5863628696651412_wp,  0.5757236365910867_wp,  4.1021714214668128_wp,  &
      & 2.3776130524831411_wp,  1.6969724987740866_wp,  5.2327688986668139_wp,  &
      & 1.9486148363011413_wp,  0.4390675147070869_wp,  2.9999022491838123_wp,  &
      & 3.5312997625581413_wp,  0.4467415528495868_wp,  4.8114121395028135_wp,  &
      & 6.5089895990100421_wp,  5.2100409408535882_wp,  6.0066553789008132_wp,  &
      & 0.9001165013630412_wp,  3.6420787128610868_wp,  5.4413106648508132_wp,  &
      & 1.6012116650460413_wp,  5.6845471271780879_wp,  0.7675566847298124_wp], &
      & shape(xyz)) * aatoau
   real(wp),parameter :: lattice(3,3) = reshape(&
      &[6.4411018522600_wp,    0.0492571261505_wp,    0.2192046129910_wp,  &
      & 0.0462076831749_wp,    6.6435057067500_wp,    0.1670513770770_wp,  &
      & 0.2262248220170_wp,   -0.9573234940220_wp,    6.7608039126200_wp], &
      & shape(lattice)) * aatoau
   type(dftd_parameter),parameter :: dparam_pbe = dftd_parameter ( &
      & s6=1.0_wp, s8=0.95948085_wp, a1=0.38574991_wp, a2=4.80688534_wp, s9=0.0_wp)

   type(TMolecule) :: mol
   type(TEnvironment) :: env
   type(TLatticePoint) :: latp
   type(TNeighbourlist) :: neighList

   integer, allocatable :: neighs(:)
   real(wp), allocatable :: trans(:, :)

   integer :: ii, jj
   real(wp) :: er, el, eps(3, 3)
   real(wp), parameter :: step = 1.0e-5_wp, step2 = 0.5_wp/step
   real(wp), parameter :: unity(3, 3) = reshape(&
      & [1.0_wp, 0.0_wp, 0.0_wp, 0.0_wp, 1.0_wp, 0.0_wp, 0.0_wp, 0.0_wp, 1.0_wp], &
      & [3, 3])
   real(wp) :: energy, sigma(3, 3), sdum(3, 3)
   real(wp), allocatable :: gradient(:, :), gdum(:, :)
   real(wp), allocatable :: cn(:), dcndr(:, :, :), dcndL(:, :, :)

   call init(env)

   call init(mol, at, xyz, lattice=lattice)

   if (.not.allocated(reference_c6)) call copy_c6(reference_c6)
   allocate(neighs(nat))
   allocate(cn(nat), dcndr(3, nat, nat), dcndL(3, 3, nat))
   allocate(gradient(3, nat), gdum(3, nat))

   energy = 0.0_wp
   gradient(:, :) = 0.0_wp
   sigma(:, :) = 0.0_wp

   call init(latp, env, mol, 60.0_wp)  ! Fixed cutoff
   call latp%getLatticePoints(trans, 60.0_wp)
   call init(neighList, len(mol))
   call neighList%generate(env, mol%xyz, 60.0_wp, trans, .false.)

   call neighlist%getNeighs(neighs, 40.0_wp)
   call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
      & cn, dcndr, dcndL)
   call neighlist%getNeighs(neighs, 60.0_wp)
!   call d3_gradient(mol, neighs, neighList, dparam_pbe, 4.0_wp, &
!      & cn, dcndr, dcndL, energy, gradient, sigma)

   call check(error, energy, -0.70956131647955E-01_wp, thr=thr)
   call check(error, norm2(gradient), 0.80967207004742E-03_wp, thr=thr)

   call check(error, gradient(1, 3), -0.36750795547191E-04_wp, thr=thr)
   call check(error, gradient(2, 7),  0.97188478756351E-04_wp, thr=thr)
   call check(error, gradient(3,12), -0.46581766272258E-04_wp, thr=thr)

   call check(error, sigma(1,1),  0.75334721374086E-01_wp, thr=thr)
   call check(error, sigma(2,1), -0.62270444669135E-05_wp, thr=thr)
   call check(error, sigma(3,2),  0.23549303643349E-03_wp, thr=thr)

   ! check numerical gradient
   ! reduce the number of numerical gradient evaluations significantly
   do ii = 1, 2
      do jj = ii, 3, 2
         er = 0.0_wp
         el = 0.0_wp
         mol%xyz(jj, ii) = mol%xyz(jj, ii) + step
         call mol%update
         call neighList%update(mol%xyz, trans)
         call neighlist%getNeighs(neighs, 40.0_wp)
         call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
            & cn, dcndr, dcndL)
         call neighlist%getNeighs(neighs, 60.0_wp)
!         call d3_gradient(mol, neighs, neighlist, dparam_pbe, 4.0_wp, &
!            & cn, dcndr, dcndL, er, gdum, sdum)
         mol%xyz(jj, ii) = mol%xyz(jj, ii) - 2*step

         call mol%update
         call neighList%update(mol%xyz, trans)
         call neighlist%getNeighs(neighs, 40.0_wp)
         call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
            & cn, dcndr, dcndL)
         call neighlist%getNeighs(neighs, 60.0_wp)
!         call d3_gradient(mol, neighs, neighlist, dparam_pbe, 4.0_wp, &
!            & cn, dcndr, dcndL, el, gdum, sdum)

         mol%xyz(jj, ii) = mol%xyz(jj, ii) + step
         call check(error, gradient(jj, ii), (er - el)*step2, thr=thr)
      end do
   end do

!   ! check numerical strain derivatives
!   trans2 = trans
!   eps = unity
!   do ii = 1, 3
!      do jj = 1, ii
!         eps(jj, ii) = eps(jj, ii) + step
!         mol%lattice(:, :) = matmul(eps, lattice)
!         mol%xyz(:, :) = matmul(eps, xyz)
!         trans(:, :) = matmul(eps, trans2)
!         call mol%update
!         !call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
!            !& cn, dcndr, dcndL)
!         call d3_atm_gradient(mol, neighs, neighlist, dparam_pbe, 4.0_wp, &
!            & cn, dcndr, dcndL, er, gdum, sdum)
!
!         eps(jj, ii) = eps(jj, ii) - 2*step
!         mol%lattice(:, :) = matmul(eps, lattice)
!         mol%xyz(:, :) = matmul(eps, xyz)
!         trans(:, :) = matmul(eps, trans2)
!         call mol%update
!         call neighList%update(mol%xyz, trans)
!         !call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
!            !& cn, dcndr, dcndL)
!         call d3_atm_gradient(mol, neighs, neighlist, dparam_pbe, 4.0_wp, &
!            & cn, dcndr, dcndL, el, gdum, sdum)
!
!         eps(jj, ii) = eps(jj, ii) + step
!
!         call check(error, sigma(jj, ii), (er - el)*step2, thr=thr)
!      end do
!   end do

end subroutine test_dftd3_pbc3d_neighbourlist


subroutine test_dftd3_pbc3d_latticepoints(error)
   use xtb_mctc_accuracy, only : wp

   use xtb_mctc_convert, only : aatoau

   use xtb_type_environment, only : TEnvironment, init
   use xtb_type_molecule, only : TMolecule, init, len
   use xtb_type_neighbourlist, only : TNeighbourList, init
   use xtb_type_latticepoint, only : TLatticePoint, init
   use xtb_type_wignerseitzcell, only : TWignerSeitzCell, init
   use xtb_type_param, only : dftd_parameter

   use xtb_disp_coordinationnumber, only : getCoordinationNumber, cnType
!   use xtb_disp_dftd3, only : d3_gradient
   use xtb_disp_dftd3param, only : copy_c6, reference_c6

   type(error_type), allocatable, intent(out) :: error

   real(wp),parameter :: thr = 1.0e-10_wp
   real(wp),parameter :: thr2 = 1.0e-9_wp
   integer, parameter :: nat = 32
   integer, parameter :: at(nat) = [8, 8, 8, 8, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, &
      & 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
   real(wp),parameter :: xyz(3,nat) = reshape(&
      &[4.5853168464880421_wp,  4.9392326929575878_wp,  4.1894081210748118_wp,  &
      & 5.8862267152491423_wp,  1.1425258978245871_wp,  6.5015058204768126_wp,  &
      & 1.4284279616220412_wp,  4.6017511285540875_wp,  3.1465884436348119_wp,  &
      & 2.3323404704521411_wp,  1.4471801154820869_wp,  0.7121932185858125_wp,  &
      & 4.7333543155561415_wp,  2.7747291872305868_wp,  3.1951352976178122_wp,  &
      & 5.6617754419101418_wp,  2.2133191164485870_wp,  2.1235404838618126_wp,  &
      & 5.3107598618381422_wp,  2.6902988056185868_wp,  0.7384466319968125_wp,  &
      & 4.4947071071761426_wp,  3.9530790692635867_wp,  0.6801776747598124_wp,  &
      & 4.8005171923760424_wp,  4.9185102874975870_wp,  1.8186363449528122_wp,  &
      & 4.6951362687070421_wp,  4.2781752812835867_wp,  3.1816411821728123_wp,  &
      & 1.3838574419160412_wp,  5.2817805008910863_wp,  4.1482702947948136_wp,  &
      & 1.0268974195990415_wp,  4.7234752637800881_wp,  5.4989995400388123_wp,  &
      & 2.0852659694760409_wp,  5.0956317453800875_wp,  6.5351699846458127_wp,  &
      & 2.3344644666691412_wp, -0.0736561690909131_wp,  6.4245628001158135_wp,  &
      & 2.4894017448231409_wp,  0.6213510313930869_wp,  5.0967297417158131_wp,  &
      & 1.5745272273791413_wp,  0.1243470825760870_wp,  3.9731040773988129_wp,  &
      & 5.8221065925130420_wp,  5.3013563342055878_wp,  1.7264876737078123_wp,  &
      & 3.4487807319551416_wp,  3.6355832152975864_wp,  0.7429568016758125_wp,  &
      & 4.8499393376520423_wp,  3.4713855169305874_wp,  6.4691872586348129_wp,  &
      & 0.2495364434351412_wp,  2.4795455690160870_wp,  2.1043557230378123_wp,  &
      & 5.6691068338331423_wp,  1.1234174220755870_wp,  2.1414388326468128_wp,  &
      & 3.7072009289431418_wp,  2.4357632918535872_wp,  3.0094700999208119_wp,  &
      & 4.1414520030430415_wp,  5.7877262477775879_wp,  1.7803680119358125_wp,  &
      & 5.0142851411171421_wp,  2.4165926460955873_wp,  4.1857610486448129_wp,  &
      & 3.0280930003030413_wp,  4.6201081184690871_wp,  6.2533190952188136_wp,  &
      & 0.5863628696651412_wp,  0.5757236365910867_wp,  4.1021714214668128_wp,  &
      & 2.3776130524831411_wp,  1.6969724987740866_wp,  5.2327688986668139_wp,  &
      & 1.9486148363011413_wp,  0.4390675147070869_wp,  2.9999022491838123_wp,  &
      & 3.5312997625581413_wp,  0.4467415528495868_wp,  4.8114121395028135_wp,  &
      & 6.5089895990100421_wp,  5.2100409408535882_wp,  6.0066553789008132_wp,  &
      & 0.9001165013630412_wp,  3.6420787128610868_wp,  5.4413106648508132_wp,  &
      & 1.6012116650460413_wp,  5.6845471271780879_wp,  0.7675566847298124_wp], &
      & shape(xyz)) * aatoau
   real(wp),parameter :: lattice(3,3) = reshape(&
      &[6.4411018522600_wp,    0.0492571261505_wp,    0.2192046129910_wp,  &
      & 0.0462076831749_wp,    6.6435057067500_wp,    0.1670513770770_wp,  &
      & 0.2262248220170_wp,   -0.9573234940220_wp,    6.7608039126200_wp], &
      & shape(lattice)) * aatoau
   type(dftd_parameter),parameter :: dparam_pbe = dftd_parameter ( &
      & s6=1.0_wp, s8=0.95948085_wp, a1=0.38574991_wp, a2=4.80688534_wp, s9=0.0_wp)

   type(TMolecule) :: mol
   type(TEnvironment) :: env
   type(TLatticePoint) :: latp
   type(TNeighbourlist) :: neighList

   integer, allocatable :: neighs(:)
   real(wp), allocatable :: trans(:, :), trans2(:, :)

   integer :: ii, jj
   real(wp) :: er, el, eps(3, 3)
   real(wp), parameter :: step = 1.0e-5_wp, step2 = 0.5_wp/step
   real(wp), parameter :: unity(3, 3) = reshape(&
      & [1.0_wp, 0.0_wp, 0.0_wp, 0.0_wp, 1.0_wp, 0.0_wp, 0.0_wp, 0.0_wp, 1.0_wp], &
      & [3, 3])
   real(wp) :: energy, sigma(3, 3), sdum(3, 3)
   real(wp), allocatable :: gradient(:, :), gdum(:, :)
   real(wp), allocatable :: cn(:), dcndr(:, :, :), dcndL(:, :, :)

   call init(env)

   call init(mol, at, xyz, lattice=lattice)

   if (.not.allocated(reference_c6)) call copy_c6(reference_c6)
   allocate(neighs(nat))
   allocate(cn(nat), dcndr(3, nat, nat), dcndL(3, 3, nat))
   allocate(gradient(3, nat), gdum(3, nat))

   energy = 0.0_wp
   gradient(:, :) = 0.0_wp
   sigma(:, :) = 0.0_wp

!   cn(:) = 0.0_wp
!   dcndr(:, :, :) = 0.0_wp
!   dcndL(:, :, :) = 0.0_wp

   call init(latp, env, mol, 60.0_wp)  ! Fixed cutoff
   call latp%getLatticePoints(trans, 40.0_wp)
   call init(neighList, len(mol))
   call neighList%generate(env, mol%xyz, 40.0_wp, trans, .false.)

   call neighlist%getNeighs(neighs, 40.0_wp)
   call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
      & cn, dcndr, dcndL)
   call latp%getLatticePoints(trans, 60.0_wp)
!   call d3_gradient(mol, trans, dparam_pbe, 4.0_wp, 60.0_wp, &
!      & cn, dcndr, dcndL, energy, gradient, sigma)

   call check(error, energy, -0.70957467834973E-01_wp, thr=thr)
   call check(error, norm2(gradient), 0.80953440515160E-03_wp, thr=thr)

   call check(error, gradient(1, 3), -0.36750229627472E-04_wp, thr=thr)
   call check(error, gradient(2, 7),  0.97133121226048E-04_wp, thr=thr)
   call check(error, gradient(3,12), -0.46580608745602E-04_wp, thr=thr)

   call check(error, sigma(1,1),  0.75336316933972E-01_wp, thr=thr)
   call check(error, sigma(2,1), -0.61981535450274E-05_wp, thr=thr)
   call check(error, sigma(3,2),  0.23588761667468E-03_wp, thr=thr)

   ! check numerical gradient
   do ii = 1, nat, 9
      do jj = 1, 3
         er = 0.0_wp
         el = 0.0_wp
         mol%xyz(jj, ii) = mol%xyz(jj, ii) + step
         call mol%update
         call neighList%update(mol%xyz, trans)
         call neighlist%getNeighs(neighs, 40.0_wp)
         call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
            & cn, dcndr, dcndL)
!         call d3_gradient(mol, trans, dparam_pbe, 4.0_wp, 60.0_wp, &
!            & cn, dcndr, dcndL, er, gdum, sdum)
         mol%xyz(jj, ii) = mol%xyz(jj, ii) - 2*step

         call mol%update
         call neighList%update(mol%xyz, trans)
         call neighlist%getNeighs(neighs, 40.0_wp)
         call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
            & cn, dcndr, dcndL)
!         call d3_gradient(mol, trans, dparam_pbe, 4.0_wp, 60.0_wp, &
!            & cn, dcndr, dcndL, el, gdum, sdum)

         mol%xyz(jj, ii) = mol%xyz(jj, ii) + step
         call check(error, gradient(jj, ii), (er - el)*step2, thr=thr2)
      end do
   end do

!   ! check numerical strain derivatives
!   trans2 = trans
!   eps = unity
!   do ii = 1, 3
!      do jj = 1, ii
!         er = 0.0_wp
!         el = 0.0_wp
!         eps(jj, ii) = eps(jj, ii) + step
!         mol%lattice(:, :) = matmul(eps, lattice)
!         mol%xyz(:, :) = matmul(eps, xyz)
!         trans(:, :) = matmul(eps, trans2)
!         call mol%update
!         call neighList%update(mol%xyz, trans)
!         call neighlist%getNeighs(neighs, 40.0_wp)
!         call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
!            & cn, dcndr, dcndL)
!         call d3_gradient(mol, trans, dparam_pbe, 4.0_wp, 60.0_wp, &
!            & cn, dcndr, dcndL, er, gdum, sdum)
!
!         eps(jj, ii) = eps(jj, ii) - 2*step
!         mol%lattice(:, :) = matmul(eps, lattice)
!         mol%xyz(:, :) = matmul(eps, xyz)
!         trans(:, :) = matmul(eps, trans2)
!         call mol%update
!         call neighList%update(mol%xyz, trans)
!         call neighlist%getNeighs(neighs, 40.0_wp)
!         call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
!            & cn, dcndr, dcndL)
!         call d3_gradient(mol, trans, dparam_pbe, 4.0_wp, 60.0_wp, &
!            & cn, dcndr, dcndL, el, gdum, sdum)
!
!         eps(jj, ii) = eps(jj, ii) + step
!
!         call check(error, sigma(jj, ii), (er - el)*step2, thr=thr2)
!      end do
!   end do

end subroutine test_dftd3_pbc3d_latticepoints


subroutine test_dftd3_pbc3d_threebody_neighs(error)
   use xtb_mctc_accuracy, only : wp

   use xtb_mctc_convert, only : aatoau

   use xtb_type_environment, only : TEnvironment, init
   use xtb_type_molecule, only : TMolecule, init, len
   use xtb_type_neighbourlist, only : TNeighbourList, init
   use xtb_type_latticepoint, only : TLatticePoint, init
   use xtb_type_wignerseitzcell, only : TWignerSeitzCell, init
   use xtb_type_param, only : dftd_parameter

   use xtb_disp_coordinationnumber, only : getCoordinationNumber, cnType
!   use xtb_disp_dftd3, only : d3_atm_gradient
   use xtb_disp_dftd3param, only : copy_c6, reference_c6

   type(error_type), allocatable, intent(out) :: error

   real(wp),parameter :: thr = 1.0e-10_wp
   integer, parameter :: nat = 32
   integer, parameter :: at(nat) = [8, 8, 8, 8, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, &
      & 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
   real(wp),parameter :: xyz(3,nat) = reshape(&
      &[4.5853168464880421_wp,  4.9392326929575878_wp,  4.1894081210748118_wp,  &
      & 5.8862267152491423_wp,  1.1425258978245871_wp,  6.5015058204768126_wp,  &
      & 1.4284279616220412_wp,  4.6017511285540875_wp,  3.1465884436348119_wp,  &
      & 2.3323404704521411_wp,  1.4471801154820869_wp,  0.7121932185858125_wp,  &
      & 4.7333543155561415_wp,  2.7747291872305868_wp,  3.1951352976178122_wp,  &
      & 5.6617754419101418_wp,  2.2133191164485870_wp,  2.1235404838618126_wp,  &
      & 5.3107598618381422_wp,  2.6902988056185868_wp,  0.7384466319968125_wp,  &
      & 4.4947071071761426_wp,  3.9530790692635867_wp,  0.6801776747598124_wp,  &
      & 4.8005171923760424_wp,  4.9185102874975870_wp,  1.8186363449528122_wp,  &
      & 4.6951362687070421_wp,  4.2781752812835867_wp,  3.1816411821728123_wp,  &
      & 1.3838574419160412_wp,  5.2817805008910863_wp,  4.1482702947948136_wp,  &
      & 1.0268974195990415_wp,  4.7234752637800881_wp,  5.4989995400388123_wp,  &
      & 2.0852659694760409_wp,  5.0956317453800875_wp,  6.5351699846458127_wp,  &
      & 2.3344644666691412_wp, -0.0736561690909131_wp,  6.4245628001158135_wp,  &
      & 2.4894017448231409_wp,  0.6213510313930869_wp,  5.0967297417158131_wp,  &
      & 1.5745272273791413_wp,  0.1243470825760870_wp,  3.9731040773988129_wp,  &
      & 5.8221065925130420_wp,  5.3013563342055878_wp,  1.7264876737078123_wp,  &
      & 3.4487807319551416_wp,  3.6355832152975864_wp,  0.7429568016758125_wp,  &
      & 4.8499393376520423_wp,  3.4713855169305874_wp,  6.4691872586348129_wp,  &
      & 0.2495364434351412_wp,  2.4795455690160870_wp,  2.1043557230378123_wp,  &
      & 5.6691068338331423_wp,  1.1234174220755870_wp,  2.1414388326468128_wp,  &
      & 3.7072009289431418_wp,  2.4357632918535872_wp,  3.0094700999208119_wp,  &
      & 4.1414520030430415_wp,  5.7877262477775879_wp,  1.7803680119358125_wp,  &
      & 5.0142851411171421_wp,  2.4165926460955873_wp,  4.1857610486448129_wp,  &
      & 3.0280930003030413_wp,  4.6201081184690871_wp,  6.2533190952188136_wp,  &
      & 0.5863628696651412_wp,  0.5757236365910867_wp,  4.1021714214668128_wp,  &
      & 2.3776130524831411_wp,  1.6969724987740866_wp,  5.2327688986668139_wp,  &
      & 1.9486148363011413_wp,  0.4390675147070869_wp,  2.9999022491838123_wp,  &
      & 3.5312997625581413_wp,  0.4467415528495868_wp,  4.8114121395028135_wp,  &
      & 6.5089895990100421_wp,  5.2100409408535882_wp,  6.0066553789008132_wp,  &
      & 0.9001165013630412_wp,  3.6420787128610868_wp,  5.4413106648508132_wp,  &
      & 1.6012116650460413_wp,  5.6845471271780879_wp,  0.7675566847298124_wp], &
      & shape(xyz)) * aatoau
   real(wp),parameter :: lattice(3,3) = reshape(&
      &[6.4411018522600_wp,    0.0492571261505_wp,    0.2192046129910_wp,  &
      & 0.0462076831749_wp,    6.6435057067500_wp,    0.1670513770770_wp,  &
      & 0.2262248220170_wp,   -0.9573234940220_wp,    6.7608039126200_wp], &
      & shape(lattice)) * aatoau
   type(dftd_parameter),parameter :: dparam_pbe = dftd_parameter ( &
      & s6=1.0_wp, s8=0.95948085_wp, a1=0.38574991_wp, a2=4.80688534_wp, s9=1.0_wp)

   type(TMolecule) :: mol
   type(TEnvironment) :: env
   type(TLatticePoint) :: latp
   type(TNeighbourlist) :: neighList

   integer, allocatable :: neighs(:)
   real(wp), allocatable :: trans(:, :), trans2(:, :)

   integer :: ii, jj
   real(wp) :: er, el, eps(3, 3)
   real(wp), parameter :: step = 1.0e-5_wp, step2 = 0.5_wp/step
   real(wp), parameter :: unity(3, 3) = reshape(&
      & [1.0_wp, 0.0_wp, 0.0_wp, 0.0_wp, 1.0_wp, 0.0_wp, 0.0_wp, 0.0_wp, 1.0_wp], &
      & [3, 3])
   real(wp) :: energy, sigma(3, 3), sdum(3, 3)
   real(wp), allocatable :: gradient(:, :), gdum(:, :)
   real(wp), allocatable :: cn(:), dcndr(:, :, :), dcndL(:, :, :)

   call init(env)

   call init(mol, at, xyz)

   if (.not.allocated(reference_c6)) call copy_c6(reference_c6)
   allocate(neighs(nat))
   allocate(cn(nat), dcndr(3, nat, nat), dcndL(3, 3, nat))
   allocate(gradient(3, nat), gdum(3, nat))

   energy = 0.0_wp
   gradient(:, :) = 0.0_wp
   sigma(:, :) = 0.0_wp

   call init(latp, env, mol, 15.0_wp)  ! Fixed cutoff
   call latp%getLatticePoints(trans, 15.0_wp)
   call init(neighList, len(mol))
   call neighList%generate(env, mol%xyz, 15.0_wp, trans, .false.)

   call neighlist%getNeighs(neighs, 15.0_wp)
   call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
      & cn, dcndr, dcndL)
!   call d3_atm_gradient(mol, neighs, neighlist, dparam_pbe, 4.0_wp, &
!      & cn, dcndr, dcndL, energy, gradient, sigma)

   call check(error, energy, 0.82278010088603E-02_wp, thr=thr)
   call check(error, norm2(gradient), 0.23010015730368E-02_wp, thr=thr)

   call check(error, gradient(1, 3),  0.43946166128195E-03_wp, thr=thr)
   call check(error, gradient(2, 7),  0.13253569511538E-03_wp, thr=thr)
   call check(error, gradient(3,12), -0.57499662722386E-04_wp, thr=thr)

   call check(error, sigma(1,1), -0.55966219802469E-02_wp, thr=thr)
   call check(error, sigma(2,1), -0.99936312640867E-03_wp, thr=thr)
   call check(error, sigma(3,2),  0.67158553483908E-03_wp, thr=thr)

   ! check numerical gradient
   do ii = 1, nat, 5
      do jj = 1, 3
         er = 0.0_wp
         el = 0.0_wp
         mol%xyz(jj, ii) = mol%xyz(jj, ii) + step
         call mol%update
         call neighList%update(mol%xyz, trans)
         call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
            & cn, dcndr, dcndL)
!         call d3_atm_gradient(mol, neighs, neighlist, dparam_pbe, 4.0_wp, &
!            & cn, dcndr, dcndL, er, gdum, sdum)
         mol%xyz(jj, ii) = mol%xyz(jj, ii) - 2*step
         call mol%update
         call neighList%update(mol%xyz, trans)
         call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
            & cn, dcndr, dcndL)
!         call d3_atm_gradient(mol, neighs, neighlist, dparam_pbe, 4.0_wp, &
!            & cn, dcndr, dcndL, el, gdum, sdum)
         mol%xyz(jj, ii) = mol%xyz(jj, ii) + step
         call check(error, gradient(jj, ii), (er - el)*step2, thr=thr)
      end do
   end do

!   ! check numerical strain derivatives
!   trans2 = trans
!   eps = unity
!   do ii = 1, 3
!      do jj = 1, ii
!         eps(jj, ii) = eps(jj, ii) + step
!         mol%lattice(:, :) = matmul(eps, lattice)
!         mol%xyz(:, :) = matmul(eps, xyz)
!         trans(:, :) = matmul(eps, trans2)
!         call mol%update
!         !call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
!            !& cn, dcndr, dcndL)
!         call d3_atm_gradient(mol, neighs, neighlist, dparam_pbe, 4.0_wp, &
!            & cn, dcndr, dcndL, er, gdum, sdum)
!
!         eps(jj, ii) = eps(jj, ii) - 2*step
!         mol%lattice(:, :) = matmul(eps, lattice)
!         mol%xyz(:, :) = matmul(eps, xyz)
!         trans(:, :) = matmul(eps, trans2)
!         call mol%update
!         call neighList%update(mol%xyz, trans)
!         !call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
!            !& cn, dcndr, dcndL)
!         call d3_atm_gradient(mol, neighs, neighlist, dparam_pbe, 4.0_wp, &
!            & cn, dcndr, dcndL, el, gdum, sdum)
!
!         eps(jj, ii) = eps(jj, ii) + step
!
!         call check(error, sigma(jj, ii), (er - el)*step2, thr=thr)
!      end do
!   end do

end subroutine test_dftd3_pbc3d_threebody_neighs


subroutine test_dftd3_pbc3d_threebody_latp(error)
   use xtb_mctc_accuracy, only : wp

   use xtb_mctc_convert, only : aatoau

   use xtb_type_environment, only : TEnvironment, init
   use xtb_type_molecule, only : TMolecule, init, len
   use xtb_type_neighbourlist, only : TNeighbourList, init
   use xtb_type_latticepoint, only : TLatticePoint, init
   use xtb_type_wignerseitzcell, only : TWignerSeitzCell, init
   use xtb_type_param, only : dftd_parameter

   use xtb_disp_coordinationnumber, only : getCoordinationNumber, cnType
!   use xtb_disp_dftd3, only : d3_atm_gradient
   use xtb_disp_dftd3param, only : copy_c6, reference_c6

   type(error_type), allocatable, intent(out) :: error

   real(wp),parameter :: thr = 1.0e-10_wp
   integer, parameter :: nat = 32
   integer, parameter :: at(nat) = [8, 8, 8, 8, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, &
      & 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
   real(wp),parameter :: xyz(3,nat) = reshape(&
      &[4.5853168464880421_wp,  4.9392326929575878_wp,  4.1894081210748118_wp,  &
      & 5.8862267152491423_wp,  1.1425258978245871_wp,  6.5015058204768126_wp,  &
      & 1.4284279616220412_wp,  4.6017511285540875_wp,  3.1465884436348119_wp,  &
      & 2.3323404704521411_wp,  1.4471801154820869_wp,  0.7121932185858125_wp,  &
      & 4.7333543155561415_wp,  2.7747291872305868_wp,  3.1951352976178122_wp,  &
      & 5.6617754419101418_wp,  2.2133191164485870_wp,  2.1235404838618126_wp,  &
      & 5.3107598618381422_wp,  2.6902988056185868_wp,  0.7384466319968125_wp,  &
      & 4.4947071071761426_wp,  3.9530790692635867_wp,  0.6801776747598124_wp,  &
      & 4.8005171923760424_wp,  4.9185102874975870_wp,  1.8186363449528122_wp,  &
      & 4.6951362687070421_wp,  4.2781752812835867_wp,  3.1816411821728123_wp,  &
      & 1.3838574419160412_wp,  5.2817805008910863_wp,  4.1482702947948136_wp,  &
      & 1.0268974195990415_wp,  4.7234752637800881_wp,  5.4989995400388123_wp,  &
      & 2.0852659694760409_wp,  5.0956317453800875_wp,  6.5351699846458127_wp,  &
      & 2.3344644666691412_wp, -0.0736561690909131_wp,  6.4245628001158135_wp,  &
      & 2.4894017448231409_wp,  0.6213510313930869_wp,  5.0967297417158131_wp,  &
      & 1.5745272273791413_wp,  0.1243470825760870_wp,  3.9731040773988129_wp,  &
      & 5.8221065925130420_wp,  5.3013563342055878_wp,  1.7264876737078123_wp,  &
      & 3.4487807319551416_wp,  3.6355832152975864_wp,  0.7429568016758125_wp,  &
      & 4.8499393376520423_wp,  3.4713855169305874_wp,  6.4691872586348129_wp,  &
      & 0.2495364434351412_wp,  2.4795455690160870_wp,  2.1043557230378123_wp,  &
      & 5.6691068338331423_wp,  1.1234174220755870_wp,  2.1414388326468128_wp,  &
      & 3.7072009289431418_wp,  2.4357632918535872_wp,  3.0094700999208119_wp,  &
      & 4.1414520030430415_wp,  5.7877262477775879_wp,  1.7803680119358125_wp,  &
      & 5.0142851411171421_wp,  2.4165926460955873_wp,  4.1857610486448129_wp,  &
      & 3.0280930003030413_wp,  4.6201081184690871_wp,  6.2533190952188136_wp,  &
      & 0.5863628696651412_wp,  0.5757236365910867_wp,  4.1021714214668128_wp,  &
      & 2.3776130524831411_wp,  1.6969724987740866_wp,  5.2327688986668139_wp,  &
      & 1.9486148363011413_wp,  0.4390675147070869_wp,  2.9999022491838123_wp,  &
      & 3.5312997625581413_wp,  0.4467415528495868_wp,  4.8114121395028135_wp,  &
      & 6.5089895990100421_wp,  5.2100409408535882_wp,  6.0066553789008132_wp,  &
      & 0.9001165013630412_wp,  3.6420787128610868_wp,  5.4413106648508132_wp,  &
      & 1.6012116650460413_wp,  5.6845471271780879_wp,  0.7675566847298124_wp], &
      & shape(xyz)) * aatoau
   real(wp),parameter :: lattice(3,3) = reshape(&
      &[6.4411018522600_wp,    0.0492571261505_wp,    0.2192046129910_wp,  &
      & 0.0462076831749_wp,    6.6435057067500_wp,    0.1670513770770_wp,  &
      & 0.2262248220170_wp,   -0.9573234940220_wp,    6.7608039126200_wp], &
      & shape(lattice)) * aatoau
   type(dftd_parameter),parameter :: dparam_pbe = dftd_parameter ( &
      & s6=1.0_wp, s8=0.95948085_wp, a1=0.38574991_wp, a2=4.80688534_wp, s9=1.0_wp)

   type(TMolecule) :: mol
   type(TEnvironment) :: env
   type(TLatticePoint) :: latp
   type(TNeighbourlist) :: neighList

   integer, allocatable :: neighs(:)
   real(wp), allocatable :: trans(:, :), trans2(:, :)

   integer :: ii, jj
   real(wp) :: er, el, eps(3, 3)
   real(wp), parameter :: step = 1.0e-5_wp, step2 = 0.5_wp/step
   real(wp), parameter :: unity(3, 3) = reshape(&
      & [1.0_wp, 0.0_wp, 0.0_wp, 0.0_wp, 1.0_wp, 0.0_wp, 0.0_wp, 0.0_wp, 1.0_wp], &
      & [3, 3])
   real(wp) :: energy, sigma(3, 3), sdum(3, 3)
   real(wp), allocatable :: gradient(:, :), gdum(:, :)
   real(wp), allocatable :: cn(:), dcndr(:, :, :), dcndL(:, :, :)

   call init(env)

   call init(mol, at, xyz)

   if (.not.allocated(reference_c6)) call copy_c6(reference_c6)
   allocate(neighs(nat))
   allocate(cn(nat), dcndr(3, nat, nat), dcndL(3, 3, nat))
   allocate(gradient(3, nat), gdum(3, nat))

   energy = 0.0_wp
   gradient(:, :) = 0.0_wp
   sigma(:, :) = 0.0_wp

   call init(latp, env, mol, 15.0_wp)  ! Fixed cutoff
   call latp%getLatticePoints(trans, 15.0_wp)
   call init(neighList, len(mol))
   call neighList%generate(env, mol%xyz, 15.0_wp, trans, .false.)

   call neighlist%getNeighs(neighs, 15.0_wp)
   call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
      & cn, dcndr, dcndL)
!   call d3_atm_gradient(mol, trans, dparam_pbe, 4.0_wp, 15.0_wp, &
!      & cn, dcndr, dcndL, energy, gradient, sigma)

   call check(error, energy, 0.82282776910965E-02_wp, thr=thr)
   call check(error, norm2(gradient), 0.23008499292227E-02_wp, thr=thr)

   call check(error, gradient(1, 3),  0.43949930795013E-03_wp, thr=thr)
   call check(error, gradient(2, 7),  0.13251725802574E-03_wp, thr=thr)
   call check(error, gradient(3,12), -0.57506040392065E-04_wp, thr=thr)

   call check(error, sigma(1,1), -0.55971082405750E-02_wp, thr=thr)
   call check(error, sigma(2,1), -0.99942421059516E-03_wp, thr=thr)
   call check(error, sigma(3,2),  0.67209092938839E-03_wp, thr=thr)

   ! check numerical gradient
   do ii = 1, nat, 5
      do jj = 1, 3
         er = 0.0_wp
         el = 0.0_wp
         mol%xyz(jj, ii) = mol%xyz(jj, ii) + step
         call mol%update
         call neighList%update(mol%xyz, trans)
         call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
            & cn, dcndr, dcndL)
!         call d3_atm_gradient(mol, trans, dparam_pbe, 4.0_wp, 15.0_wp, &
!            & cn, dcndr, dcndL, er, gdum, sdum)
         mol%xyz(jj, ii) = mol%xyz(jj, ii) - 2*step
         call mol%update
         call neighList%update(mol%xyz, trans)
         call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
            & cn, dcndr, dcndL)
!         call d3_atm_gradient(mol, trans, dparam_pbe, 4.0_wp, 15.0_wp, &
!            & cn, dcndr, dcndL, el, gdum, sdum)
         mol%xyz(jj, ii) = mol%xyz(jj, ii) + step
         call check(error, gradient(jj, ii), (er - el)*step2, thr=thr)
      end do
   end do

!   ! check numerical strain derivatives
!   trans2 = trans
!   eps = unity
!   do ii = 1, 3
!      do jj = 1, ii
!         eps(jj, ii) = eps(jj, ii) + step
!         mol%lattice(:, :) = matmul(eps, lattice)
!         mol%xyz(:, :) = matmul(eps, xyz)
!         trans(:, :) = matmul(eps, trans2)
!         call mol%update
!         !call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
!            !& cn, dcndr, dcndL)
!         call d3_atm_gradient(mol, neighs, neighlist, dparam_pbe, 4.0_wp, &
!            & cn, dcndr, dcndL, er, gdum, sdum)
!
!         eps(jj, ii) = eps(jj, ii) - 2*step
!         mol%lattice(:, :) = matmul(eps, lattice)
!         mol%xyz(:, :) = matmul(eps, xyz)
!         trans(:, :) = matmul(eps, trans2)
!         call mol%update
!         call neighList%update(mol%xyz, trans)
!         !call getCoordinationNumber(mol, neighs, neighList, cnType%exp, &
!            !& cn, dcndr, dcndL)
!         call d3_atm_gradient(mol, neighs, neighlist, dparam_pbe, 4.0_wp, &
!            & cn, dcndr, dcndL, el, gdum, sdum)
!
!         eps(jj, ii) = eps(jj, ii) + step
!
!         call check(error, sigma(jj, ii), (er - el)*step2, thr=thr)
!      end do
!   end do

end subroutine test_dftd3_pbc3d_threebody_latp


end module test_dftd3
