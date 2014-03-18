#!/bin/sh


for Table in `cat Tables`
do

rm ./$Table.txt
rm ./$Table.log
#rm ./$Table.dssize


echo "Start $Table `date` ..." > $Table.log ;

echo "TRUNCATE TABLE $Table;" > $Table.SQL

/opt/TimesTen/mpc/bin/ttIsqlCS -connStr "DSN=mpc1;UID=$UID;PWD=$UID" -f ./$Table.SQL -v 4 

ttSize -tbl $Table -connstr "dsn=mpc;uid=mpcdbadm;pwd=mpcdbadm;"  >> ./$Table.txt

#/opt/TimesTen/mpc/bin/ttIsqlCS -connStr "DSN=mpc1;UID=$UID;PWD=$UID" -f ./dssize.SQL -v 4 >> ./$Table.dssize

i=0 
while [ $i -lt 10 ]
do
	echo "start import data: `date` ..." >> $Table.log ;
case $Table in
	mpccgi.CGICell)

		ttbulkcp -i mpc $Table cgicell$i.data >> $Table.log

	;;

	mpcsai.SAICell)

		ttbulkcp -i mpc $Table saicell$i.data >> $Table.log

	;;

	mpcsai.SAIGeometry)

		ttbulkcp -i mpc $Table saigeometry$i.data >> $Table.log

	;;

	mpcmsue.MSUECapability)

		ttbulkcp -i mpc $Table msue$i.data >> $Table.log

	;;

	mpctrigger.GEOMETRY)

		ttbulkcp -i mpc $Table geometry$i.data >> $Table.log

	;;

	mpctrigger.Subscriber)

		ttbulkcp -i mpc $Table subscriber$i.data >> $Table.log

	;;

	mpcwireline.LOCATION)

		ttbulkcp -i mpc $Table location$i.data >> $Table.log

	;;

	mpctrigger.TriggerInfo)

		ttbulkcp -i mpc $Table triggerinfo$i.data >> $Table.log

	;;

	*)
	
		echo "$Table is not supported yet"
        	exit
	;;
esac
	echo "finish import data: `date` ..." >> $Table.log ;

	ttSize -tbl $Table -connstr "dsn=mpc;uid=mpcdbadm;pwd=mpcdbadm;"  >> ./$Table.txt

i=`expr $i + 1`

done

/opt/TimesTen/mpc/bin/ttIsqlCS -connStr "DSN=mpc1;UID=$UID;PWD=$UID" -f ./$Table.SQL -v 4 

#/opt/TimesTen/mpc/bin/ttIsqlCS -connStr "DSN=mpc1;UID=$UID;PWD=$UID" -f ./$Table.SQL -v 4 >> ./$Table.log

#/opt/TimesTen/mpc/bin/ttIsqlCS -connStr "DSN=mpc1;UID=$UID;PWD=$UID" -f ./dssize.SQL -v 4 >> ./$Table.dssize


rm $Table.statistics.txt
#rm $Table.statistics.dssize

/usr/xpg4/bin/grep -E 'Rows =|Total =' ./$Table.txt > $Table.statistics.txt

#/usr/xpg4/bin/grep -E 'PERM_ALLOCATED_SIZE:|PERM_IN_USE_SIZE:|PERM_IN_USE_HIGH_WATER:|TEMP_ALLOCATED_SIZE:|TEMP_IN_USE_SIZE:|TEMP_IN_USE_HIGH_WATER:' ./$Table.dssize > $Table.statistics.dssize

rm $Table.statistics.mergeTTSize
#rm $Table.statistics.mergeDSSize

awk -f mergeTTSize.awk $Table.statistics.txt > $Table.statistics.mergeTTSize
#awk -f mergeDSSize.awk $Table.statistics.dssize > $Table.statistics.mergeDSSize

echo "Finished $Table `date` ..." >> $Table.log ;

banner $Table

done

banner finished!
