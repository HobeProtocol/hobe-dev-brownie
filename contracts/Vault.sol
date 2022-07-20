// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {

    /*//////////////////////////////////////////////////////////////
                               VARIABLES & EVENTS
    //////////////////////////////////////////////////////////////*/

    address public factory;
    address public implementation;

    event implementationIsSet(address);
    event AddedValuesByDelegateCall(address vault, bool success);


    /*//////////////////////////////////////////////////////////////
                               MODIFIERS
    //////////////////////////////////////////////////////////////*/


    modifier onlyFactory() {
        require(msg.sender == factory, "onlyFactory()");
        _;
    }

    /*//////////////////////////////////////////////////////////////
                               INIT
    //////////////////////////////////////////////////////////////*/

    constructor(address _implementation) public {
        implementation = _implementation;
        factory = msg.sender;
    }


    /*//////////////////////////////////////////////////////////////
                               READS
    //////////////////////////////////////////////////////////////*/



    function setImplementation(address _implementation) external {
        implementation = _implementation;
        emit implementationIsSet(_implementation);
    }

    function getImplementation() external view returns(address){
        return implementation;
    }


    /*//////////////////////////////////////////////////////////////
                               WRITES
    //////////////////////////////////////////////////////////////*/


    function testDelegateCallPricePerShare(address _vault) external returns(uint256){
        (bool success, bytes memory returnedData) = implementation.delegatecall(
        abi.encodeWithSignature("getYearnPricePerShare(address)", _vault)
        );
        require(success, "delegateCall failed");

        emit AddedValuesByDelegateCall(_vault, success);
        return abi.decode(returnedData, (uint256));
    }
}