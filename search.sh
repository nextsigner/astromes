#!/bin/bash
MES=$2
DIA=$1
ANIO=$3
ASCSEARCH=''
function is(){
v1=0
v2=0
for i in $1 ;
do
#mv -- "$i" "${i:0:5}" ;
p1=" ${i:0:20}"
if(($v1>0))
then
#echo "EEE#####################---->"$p1
if [[ $p1 =~ " 0$SIGNO".* ]]; then
#echo "ARIES-->#####################---->"$p1
ASCSEARCH=$p1
echo "$p1"
v2=1
fi
break
fi
if [[ $p1 =~ .*Asce:.* ]]; then
#echo "#####################---->"$p1
v1=$v1+1
fi
if(($v2>0))
then
break
fi
done
echo ""
}

function getSign(){
SIGNO=$1
horas=''
for (( var=0; var<=23; var++ ))
do
v1=0
if(($var<10))
then
horas=$horas' 0'$var
else
horas=$horas' '$var
fi
done
horasComp=''
for hora in $horas
do
for (( min=0; min<=59; min+=1 ))
do
if(($min<10))
then
horasComp=$hora':0'$min
else
horasComp=$hora':'$min
fi
#echo $horasComp
#/home/ns/astrolog/astrolog -qa 2 1 2020 $horasComp 0 0.0 0.0
datos=$(./astrolog/astrolog -qa $MES $DIA $ANIO $horasComp 0 0.0 0.0>&1)
ASC=$(is "$datos")
#echo "RET: $ASC"
if [[ $ASC =~ " 0$SIGNO".* ]]; then
#echo "ARIES-->#####################---->"$p1
echo "$ASC $DIA/$MES/$ANIO $horasComp"
v1=1
break
fi
done
if(($v1>0))
then
break
fi
done
}
#is "asa aa fadsfdsadf asdf s sdfas sd"
getSign Ari
getSign Tau
getSign Gem
getSign Can
getSign Leo
getSign Vir
getSign Lib
getSign Sco
getSign Sag
getSign Cap
getSign Aqu
getSign Pis
exit;
