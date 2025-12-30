#!/bin/csh -f
set n=0
rm -fr $n.uv
uvaver vis=potoroo.all.5500 out=$n.uv stokes=i,q,u,v
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

set m = $n
@ n = ( $n + 1 )
foreach stokes (q u v)
  rm -rf $n."$stokes"cmp $n."$stokes"map $n."$stokes"cln
end
rm -fr $n.uv; mkdir $n.uv
cp $m.uv/{gains,header,history} $n.uv/
cp -l $m.uv/{flags,vartable,visdata} $n.uv/
selfcal vis=$n.uv model=$m.icmp interval=2 refant=3 options=ph,mfs
rm -fr $m.icmp.dmos* $n.imap $n.icmp $n.icln $n.imodel 
invert vis=$n.uv map=$n.imap,$n.qmap,$n.umap,$n.vmap cell=$ce imsize=$im robust=$ro stokes=i,q,u,v options=mfs,double
mosmem map=$n.imap beam=5beam out=$n.icmp niters=400 | tail -2
restor model=$n.icmp beam=5beam map=$n.imap out=$n.icln 

set m = $n
@ n = ( $n + 1 )
foreach stokes (i q u v)
  rm -rf $n."$stokes"cmp $n."$stokes"map $n."$stokes"cln
end
rm -fr $n.uv; mkdir $n.uv
cp $m.uv/{gains,header,history} $n.uv/
cp -l $m.uv/{flags,vartable,visdata} $n.uv/
selfcal vis=$n.uv model=$m.icmp interval=2 refant=3 options=ph,mfs
rm -fr $m.icmp.dmos* $n.imap $n.icmp $n.icln $n.imodel 
invert vis=$n.uv map=$n.imap,$n.qmap,$n.umap,$n.vmap cell=$ce imsize=$im robust=$ro stokes=i,q,u,v options=mfs,double
mosmem map=$n.imap beam=5beam out=$n.icmp niters=400 |tail -2
restor model=$n.icmp beam=5beam map=$n.imap out=$n.icln 
set m = $n
@ n = ( $n + 1 )
foreach stokes (i q u v)
  rm -rf $n."$stokes"cmp $n."$stokes"map $n."$stokes"cln
end
rm -fr $n.uv; mkdir $n.uv
cp $m.uv/{gains,header,history} $n.uv/
cp -l $m.uv/{flags,vartable,visdata} $n.uv/
selfcal vis=$n.uv model=$m.icmp interval=2 refant=3 options=ph,mfs
rm -fr $m.icmp.dmos* $n.imap $n.icmp $n.icln $n.imodel 
invert vis=$n.uv map=$n.imap,$n.qmap,$n.umap,$n.vmap cell=$ce imsize=$im robust=$ro stokes=i,q,u,v options=mfs,double
mosmem map=$n.imap beam=5beam out=$n.icmp niters=400 |tail -2
restor model=$n.icmp beam=5beam map=$n.imap out=$n.icln 

set m = $n
@ n = ( $n + 1 )
foreach stokes (i q u v)
  rm -rf $n."$stokes"cmp $n."$stokes"map $n."$stokes"cln
end
rm -fr $n.uv; mkdir $n.uv
cp $m.uv/{gains,header,history} $n.uv/
cp -l $m.uv/{flags,vartable,visdata} $n.uv/
selfcal vis=$n.uv model=$m.icmp interval=2 refant=3 options=ph,mfs
rm -fr $m.icmp.dmos* $n.imap $n.icmp $n.icln $n.imodel
invert vis=$n.uv map=$n.imap,$n.qmap,$n.umap,$n.vmap cell=$ce imsize=$im robust=$ro stokes=i,q,u,v options=mfs,double
mosmem map=$n.imap beam=5beam out=$n.icmp niters=400 |tail -2
restor model=$n.icmp beam=5beam map=$n.imap out=$n.icln

set m = $n
@ n = ( $n + 1 )
foreach stokes (i q u v)
  rm -rf $n."$stokes"cmp $n."$stokes"map $n."$stokes"cln
end
rm -fr $n.uv; mkdir $n.uv
cp $m.uv/{gains,header,history} $n.uv/
cp -l $m.uv/{flags,vartable,visdata} $n.uv/
selfcal vis=$n.uv model=$m.icmp interval=2 refant=3 options=amplitude,mfs
rm -fr $n.qmap,$n.umap,$n.vmap $n.qcmp,$n.ucmp,$n.vcmp
rm -fr $n.imap point$n.res $n.icmp cgcurs.region $n.icln point$n.icln point$n.imodel point.region
invert vis=$n.uv map=$n.imap,$n.qmap,$n.umap,$n.vmap cell=$ce imsize=$im robust=$ro stokes=i,q,u,v options=mfs,double #fwhm=5
mosmem map=$n.imap beam=5beam out=$n.icmp |tail -2
pmosmem map=$n.imap,$n.qmap,$n.umap,$n.vmap beam=5beam out=$n.imodel,$n.qcmp,$n.ucmp,$n.vcmp niters=400
restor model=$n.icmp beam=5beam map=$n.imap out=$n.icln #fwhm=3
foreach stokes (q u v)
  restor model=$n."$stokes"cmp beam=5beam map=$n."$stokes"map out=$n."$stokes"cln >> /dev/null
end
