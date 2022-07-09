pragma solidity ^0.8.0;

import "./YearnPort.sol";

contract Factory {

    address public testing_lastcreated;

    function createVault() external returns (address) {
      address addr = _deployVault();
      testing_lastcreated = addr;
      Vault(addr).setSomething(222);
      return addr;
    }

    function _deployVault() internal returns (address) {
        address addr;
        bytes memory bytecode = type(Vault).creationCode;
        assembly {addr := create2(0, add(bytecode, 0x20), mload(bytecode), "")}
        require(addr != address(0), "Vault deploy failed");
        return addr;
    }
  }
