#!/bin/sh

for file in `find . \( -name '*.hh' -o -name '*.cc' \)`
do
 sed -i 's/connection\/message\/FSCMessage.hh/asynconn\/message\/Message.hh/g' $file
 sed -i 's/connection\/message\/FSCXmlMessage.hh/asynconn\/message\/XmlMessage.hh/g' $file
 sed -i 's/connection\/message\/FSCBinaryMessage.hh/asynconn\/message\/BinaryMessage.hh/g' $file
 sed -i 's/connection\/message\/FSCStringMessage.hh/asynconn\/message\/StringMessage.hh/g' $file
 sed -i 's/connection\/message\/FSCStatisticsMessage.hh/asynconn\/message\/StatisticsMessage.hh/g' $file
 sed -i 's/connection\/message\/FSCHttpMessage.hh/asynconn\/message\/HttpMessage.hh/g' $file
 sed -i 's/connection\/FSCReceiverAsync.hh/asynconn\/Receiver.hh/g' $file
 sed -i 's/connection\/FSCReceiverSync.hh/asynconn\/Receiver.hh/g' $file
 sed -i 's/connection\/FSCSender.hh/asynconn\/Sender.hh/g' $file
 sed -i 's/connection\/FSCSenderPool.hh/asynconn\/SenderPool.hh/g' $file
 sed -i 's/connection\/FSCSenderPoolEx.hh/asynconn\/SenderPoolEx.hh/g' $file
 sed -i 's/flexconnclient\/FSCFlexConnClient.hh/asynconn\/FlexConnClient.hh/g' $file
 sed -i 's/FSCStringMessage/asynconn::StringMessage/g' $file
 sed -i 's/FSCBinaryMessage/asynconn::BinaryMessage/g' $file
 sed -i 's/FSCStatisticsMessage/asynconn::StatisticsMessage/g' $file
 sed -i 's/FSCXmlMessage/asynconn::XmlMessage/g' $file
 sed -i 's/FSCHttpMessage/asynconn::HttpMessage/g' $file
 sed -i 's/FSCMessage/asynconn::Message/g' $file
 sed -i 's/FSCSenderPool/asynconn::SenderPool/g' $file
 sed -i 's/FSCReceiverAsync/asynconn::Receiver/g' $file
 sed -i 's/FSCReceiverSync/asynconn::Receiver/g' $file
 sed -i 's/FSCSender/asynconn::Sender/g' $file
 sed -i 's/FSCFlexConnClient/asynconn::FlexConnClient/g' $file
 sed -i 's/myasynconn::/my/g' $file
 sed -i 's/theasynconn::/the/g' $file
done


for file in `find . -name Makefile -print`
do
 sed -i 's/-lfscconnection/-lasynconnection -lconnmessage/g' $file
 sed -i 's/-lfscflexconnclient//g' $file
 sed -i 's/-lfschttpserver//g' $file
 sed -i 's/-lfschttpclient//g' $file
 sed -i 's/-lfschttpclientasync//g' $file
 sed -i 's/-lfscsocket//g' $file
done
