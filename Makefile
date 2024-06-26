FC = /path/to/cross-compiler/prefix-gfortran
F77 = /path/to/cross-compiler/prefix-gfortran

FPFLAGS = -DWITH_JSON=0 -DWITH_BLAS=1

#FFLAGS =  -fdefault-real-8 -fdefault-double-8 -ffree-line-length-none -fbacktrace -O2 -g -DNDEBUG -pie

#F77FLAGS = -fdefault-real-8 -fdefault-double-8 -ffree-line-length-none -fbacktrace -O2 -g -DNDEBUG -pie

FFLAGS =  -ffree-line-length-none -fbacktrace -O2 -g -DNDEBUG -pie -fdefault-real-8 -fdefault-double-8 -fPIE

F77FLAGS = -ffree-line-length-none -fbacktrace -O2 -g -DNDEBUG -pie -fdefault-real-8 -fdefault-double-8 -fPIE

CFLAGS= -O2 -g -DNDEBUG -fPIC -pie

LIB = ./libtblite.a ./libtoml-f.a ./libdftd4.a ./libmulticharge.a ../../libs-x86_64/liblapack.a ./libs-dftd3.a ./libmctc.a ../../libs-x86_64/libblas.a

INC = -I./mctc-lib-src/include/mctc -I./mctc-lib-src/include -I. -I./include -I./tblite-src/include -I./tblite-src

LDFLAGS = -pie -static -fPIC
	
MCTCLIB = mctc-lib-src/src/mctc/env/accuracy.o \
mctc-lib-src/src/mctc/env/error.o \
mctc-lib-src/src/mctc/env/system.o \
mctc-lib-src/src/mctc/env.o \
mctc-lib-src/src/mctc/env/testing.o \
mctc-lib-src/src/mctc/io/filetype.o \
mctc-lib-src/src/mctc/io/codata2018.o \
mctc-lib-src/src/mctc/io/constants.o \
mctc-lib-src/src/mctc/io/convert.o \
mctc-lib-src/src/mctc/io/resize.o \
mctc-lib-src/src/mctc/io/structure/info.o \
mctc-lib-src/src/mctc/io/symbols.o \
mctc-lib-src/src/mctc/io/structure.o \
mctc-lib-src/src/mctc/io/utils.o \
mctc-lib-src/src/mctc/io/read/aims.o \
mctc-lib-src/src/mctc/io/read/cjson.o \
mctc-lib-src/src/mctc/io/read/ctfile.o \
mctc-lib-src/src/mctc/io/read/gaussian.o \
mctc-lib-src/src/mctc/io/read/genformat.o \
mctc-lib-src/src/mctc/io/read/pdb.o \
mctc-lib-src/src/mctc/io/read/qchem.o \
mctc-lib-src/src/mctc/io/read/qcschema.o \
mctc-lib-src/src/mctc/io/read/turbomole.o \
mctc-lib-src/src/mctc/io/read/vasp.o \
mctc-lib-src/src/mctc/io/read/xyz.o \
mctc-lib-src/src/mctc/io/read.o \
mctc-lib-src/src/mctc/io/write/aims.o \
mctc-lib-src/src/mctc/io/math.o \
mctc-lib-src/src/mctc/io/write/cjson.o \
mctc-lib-src/src/mctc/io/write/ctfile.o \
mctc-lib-src/src/mctc/io/write/gaussian.o \
mctc-lib-src/src/mctc/io/write/genformat.o \
mctc-lib-src/src/mctc/io/write/pdb.o \
mctc-lib-src/src/mctc/io/write/qchem.o \
mctc-lib-src/src/mctc/version.o \
mctc-lib-src/src/mctc/io/write/qcschema.o \
mctc-lib-src/src/mctc/io/write/turbomole.o \
mctc-lib-src/src/mctc/io/write/vasp.o \
mctc-lib-src/src/mctc/io/write/xyz.o \
mctc-lib-src/src/mctc/io/write.o \
mctc-lib-src/src/mctc/io.o

SDFTD3LIB = s-dftd3-src/src/dftd3/cutoff.o \
s-dftd3-src/src/dftd3/damping.o \
s-dftd3-src/src/dftd3/damping/atm.o \
s-dftd3-src/src/dftd3/param.o \
s-dftd3-src/src/dftd3/damping/mzero.o \
s-dftd3-src/src/dftd3/damping/optimizedpower.o \
s-dftd3-src/src/dftd3/damping/rational.o \
s-dftd3-src/src/dftd3/damping/zero.o \
s-dftd3-src/src/dftd3/blas.o \
s-dftd3-src/src/dftd3/data/covrad.o \
s-dftd3-src/src/dftd3/data/r4r2.o \
s-dftd3-src/src/dftd3/data/vdwrad.o \
s-dftd3-src/src/dftd3/data.o \
s-dftd3-src/src/dftd3/reference.o \
s-dftd3-src/src/dftd3/model.o \
s-dftd3-src/src/dftd3/ncoord.o \
s-dftd3-src/src/dftd3/disp.o \
s-dftd3-src/src/dftd3/version.o \
s-dftd3-src/src/dftd3.o \
s-dftd3-src/src/dftd3/utils.o \
s-dftd3-src/src/dftd3/api.o \
s-dftd3-src/src/dftd3/output.o

TOMLFLIB = toml-f-src/src/tomlf/constants.o \
toml-f-src/src/tomlf/error.o \
toml-f-src/src/tomlf/datetime.o \
toml-f-src/src/tomlf/utils/verify.o \
toml-f-src/src/tomlf/utils/convert.o \
toml-f-src/src/tomlf/utils.o \
toml-f-src/src/tomlf/type/value.o \
toml-f-src/src/tomlf/structure/base.o \
toml-f-src/src/tomlf/structure/vector.o \
toml-f-src/src/tomlf/structure.o \
toml-f-src/src/tomlf/type/array.o \
toml-f-src/src/tomlf/type/keyval.o \
toml-f-src/src/tomlf/type/table.o \
toml-f-src/src/tomlf/type.o \
toml-f-src/src/tomlf/build/keyval.o \
toml-f-src/src/tomlf/build/array.o \
toml-f-src/src/tomlf/build/merge.o \
toml-f-src/src/tomlf/build/table.o \
toml-f-src/src/tomlf/build.o \
toml-f-src/src/tomlf/de/tokenizer.o \
toml-f-src/src/tomlf/de/character.o \
toml-f-src/src/tomlf/de.o \
toml-f-src/src/tomlf/ser.o \
toml-f-src/src/tomlf/utils/sort.o \
toml-f-src/src/tomlf/version.o \
toml-f-src/src/tomlf.o \
toml-f-src/src/tomlf/all.o

MULTICHARGELIB = multicharge-src/src/multicharge/cutoff.o \
multicharge-src/src/multicharge/data/covrad.o \
multicharge-src/src/multicharge/data.o \
multicharge-src/src/multicharge/blas.o \
multicharge-src/src/multicharge/ewald.o \
multicharge-src/src/multicharge/lapack.o \
multicharge-src/src/multicharge/wignerseitz.o \
multicharge-src/src/multicharge/model.o \
multicharge-src/src/multicharge/ncoord.o \
multicharge-src/src/multicharge/output.o \
multicharge-src/src/multicharge/param/eeq2019.o \
multicharge-src/src/multicharge/param.o \
multicharge-src/src/multicharge/version.o \
multicharge-src/src/multicharge.o

DFTD4LIB = dftd4-src/src/dftd4/cutoff.o \
dftd4-src/src/dftd4/damping.o \
dftd4-src/src/dftd4/damping/atm.o \
dftd4-src/src/dftd4/data/covrad.o \
dftd4-src/src/dftd4/data/en.o \
dftd4-src/src/dftd4/data/hardness.o \
dftd4-src/src/dftd4/data/r4r2.o \
dftd4-src/src/dftd4/data/zeff.o \
dftd4-src/src/dftd4/data.o \
dftd4-src/src/dftd4/damping/rational.o \
dftd4-src/src/dftd4/blas.o \
dftd4-src/src/dftd4/charge.o \
dftd4-src/src/dftd4/reference.o \
dftd4-src/src/dftd4/model.o \
dftd4-src/src/dftd4/ncoord.o \
dftd4-src/src/dftd4/disp.o \
dftd4-src/src/dftd4/param.o \
dftd4-src/src/dftd4/version.o \
dftd4-src/src/dftd4.o \
dftd4-src/src/dftd4/utils.o \
dftd4-src/src/dftd4/api.o \
dftd4-src/src/dftd4/output.o

TBLITELIB = tblite-src/src/tblite/adjlist.o \
tblite-src/src/tblite/version.o \
tblite-src/src/tblite/api/version.o \
tblite-src/src/tblite/container/cache.o \
tblite-src/src/tblite/scf/info.o \
tblite-src/src/tblite/basis/type.o \
tblite-src/src/tblite/integral/type.o \
tblite-src/src/tblite/wavefunction/spin.o \
tblite-src/src/tblite/scf/potential.o \
tblite-src/src/tblite/blas/level1.o \
tblite-src/src/tblite/blas/level2.o \
tblite-src/src/tblite/blas/level3.o \
tblite-src/src/tblite/blas.o \
tblite-src/src/tblite/wavefunction/type.o \
tblite-src/src/tblite/container/type.o \
tblite-src/src/tblite/output/format.o \
tblite-src/src/tblite/container/list.o \
tblite-src/src/tblite/container.o \
tblite-src/src/tblite/external/field.o \
tblite-src/src/tblite/api/container.o \
tblite-src/src/tblite/api/utils.o \
tblite-src/src/tblite/api/error.o \
tblite-src/src/tblite/context/logger.o \
tblite-src/src/tblite/context/terminal.o \
tblite-src/src/tblite/scf/solver.o \
tblite-src/src/tblite/context/solver.o \
tblite-src/src/tblite/lapack/sygvd.o \
tblite-src/src/tblite/lapack/potrf.o \
tblite-src/src/tblite/lapack/sygst.o \
tblite-src/src/tblite/lapack/sygvr.o \
tblite-src/src/tblite/lapack/solver.o \
tblite-src/src/tblite/context/type.o \
tblite-src/src/tblite/context.o \
tblite-src/src/tblite/api/context.o \
tblite-src/src/tblite/toml.o \
tblite-src/src/tblite/api/table.o \
tblite-src/src/tblite/coulomb/ewald.o \
tblite-src/src/tblite/cutoff.o \
tblite-src/src/tblite/wignerseitz.o \
tblite-src/src/tblite/coulomb/cache.o \
tblite-src/src/tblite/coulomb/type.o \
tblite-src/src/tblite/coulomb/charge/type.o \
tblite-src/src/tblite/coulomb/charge/effective.o \
tblite-src/src/tblite/coulomb/charge/gamma.o \
tblite-src/src/tblite/coulomb/charge.o \
tblite-src/src/tblite/param/serde.o \
tblite-src/src/tblite/param/charge.o \
tblite-src/src/tblite/param/dispersion.o \
tblite-src/src/tblite/data/paulingen.o \
tblite-src/src/tblite/param/element.o \
tblite-src/src/tblite/param/halogen.o \
tblite-src/src/tblite/param/hamiltonian.o \
tblite-src/src/tblite/param/multipole.o \
tblite-src/src/tblite/param/repulsion.o \
tblite-src/src/tblite/param/thirdorder.o \
tblite-src/src/tblite/param/mask.o \
tblite-src/src/tblite/param.o \
tblite-src/src/tblite/basis/ortho.o \
tblite-src/src/tblite/basis/slater.o \
tblite-src/src/tblite/data/atomicrad.o \
tblite-src/src/tblite/repulsion/type.o \
tblite-src/src/tblite/classical/halogen.o \
tblite-src/src/tblite/data/covrad.o \
tblite-src/src/tblite/ncoord/type.o \
tblite-src/src/tblite/ncoord/gfn.o \
tblite-src/src/tblite/coulomb/multipole.o \
tblite-src/src/tblite/coulomb/thirdorder.o \
tblite-src/src/tblite/disp/cache.o \
tblite-src/src/tblite/disp/type.o \
tblite-src/src/tblite/disp/d3.o \
tblite-src/src/tblite/disp/d4.o \
tblite-src/src/tblite/disp.o \
tblite-src/src/tblite/ncoord/exp.o \
tblite-src/src/tblite/ncoord.o \
tblite-src/src/tblite/repulsion/effective.o \
tblite-src/src/tblite/repulsion.o \
tblite-src/src/tblite/coulomb.o \
tblite-src/src/tblite/xtb/coulomb.o \
tblite-src/src/tblite/integral/trafo.o \
tblite-src/src/tblite/integral/multipole.o \
tblite-src/src/tblite/xtb/spec.o \
tblite-src/src/tblite/xtb/h0.o \
tblite-src/src/tblite/xtb/calculator.o \
tblite-src/src/tblite/xtb/gfn1.o \
tblite-src/src/tblite/xtb/gfn2.o \
tblite-src/src/tblite/xtb/ipea1.o \
tblite-src/src/tblite/api/param.o \
tblite-src/src/tblite/results.o \
tblite-src/src/tblite/api/result.o \
tblite-src/src/tblite/api/structure.o \
tblite-src/src/tblite/wavefunction/guess.o \
tblite-src/src/tblite/wavefunction/mulliken.o \
tblite-src/src/tblite/wavefunction.o \
tblite-src/src/tblite/lapack/getrf.o \
tblite-src/src/tblite/lapack/getri.o \
tblite-src/src/tblite/lapack/getrs.o \
tblite-src/src/tblite/lapack.o \
tblite-src/src/tblite/scf/mixer/type.o \
tblite-src/src/tblite/scf/mixer/broyden.o \
tblite-src/src/tblite/scf/mixer.o \
tblite-src/src/tblite/wavefunction/fermi.o \
tblite-src/src/tblite/scf/iterator.o \
tblite-src/src/tblite/scf.o \
tblite-src/src/tblite/timer.o \
tblite-src/src/tblite/xtb/singlepoint.o \
tblite-src/src/tblite/api/calculator.o \
tblite-src/src/tblite/basis.o \
tblite-src/src/tblite/data/spin.o \
tblite-src/src/tblite/data.o \
tblite-src/src/tblite/fit/newuoa.o \
tblite-src/src/tblite/fit/settings.o \
tblite-src/src/tblite/integral/dipole.o \
tblite-src/src/tblite/integral/overlap.o \
tblite-src/src/tblite/io/tag.o \
tblite-src/src/tblite/mesh/lebedev.o \
tblite-src/src/tblite/os.o \
tblite-src/src/tblite/output/ascii.o \
tblite-src/src/tblite/output/property.o \
tblite-src/src/tblite/solvation/born.o \
tblite-src/src/tblite/solvation/data.o \
tblite-src/src/tblite/solvation/type.o \
tblite-src/src/tblite/solvation/alpb.o \
tblite-src/src/tblite/solvation/cpcm_dd.o \
tblite-src/src/tblite/solvation/cpcm.o \
tblite-src/src/tblite/solvation/input.o \
tblite-src/src/tblite/solvation.o \
tblite-src/src/tblite/solvation/surface.o \
tblite-src/src/tblite/solvation/cds.o \
tblite-src/src/tblite/spin.o \
tblite-src/src/tblite/xtb.o

MCTCTESTERLIB = mctc-lib-src/test/test_math.o \
mctc-lib-src/test/test_read.o \
mctc-lib-src/test/test_read_aims.o \
mctc-lib-src/test/test_read_cjson.o \
mctc-lib-src/test/test_read_ctfile.o \
mctc-lib-src/test/test_read_gaussian.o \
mctc-lib-src/test/test_read_genformat.o \
mctc-lib-src/test/test_read_pdb.o \
mctc-lib-src/test/test_read_qchem.o \
mctc-lib-src/test/test_read_qcschema.o \
mctc-lib-src/test/test_read_turbomole.o \
mctc-lib-src/test/test_read_vasp.o \
mctc-lib-src/test/test_read_xyz.o \
mctc-lib-src/test/test_symbols.o \
mctc-lib-src/test/testsuite_structure.o \
mctc-lib-src/test/test_write.o \
mctc-lib-src/test/test_write_aims.o \
mctc-lib-src/test/test_write_cjson.o \
mctc-lib-src/test/test_write_ctfile.o \
mctc-lib-src/test/test_write_gaussian.o \
mctc-lib-src/test/test_write_genformat.o \
mctc-lib-src/test/test_write_pdb.o \
mctc-lib-src/test/test_write_qchem.o \
mctc-lib-src/test/test_write_turbomole.o \
mctc-lib-src/test/test_write_vasp.o \
mctc-lib-src/test/test_write_xyz.o \
mctc-lib-src/test/main.o

MCTCCONVERT= mctc-lib-src/app/main.o

MSTORELIB = mstore-src/src/mstore/data/record.o \
mstore-src/src/mstore/amino20x4.o \
mstore-src/src/mstore/but14diol.o \
mstore-src/src/mstore/data/collection.o \
mstore-src/src/mstore/data/store.o \
mstore-src/src/mstore/heavy28.o \
mstore-src/src/mstore/ice10.o \
mstore-src/src/mstore/il16.o \
mstore-src/src/mstore/mb16_43.o \
mstore-src/src/mstore/upu23.o \
mstore-src/src/mstore/x23.o \
mstore-src/src/mstore.o \
mstore-src/src/mstore_version.o

MSTOREFORTRANIZE = mstore-src/app/fortranize/main.o

MSTOREINFO = mstore-src/app/info/main.o

TOML2JSON = toml-f-src/test/json_ser.o \
toml-f-src/test/toml2json.o

TESTDRIVE = test-drive-src/src/testdrive.o \
test-drive-src/src/testdrive_version.o

TFTESTER = toml-f-src/test/tftest/build.o \
toml-f-src/test/tftest/sort.o \
toml-f-src/test/tftest/main.o

JSON2TOML = toml-f-src/test/json_de.o \
toml-f-src/test/json2toml.o

TFTEST =toml-f-src/test/fpm.o

TFTESTVERSION = toml-f-src/test/version.o

TESTDRIVETESTER = test-drive-src/test/test_check.o \
test-drive-src/test/test_select.o \
test-drive-src/test/main.o

MULTICHARGE = multicharge-src/app/main.o

MULTICHARGETESTER = multicharge-src/test/test_model.o \
multicharge-src/test/test_ncoord.o \
multicharge-src/test/test_pbc.o \
multicharge-src/test/test_wignerseitz.o \
multicharge-src/test/main.o

DFTD4 = dftd4-src/app/cli.o \
dftd4-src/app/driver.o \
dftd4-src/app/main.o

DFTD4TESTER = dftd4-src/test/unit/test_dftd4.o \
dftd4-src/test/unit/test_model.o \
dftd4-src/test/unit/test_ncoord.o \
dftd4-src/test/unit/test_pairwise.o \
dftd4-src/test/unit/test_param.o \
dftd4-src/test/unit/test_periodic.o \
dftd4-src/test/unit/main.o

SDFTD3 = s-dftd3-src/app/argument.o \
s-dftd3-src/app/help.o \
s-dftd3-src/app/cli.o \
s-dftd3-src/app/toml.o \
s-dftd3-src/app/driver.o \
s-dftd3-src/app/main.o

SDFTD3TESTER = s-dftd3-src/test/unit/test_dftd3.o \
s-dftd3-src/test/unit/test_model.o \
s-dftd3-src/test/unit/test_ncoord.o \
s-dftd3-src/test/unit/test_pairwise.o \
s-dftd3-src/test/unit/test_param.o \
s-dftd3-src/test/unit/test_periodic.o \
s-dftd3-src/test/unit/test_regression.o \
s-dftd3-src/test/unit/main.o

TBLITE = tblite-src/app/argument.o \
tblite-src/app/cli_help.o \
tblite-src/app/features.o \
tblite-src/app/cli.o \
tblite-src/app/driver_fit.o \
tblite-src/app/driver_param.o \
tblite-src/app/driver_run.o \
tblite-src/app/driver_tagdiff.o \
tblite-src/app/driver.o \
tblite-src/app/main.o

TBLITEAPITESTER = tblite-src/test/api/main.o

TBLITETESTER = tblite-src/test/unit/test_cgto_ortho.o \
tblite-src/test/unit/test_coulomb_charge.o \
tblite-src/test/unit/test_coulomb_multipole.o \
tblite-src/test/unit/test_fit.o \
tblite-src/test/unit/test_gfn1_xtb.o \
tblite-src/test/unit/test_gfn2_xtb.o \
tblite-src/test/unit/test_halogen.o \
tblite-src/test/unit/test_hamiltonian.o \
tblite-src/test/unit/test_integral_multipole.o \
tblite-src/test/unit/test_integral_overlap.o \
tblite-src/test/unit/test_ipea1_xtb.o \
tblite-src/test/unit/test_ncoord_gfn.o \
tblite-src/test/unit/test_repulsion.o \
tblite-src/test/unit/test_slater_expansion.o \
tblite-src/test/unit/test_solvation_born.o \
tblite-src/test/unit/test_solvation_cpcm.o \
tblite-src/test/unit/test_solvation_surface.o \
tblite-src/test/unit/test_spin.o \
tblite-src/test/unit/test_tagged_io.o \
tblite-src/test/unit/test_xtb_external.o \
tblite-src/test/unit/test_xtb_param.o \
tblite-src/test/unit/main.o

RMSDLIB =	rmsd-tool/src/rmsd/toml.o \
rmsd-tool/src/rmsd/filter.o \
rmsd-tool/src/rmsd/config.o \
rmsd-tool/src/rmsd/ls.o \
rmsd-tool/src/rmsd/version.o \
rmsd-tool/src/rmsd.o \
rmsd-tool/app/targ.o

RMSDTOOL = 	rmsd-tool/app/main.o

RMSDTESTER = 	rmsd-tool/test/test_rmsd.o \
rmsd-tool/test/test_rmsd_filter.o \
rmsd-tool/test/main.o

QCXMSLIB = 	src/xtb_mctc_accuracy.o \
src/xtb_mctc_constants.o \
src/xtb_mctc_convert.o \
src/xtb_mctc_resize.o \
src/xtb_mctc_symbols.o \
src/common1.o \
src/cidcommon.o \
src/atomic_masses.o \
src/boxmuller.o \
src/newcommon.o \
src/callxtb.o \
src/covalent_radii.o \
src/d3common.o \
src/copyc6.o \
src/readcommon.o \
src/utility.o \
src/dftb.o \
src/dftd3.o \
src/dftd4.o \
src/diag3x3.o \
src/elem.o \
src/mndo.o \
src/mopac.o \
src/mo_energ.o \
src/msindo.o \
src/orca.o \
src/prmat.o \
src/fragments.o \
src/gcp.o \
src/geteps.o \
src/version.o \
src/mass.o \
src/readl.o \
src/tblite.o \
src/tm.o \
src/snorm.o \
src/timing.o \
src/iniqm.o \
src/mo_spec.o \
src/settings.o \
src/iee.o \
src/mdinit.o \
src/info.o \
src/analyse.o \
src/impact.o \
src/md.o \
src/rotation.o \
src/input.o \
src/write_fragments.o \
src/cid.o 

QCXMS =	src/main.o

# all:  libmctc.a libs-dftd3.a libtoml-f.a libmulticharge.a libdftd4.a libtblite.a mctc-convert libmstore.a mstore-fortranize mstore-info toml2json libtest-drive.a tftester json2toml tftest-fpm tftest-version test-drive-tester multicharge multicharge-tester dftd4 dftd4-tester s-dftd3 s-dftd3-tester tblite tblite-api-tester tblite-tester librmsd.a rmsd-tool rmsd-tester libqcxms.a qcxms strip

all:  libmctc.a libs-dftd3.a libtoml-f.a libmulticharge.a libdftd4.a libtblite.a mctc-convert libmstore.a mstore-fortranize mstore-info toml2json libtest-drive.a tftester json2toml tftest-fpm tftest-version test-drive-tester multicharge multicharge-tester dftd4 dftd4-tester s-dftd3 s-dftd3-tester tblite tblite-tester librmsd.a rmsd-tool rmsd-tester libqcxms.a qcxms strip
	
libmctc.a:  $(MCTCLIB) 
	/path/to/cross-compiler/prefix-ar qc libmctc.a $(MCTCLIB) 
	/path/to/cross-compiler/prefix-ranlib libmctc.a

libs-dftd3.a:  $(SDFTD3LIB) 
	/path/to/cross-compiler/prefix-ar qc libs-dftd3.a $(SDFTD3LIB) 
	/path/to/cross-compiler/prefix-ranlib libs-dftd3.a

libtoml-f.a:	$(TOMLFLIB) 
	/path/to/cross-compiler/prefix-ar qc libtoml-f.a $(TOMLFLIB) 
	/path/to/cross-compiler/prefix-ranlib libtoml-f.a

libmulticharge.a:  $(MULTICHARGELIB) 
	/path/to/cross-compiler/prefix-ar qc libmulticharge.a $(MULTICHARGELIB) 
	/path/to/cross-compiler/prefix-ranlib libmulticharge.a
	
libdftd4.a:  $(DFTD4LIB) 
	/path/to/cross-compiler/prefix-ar qc libdftd4.a $(DFTD4LIB) 
	/path/to/cross-compiler/prefix-ranlib libdftd4.a
	
libtblite.a:  $(TBLITELIB) 
	/path/to/cross-compiler/prefix-ar qc libtblite.a $(TBLITELIB) 
	/path/to/cross-compiler/prefix-ranlib libtblite.a
	
librmsd.a:  $(RMSDLIB) 
	/path/to/cross-compiler/prefix-ar qc librmsd.a $(RMSDLIB)
	/path/to/cross-compiler/prefix-ranlib librmsd.a
	
rmsd-tool:  $(RMSDTOOL) 
	$(FC) $(FFLAGS) $(RMSDTOOL) $(LDFLAGS) -o rmsd-tool-exe ./librmsd.a $(LIB)
	
rmsd-tester:  $(RMSDTESTER) 
	$(FC) $(FFLAGS) $(RMSDTESTER) $(LDFLAGS) -o rmsd-tester ./librmsd.a $(LIB)
	
libqcxms.a:  $(QCXMSLIB)
	/path/to/cross-compiler/prefix-ar qc libqcxms.a $(QCXMSLIB) 
	/path/to/cross-compiler/prefix-ranlib libqcxms.a

#libxtb.so:  $(XTBLIB) 
#	$(FC) -fPIC -shared -Wl,--allow-multiple-definition -Wl,-soname,libxtb.so.6 -o libxtb.so.6.6.0 $(XTBLIB) 
	
qcxms:  $(QCXMS) 
	$(FC) $(FFLAGS) $(QCXMS) $(LDFLAGS) -o qcxms ./libqcxms.a $(LIB)
	
mctc-convert:  $(MCTCTESTERLIB) $(MCTCCONVERT) 
	$(FC) $(FFLAGS) $(MCTCCONVERT) $(LDFLAGS) -o mctc-convert ./libmctc.a
	$(FC) $(FFLAGS) $(MCTCTESTERLIB) $(LDFLAGS) -o mctc-lib-tester ./libmctc.a
	
libmstore.a:  $(MSTORELIB) 
	/path/to/cross-compiler/prefix-ar qc libmstore.a $(MSTORELIB) 
	/path/to/cross-compiler/prefix-ranlib libmstore.a
	
mstore-fortranize:  $(MSTOREFORTRANIZE) 
	$(FC) $(FFLAGS) $(MSTOREFORTRANIZE) $(LDFLAGS) -o mstore-fortranize ./libmstore.a ./libmctc.a
	
mstore-info:  $(MSTOREINFO) 
	$(FC) $(FFLAGS) $(MSTOREINFO) $(LDFLAGS) -o mstore-info ./libmstore.a ./libmctc.a
	
toml2json:  $(TOML2JSON) 
	$(FC) $(FFLAGS) $(TOML2JSON) $(LDFLAGS) -o toml2json $(LIB)
	
libtest-drive.a:  $(TESTDRIVE) 
	/path/to/cross-compiler/prefix-ar qc libtest-drive.a $(TESTDRIVE) 
	/path/to/cross-compiler/prefix-ranlib libtest-drive.a
	
tftester:  $(TFTESTER) 
	$(FC) $(FFLAGS) $(TFTESTER) $(LDFLAGS) -o tftester ./libtoml-f.a ./libtest-drive.a 
	
json2toml:  $(JSON2TOML) 
	$(FC) $(FFLAGS) $(JSON2TOML) $(LDFLAGS) -o json2toml $(LIB)
	
tftest-fpm:  $(TFTEST) 
	$(FC) $(FFLAGS) $(TFTEST) $(LDFLAGS) -o tftest-fpm $(LIB)
	
tftest-version:  $(TFTESTVERSION) 
	$(FC) $(FFLAGS) $(TFTESTVERSION) $(LDFLAGS) -o tftest-version $(LIB)
	
test-drive-tester:  $(TESTDRIVETESTER) 
	$(FC) $(FFLAGS) $(TESTDRIVETESTER) $(LDFLAGS) -o test-drive-tester ./libtest-drive.a 
	
multicharge:  $(MULTICHARGE) 
	$(FC) $(FFLAGS) $(MULTICHARGE) $(LDFLAGS) -o multicharge $(LIB)
	
multicharge-tester:  $(MULTICHARGETESTER) 
	$(FC) $(FFLAGS) $(MULTICHARGETESTER) $(LDFLAGS) -o multicharge-tester ./libmulticharge.a ../../libs-x86_64/liblapack.a ../../libs-x86_64/libblas.a ./libmstore.a ./libmctc.a
	
dftd4:  $(DFTD4) 
	$(FC) $(FFLAGS) $(DFTD4) $(LDFLAGS) -o dftd4 ./libdftd4.a ./libmulticharge.a ../../libs-x86_64/liblapack.a ../../libs-x86_64/libblas.a ./libmstore.a ./libmctc.a 
	
dftd4-tester:  $(DFTD4TESTER) 
	$(FC) $(FFLAGS) $(DFTD4TESTER) $(LDFLAGS) -o dftd4-tester ./libdftd4.a ./libmulticharge.a ../../libs-x86_64/liblapack.a ../../libs-x86_64/libblas.a ./libmstore.a ./libmctc.a 
	
s-dftd3:  $(SDFTD3) 
	$(FC) $(FFLAGS) $(SDFTD3) $(LDFLAGS) -o s-dftd3 $(LIB)
	
s-dftd3-tester:  $(SDFTD3TESTER) 
	$(FC) $(FFLAGS) $(SDFTD3TESTER) $(LDFLAGS) -o s-dftd3-tester  ./libs-dftd3.a ../../libs-x86_64/libblas.a ./libmstore.a ./libmctc.a 
	
tblite:  $(TBLITE) 
	$(FC) $(FFLAGS) $(TBLITE) $(LDFLAGS) -o tblite $(LIB)
	
tblite-api-tester:  $(TBLITEAPITESTER)
# remove from Linux cross compilations - problems with adding symbols (wrong format - aarch64), relocations (x86)...
# $(CC) $(CFLAGS) $(TBLITEAPITESTER) $(LDFLAGS) -o tblite-api-tester  ./libtblite.a ./libtoml-f.a ./libdftd4.a ./libmulticharge.a ../libs-x86_64/liblapack.a ./libs-dftd3.a ./libmctc.a ../libs-x86_64/libblas.a -static-libgfortran -lm -lgcc
	$(FC) $(FFLAGS) $(TBLITEAPITESTER) $(LDFLAGS) -o tblite-api-tester  ./libtblite.a ./libtoml-f.a ./libdftd4.a ./libmulticharge.a ../../libs-x86_64/liblapack.a ./libs-dftd3.a ./libmctc.a ../../libs-x86_64/libblas.a -static -pie -fPIC -lm -lgcc
	
tblite-tester:  $(TBLITETESTER) 
	$(FC) $(FFLAGS) $(TBLITETESTER) $(LDFLAGS) -o tblite-tester ./libtblite.a ./libtoml-f.a ./libdftd4.a ./libmulticharge.a ../../libs-x86_64/liblapack.a ./libs-dftd3.a ../../libs-x86_64/libblas.a ./libmstore.a ./libmctc.a
	
strip:
	/path/to/cross-compiler/prefix-strip qcxms
	/path/to/cross-compiler/prefix-strip mctc-convert
	/path/to/cross-compiler/prefix-strip mctc-lib-tester
	/path/to/cross-compiler/prefix-strip mstore-fortranize
	/path/to/cross-compiler/prefix-strip mstore-info
	/path/to/cross-compiler/prefix-strip toml2json
	/path/to/cross-compiler/prefix-strip tftester
	/path/to/cross-compiler/prefix-strip json2toml
	/path/to/cross-compiler/prefix-strip tftest-fpm
	/path/to/cross-compiler/prefix-strip tftest-version
	/path/to/cross-compiler/prefix-strip test-drive-tester
	/path/to/cross-compiler/prefix-strip multicharge
	/path/to/cross-compiler/prefix-strip multicharge-tester
	/path/to/cross-compiler/prefix-strip dftd4
	/path/to/cross-compiler/prefix-strip dftd4-tester
	/path/to/cross-compiler/prefix-strip s-dftd3
	/path/to/cross-compiler/prefix-strip s-dftd3-tester
	/path/to/cross-compiler/prefix-strip tblite
#	/path/to/cross-compiler/prefix-strip tblite-api-tester
	/path/to/cross-compiler/prefix-strip tblite-tester
	/path/to/cross-compiler/prefix-strip rmsd-tester
	/path/to/cross-compiler/prefix-strip rmsd-tool-exe

clean: 
	find . -name "*.o" -type f -delete
	find . -name "*.mod" -type f -delete
	find . -name "*.smod" -type f -delete
	find . -name "*.a" -type f -delete
	find . -name "*.so" -type f -delete
	find . -name "*.so.6" -type f -delete
	find . -name "*.so.6.6.0" -type f -delete
	find . -name "*.in" -type f -delete
	find . -name "qcxms" -type f -delete
	find . -name "mctc-convert" -type f -delete
	find . -name "mstore-fortranize" -type f -delete
	find . -name "mstore-info" -type f -delete
	find . -name "toml2json" -type f -delete
	find . -name "tftester" -type f -delete
	find . -name "json2toml" -type f -delete
	find . -name "tftest-fpm" -type f -delete
	find . -name "tftest-version" -type f -delete
	find . -name "test-drive-tester" -type f -delete
	find . -name "multicharge" -type f -delete
	find . -name "multicharge-tester" -type f -delete
	find . -name "dftd4" -type f -delete
	find . -name "dftd4-tester" -type f -delete
	find . -name "s-dftd3" -type f -delete
	find . -name "s-dftd3-tester" -type f -delete
	find . -name "tblite" -type f -delete
	find . -name "tblite-api-tester" -type f -delete
	find . -name "tblite-tester" -type f -delete
	find . -name "xtb_tests_capi" -type f -delete
	find . -name "xtb-tester" -type f -delete
	find . -name "mctc-lib-tester" -type f -delete
	find . -name "rmsd-tester" -type f -delete
	find . -name "rmsd-tool-exe" -type f -delete
#rm -rf  *.o *.a *.so *~ *.mod xtb

%.o: %.c
	$(CC) $(INC) $(CFLAGS) -c $< -o $@

%.o: %.f
	$(FC) $(FPFLAGS) $(INC) $(F77FLAGS) -c $< -o $@
	
%.o: %.F
	$(FC) $(FPFLAGS) $(INC) $(F77FLAGS) -c $< -o $@

%.o: %.f90
	$(FC) $(FPFLAGS) $(INC) $(FFLAGS) -c $< -o $@
	
%.o: %.F90
	$(FC) $(FPFLAGS) $(INC) $(FFLAGS) -c $< -o $@

