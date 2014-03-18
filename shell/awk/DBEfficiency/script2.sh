#!/bin/sh

echo "Creating the cgicell inserting SQL"
#!/bin/sh

i=0 
echo "There are following tables:"
echo "mpctrigger.GEOMETRY"
echo "mpctrigger.TriggerInfo"
echo "mpctrigger.GMPC_List"
echo "mpctrigger.AnyPhoneInfo"
echo "mpctrigger.reg_list"
echo "mpctrigger.Subscriber"
echo "mpcupparallel.UPPARALLELTRANSACTION"
echo "mpcwireline.LOCATION"
echo "mpclicenseadm.capacity"
echo "mpclicenseadm.transaction"
echo "mpclicense.Capacity"
echo "mpclicense.Transaction"
echo "mpclicense.Transactionused"
echo "mpclicense.Token"
echo "mpccgi.CGICell"
echo "mpcsai.SAICell"
echo "mpcsai.SAIGeometry"
echo "mpcmsue.MSUECapability"
echo "mpcplmn.PLMN"
echo "mpcpsap.PSAP"
printf "Please input which table do you want to collect with format user.tablename(such as mpccgi.cgicell):"
read Table
printf "Please input how many rows there will be in the table:"
read Number
printf "Please input what is the step for the samples(for example 1000 rows):"
read Step

printf "Do you want to delete all the datas in table first(y|n):"
read Delete

Sample=`expr $Number / $Step`
echo "there will be $Number rows in the $Table, use $Step as step, there will be $Sample samples"
rm /export/home/oracle/$Table.script2.txt
rm /export/home/oracle/$Table.script2.log


case $Table in 
	mpccgi.cgicell|mpccgi.CGICell)
	MCC=550
	MNC=44
	LAC=1
	CI=1
	UID=mpccgi
	;;
	mpctrigger.Subscriber|mpctrigger.subscriber)
	MSISDN=14680070200
	UID=mpctrigger
	;;
	*)
	echo "$Table is not supported yet"
	exit ;;
esac

if [ $Delete != n ]
	then 
echo "DELETE FROM $Table;" > $Table.SQL
/opt/TimesTen/mpc/bin/ttIsqlCS -connStr "DSN=mpc1;UID=$UID;PWD=$UID" -f /export/home/oracle/$Table.SQL -v 4 
fi

while [ $i -lt $Number ]
do
rm /export/home/oracle/$Table.SQL
i=`expr $i + $Step`
echo "Create $Step Rows data"
m=0
while [ $m -lt $Step ]
do

	m=`expr $m + 1`
	
	case $Table in 
	mpccgi.cgicell|mpccgi.CGICell)

	if [ $CI -ge 1000 ]
	then 
		LAC=`expr $LAC + 1`
		CI=1
	else	
		CI=`expr $CI + 1`
	fi
	
	echo "INSERT INTO mpccgi.cgicell(MCC,MNC,LAC,CI,PositioningMethods,MNCLength,Accmin,AntennaType,BSPWR,BSC,CellDir,TALim,SectorAngle,MaxCellRadius,Latitude,Longitude,SITE,Altitude,CELL,AntennaGain,AntennaTilt,BCC,BCCHNO,BSPWRB,CSYSType,CellType,EnvChar,Height,SiteLatitude,SiteLongitude,MaxAltitude,MinAltitude,NCC,DegreesOfLatitude,DegreesOfLongitude,StartAngle,StopAngle,CellRadius,GPSWeek,GPSTOW,GSMFN,GPSRefTimeUncert,OverrideTA) VALUES ($MCC,$MNC,$LAC,$CI,0,2,100,1,45,'RNCKS2',90,55,120,75000,'N60-00-00','E22-00-00','BTS$LAC',50,'$CI',NULL,NULL,NULL,NULL,NULL,1,NULL,0,50,'N60-00-00','E22-00-00',1000,0,NULL,60,22,30,150,73424,NULL,NULL,NULL,126,0);">> /export/home/oracle/$Table.SQL
	;;
	mpctrigger.Subscriber|mpctrigger.subscriber)

	
	MSISDN=`expr $MSISDN + 1`

	
	echo "INSERT INTO mpctrigger.subscriber(MSISDN,IMSI,MSCAddress,EventTime,PerformTriggerCheck,NextFLUReqAcc,FLUTime,FLUInterval,MBR_X_Max,MBR_Y_Max,MBR_X_Min,MBR_Y_Min,ObtainedAccuracy,RequestedAccuracy,Shape,Network,UsedLocationMethod) VALUES ($MSISDN, '1194680070209', '4620112345', 1224737842, 0, NULL, 1224737902, 60, 25000, 25000, -25000, -25000, 2500, 2500, '0000000300000004000000000000000000000000000061A8', 1, 1);">> /export/home/oracle/$Table.SQL
	;;
	esac
done
echo "$Step Rows Data has been generated, now starting to import data"
/opt/TimesTen/mpc/bin/ttIsqlCS -connStr "DSN=mpc1;UID=$UID;PWD=$UID" -f /export/home/oracle/$Table.SQL -v 4 >> /export/home/oracle/$Table.script2.log

echo "Count $i rows"
ttSize -tbl $Table -connstr "dsn=mpc;uid=mpcdbadm;pwd=mpcdbadm;"  >> /export/home/oracle/$Table.script2.txt

done


rm $Table.script2.statistics.txt
/usr/xpg4/bin/grep -E 'Rows =|Total =' /export/home/oracle/$Table.script2.txt > $Table.script2.statistics.txt
echo "******************************"
echo "******************************"
echo "******************************"
echo "The counting result is:"
cat $Table.script2.statistics.txt
