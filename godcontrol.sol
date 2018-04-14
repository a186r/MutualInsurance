pragma solidity ^0.4.0;

import "./ownable.sol";

contract GodControl is Ownable{
    function GodControl(){

    }

    event ContractUpgrade(address newContract);

    address public godAddress;

    bool public paused = false;

    modifier onlyGod(){
        require(msg.sender == godAddress);
        _;
    }

    function _setGod(address _newGodAddress){
        require(_newGodAddress != address(0));
        godAddress = _newGodAddress;
    }

    modifier whenNotPaused(){
        require(!paused);
        _;
    }

    modifier whenPaused(){
        require(paused);
        _;
    }

    function pause() external onlyGod whenNotPaused{
        paused = true;
    }

    function unpause() external onlyGod whenPaused{
        paused = false;
    }
}
