// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Vault.sol";

contract Factory {
    event Deployed(address addr);


    function getCreationBytecode(address _implementation) public pure returns (bytes memory) {
        require(_implementation != address(0), "No implementation contract address specified.");

        bytes memory bytecode = type(Vault).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_implementation));
    }

    function deploy(bytes memory bytecode) public {
        address addr;
        assembly {
            addr := create2(0, add(bytecode, 0x20), mload(bytecode),  "")

            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }
        emit Deployed(addr);
    }
}
