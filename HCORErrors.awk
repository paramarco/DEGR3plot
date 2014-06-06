#
# Awk script to extract DECR HCOR errors for the SDD test
#
BEGIN {
 NumberOfPacketLost = 0;
}

{
  beginingOfDate = index($1, "[");
  unformatedDated = substr($1, beginingOfDate + 1 , 10);
  
  sizeOfTime = length($2);
  unformatedTime = substr($2, 0 , sizeOfTime - 1 );
  
  formattedDate = unformatedDated  "-"  unformatedTime; 

  if ($NF > NumberOfPacketLost ){
	subtraction = $NF - NumberOfPacketLost;
	NumberOfPacketLost = $NF;
	print formattedDate" "subtraction;
  } 
}

END {
  
}
