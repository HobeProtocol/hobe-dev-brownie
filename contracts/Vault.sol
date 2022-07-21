// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {

    /*//////////////////////////////////////////////////////////////
                               VARIABLES & EVENTS
    //////////////////////////////////////////////////////////////*/

    address public factory;
    address public implementation;
    bool private isInited;

    event implementationIsSet(address);
    event AddedValuesByDelegateCall(address vault, bool success);
    event Test(uint256 test);


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

    function init(address _implementation) external {
        require(!isInited,"no second init");
        factory = msg.sender;
        implementation = _implementation;
        isInited = true;
    }


    /*//////////////////////////////////////////////////////////////
                               READS
    //////////////////////////////////////////////////////////////*/




    function getImplementation() external view returns(address){
        return implementation;
    }


    /*//////////////////////////////////////////////////////////////
                               WRITES
    //////////////////////////////////////////////////////////////*/
    




    function testDelegateCallPricePerShare(address _vault) external {
        (bool success, bytes memory returnedData) = implementation.delegatecall(
        abi.encodeWithSignature("getYearnPricePerShare(address)", _vault)
        );
        require(success, "delegateCall failed");
        emit Test(abi.decode(returnedData, (uint256)));
    }
}

    /*//////////////////////////////////////////////////////////////
                               INTERNALS
    //////////////////////////////////////////////////////////////*/
    