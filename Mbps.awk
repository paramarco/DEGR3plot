#
# Awk script to extract DECR Mbps for the SDD test
#
BEGIN {
}

{

  beginingOfDate = index($1, "[");
  unformatedDated = substr($1, beginingOfDate + 1 , 10);
  
  sizeOfTime = length($2);
  unformatedTime = substr($2, 0 , sizeOfTime - 1 );
  
  formattedDate = unformatedDated  "-"  unformatedTime; 
  Mbps = $NF;
  print formattedDate" "Mbps;
   
}

END {
  
}
