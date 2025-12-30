#!/bin/csh -f

uvcat vis='1609/j1358.uvaver.5500,1937/j1358.uvaver.5500,2305/j1358.uvaver.5500,0234/j1358.uvaver.5500' out=j1358.all.5500

set n=0
rm -fr $n.uv
uvaver vis=j1358.all.5500 out=$n.uv stokes=i,q,u,v
puthd in=0.uv/interval value=0.2
set ro=0.4
set ce=0.8
set im=350
set f=3
set su=60
foreach stokes (q u v)
  rm -rf $n."$stokes"cmp $n."$stokes"map $n."$stokes"cln
end
rm -fr $n.imap 5beam $n.icmp $n.icln $n.imodel
invert vis=$n.uv map=$n.imap,$n.qmap,$n.umap,$n.vmap cell=$ce imsize=$im robust=$ro stokes=i,q,u,v options=mfs,double beam=5beam
mosmem map=$n.imap beam=5beam out=$n.icmp niters=400 |tail -2
restor model=$n.icmp beam=5beam map=$n.imap out=$n.icln
