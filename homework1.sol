pragma solidity ^0.4.18;

contract Math2 {
    int256 number1=0;

    function GetState()  public returns (int256 result) {
        return number1;    }

    function Reset()  public {
        number1=0;    }

    function Add(int256 number2)  public returns (int256 result) {
        number1+=number2;  
        return number1;   }
    
    function Substract(int256 number2)  public returns (int256 result){
        number1-=number2;    
        return number1;   }
    
    function Multiply(int256 number2)  public returns (int256 result){
        number1*=number2;    
        return number1;   }
    
    function Divide(int256 number2)  public returns (int256 result){
        number1/=number2;    
        return number1;   }
    
    function Power(uint256 number2)  public returns (int256 result){
        if(number2 % 2 == 1)
            number1=(-1)*(int256(uint256(-1*number1)**number2)); 
        else
            number1=(int256(uint256(number1)**number2));    
        return number1;       }
    
    function Reminder(int256 number2)  public returns (int256 result){
        number1=number1%number2;    
        return number1;   }
}
