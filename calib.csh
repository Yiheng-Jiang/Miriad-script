#!/bin/csh -f

rm -r group_0747

mkdir group_0747

cd group_0747

atlod in=../2024-12-06_2240.C3634 out=2240.uv ifsel=1 options=birdie,rfiflag,noauto,xycorr

atlod in=../2024-12-07_0208.C3634 out=0208.uv ifsel=1 options=birdie,rfiflag,noauto
,xycorr

atlod in=../2024-12-07_0537.C3634 out=0537.uv ifsel=1 options=birdie,rfiflag,noauto
,xycorr

atlod in=../2024-12-07_0747.C3634 out=0747.uv ifsel=1 options=birdie,rfiflag,noauto
,xycorr

atlod in=../2024-12-06_1912.C3634 out=1912.uv ifsel=1 options=birdie,rfiflag,noauto
,xycorr

foreach names (2240 0208 0537 0747 1912)
    uvflag vis=$names.uv edge=40 flagval=flag
    rm -r $names
    mkdir $names
    cd $names
    uvsplit vis=../$names.uv
    cd ../
end

cd 0747

mfcal vis=1934-638.5500

pgflag vis=1934-630.5500 stokes=xx,yy device=/xs command=<b

blflag vis=1934-638.5500 device=/xs stokes=xx,yy axis=chan,amp options=nofqav,nobase

gpcal = 1934-638.5500 interval=0.1 nfbin=1 options=xyvary

cd ../

foreach names (2240 0208 0537 1912)
    cd $names
    gpcopy vis=../0747/1934-638.5500 out=1646-50.5500

    pgflag vis=1646-50.5500 stokes=xx,yy device=/xs command=<b

    blflag vis=1646-50.5500 device=/xs stokes=xx,yy axis=chan,amp options=nofqav,nobase

    blflag vis=1646-50.5500 device=/xs stokes=xx,yy axis=chan,amp options=nofqav,nobase
    
    gpcal vis=1646-50.5500 interval=0.1 nfbin=1 options=xyvary,qusolve

    gpboot vis=1646.50.5500 cal=../1043/1934-638.5500

    gpcopy vis=1646-50.5500 out=potoroo.5500

    gpaver vis=potoroo.5500 interval=2

    pgflag vis=potoroo.5500 stokes=xx,yy device=/xs command=<b

    blflag vis=potoroo.5500 device=/xs stokes=xx,yy axis=chan,amp options=nofqav,nobase
    blflag vis=potoroo.5500 device=/xs stokes=xx,yy axis=chan,amp options=nofqav,nobase
    uvaver vis=potoroo.5500 out=potoroo.uvaver.5500
    cd ../
end
