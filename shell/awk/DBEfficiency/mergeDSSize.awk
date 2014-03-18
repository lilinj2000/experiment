BEGIN{ 
 temp="";
 } 
{ 
 if(temp==""){
 temp=$1;
 printf "%s\t",$2
   } 
 else
 {    
  if(temp==$1)
  { 
  printf "\n%s\t",$2
  } 
  else 
  { 
  #temp=$1
  printf "%s\t",$2
  } 
 } 
} 
END{ 
printf "\n" 
} 

