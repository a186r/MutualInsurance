pragma solidity ^0.4.19;

import "./ownable.sol";
import "./safemath.sol";

contract InsuranceType is Ownable{

    function InsuranceType(){

    }

    using SafeMath for uint256;

    event newInsurance (uint insuranceId,uint insuranceFee,string insuranceName,string insuranceContent);

    struct Insurance{
        uint insuranceFee;
        uint insuranceId;
        string insuranceContent;
        string typeOf;
    }

    Insurance[] public insurances;

    mapping (uint => address) public insuranceToOwner;
    mapping (address => uint) public ownerInsuranceCount;

    function _joinInsurance(uint insuranceId,uint insuranceFee,string insuranceName,string insuranceContent) internal {
        insurances.push(Insurance(insuranceId,insuranceFee,insuranceContent,insuranceName));
    }


}
