pragma solidity ^0.4.0;

import "./insurancetype.sol";
import "./godcontrol.sol";
import "./safemath.sol";

contract ManageInsurance is GodControl{

    using SafeMath for uint;

    event newInsurance(uint _insuranceId,uint _insuranceFee,string _insuranceName);

    struct Insurance{
        uint insuranceFee;
        uint insuranceId;
        string insuranceName;
    }

    Insurance[] public insurances;

    mapping (uint => address) public insuranceToOwn;
    mapping (address => uint) ownerInsuranceCount;

    function createinsurance(uint _insuranceFee,string _insuranceName) internal onlyGod{
        uint id = insurances.push(Insurance(_insuranceFee,_insuranceName)) - 1;
        newInsurance(id,_insuranceFee,_insuranceName);
    }

    function joinInsurance(uint _insuranceId) public {
        insuranceToOwn[_insuranceId] = msg.sender;
        ownerInsuranceCount = ownerInsuranceCount.add(1);
    }

    function destoryinsurance(uint _insuranceId) internal onlyGod {
        insurances.remove(_insuranceId);
    }

}
