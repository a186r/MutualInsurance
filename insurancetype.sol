pragma solidity ^0.4.19;

import "./ownable.sol";
import "./safemath.sol";

contract insurancetype is Ownable{

    function insurancetype(){

    }

    using SafeMath for uint256;

    struct Insurance{
        uint insuranceFee;
        uint insuranceId;
        string insuranceContent;
        string typeOf;
    }

    Insurance[] public insurances;

    mapping (uint => address) public insuranceToOwner;
    mapping (address => uint) public ownerInsuranceCount;

}
