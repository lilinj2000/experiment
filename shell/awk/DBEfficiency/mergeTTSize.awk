BEGIN{ 
 temp="";
 } 
{ 
 if(temp==""){
 temp=$1;
 printf "%s\t",$3
   } 
 else
 {    
  if(temp==$1)
  { 
  printf "%s\t",$3 
  } 
  else 
  { 
  #temp=$1
  printf "%s\n",$3
  } 
 } 
} 
END{ 
printf "\n" 
} 

