// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Vault.sol";

contract Factory {
    event Deployed(address addr);



    function deploy(address _vault_code, address _implementation) public {
        require(_vault_code != address(0), "No implementation contract address specified.");
        require(_implementation != address(0), "No implementation contract address specified.");

        // clone vault instance
        address vault_addr;
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000)
            mstore(add(ptr, 0x14), shl(0x60, _vault_code))
            mstore(add(ptr, 0x28), 0x5af43d82803e903d91602b57fd5bf30000000000000000000000000000000000)
            vault_addr := create(0, ptr, 0x37)
        }
        require(vault_addr != address(0), "ERC1167: create failed");

        // set necessary params
        Vault(vault_addr).init(_implementation);

        // events
        emit Deployed(vault_addr);
    }
}
