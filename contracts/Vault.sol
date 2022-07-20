// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
    address public factory;
    address public implementation;

    constructor(address _implementation) public {
        implementation = _implementation;
        factory = msg.sender;
    }

    modifier onlyFactory() {
        require(msg.sender == factory, "onlyFactory()");
        _;
    }


    event implementationIsSet(address);
    event AddedValuesByDelegateCall(address vault, bool success);

    function setImplementation(address _implementation) external {
        implementation = _implementation;
        emit implementationIsSet(_implementation);
    }

    function getImplementation() external view returns(address){
        return implementation;
    }


    function testDelegateCallPricePerShare(address _vault) external returns(uint256){
        (bool success, bytes memory returnedData) = implementation.delegatecall(
        abi.encodeWithSignature("getYearnPricePerShare(address)", _vault)
        );
        require(success, "delegateCall failed");

        emit AddedValuesByDelegateCall(_vault, success);
        return abi.decode(returnedData, (uint256));
    }
}