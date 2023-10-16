class Solution {
  bool divisorGame(int n) {
    bool alice=false;
    while(n != 0){
      int div=mostLargeDiv(n);
      if(div==0){
        return alice;
      }
      n-=div;
      alice=!alice;
    }
   return alice;
  }
  int mostLargeDiv(int n){
    for(int i=n~/2;i>0;i--){
      if(n%i==0){
        return i;
      }
    }
    return 0;
  }
}