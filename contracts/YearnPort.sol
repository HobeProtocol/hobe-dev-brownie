// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "./../lib/solmate/src/tokens/ERC20.sol";
import {SafeTransferLib} from "./../lib/solmate/src/utils/SafeTransferLib.sol";

import {Factory} from "./Factory.sol";
import {IYearn} from "./../interfaces/IYearn.sol";

    /*
    * @title YearnPort
    * @notice The implementation for Yearn vaults
    */

contract YearnPort {

    using SafeTransferLib for ERC20;

    uint256 public totalSupply;

    address public factory;
    uint256 public something;
    bool private _init_done = false;
    address[] accepted_tokens;

    mapping (address => uint256) user_to_ids;


    modifier onlyFactory() {
      require(msg.sender == factory, "onlyFactory()");
      _;
    }

    modifier updateMaxFixed() {

      _;
    }

    constructor () public {
      factory = msg.sender;
    }

    /*
     * Getters
     */

    // @return The underlying token in the YearnVault
    function getYearnUnderlyingToken(address vault) public view returns(ERC20){
        return ERC20(IYearn(vault).token());
    }

    // @notice Computes the latest yield value for a yearn vault.
    // @return The latest yield value
    function getYearnPricePerShare(address vault) public view returns(uint256){
        IYearn yearnVault = IYearn(vault);
        return (yearnVault.pricePerShare());
    }



    function setSomething(uint256 _something) external onlyFactory {
      something = _something;
    }

    // @notice Deposit underlying into vault
    function deposit(uint256 underlyingAmount, address vault) external returns (uint256){
        return IYearn(vault).deposit(underlyingAmount);
    }

    // @notice Converts vault shares to underlying tokens.
    function withdraw(uint256 vaultSharesAmount, address recipient, address vault) external returns(uint256){
        if (vaultSharesAmount == 0) {
            return 0;
        }
         return IYearn(vault).withdraw(vaultSharesAmount, recipient);
    }


    function _invest() internal {
      // берет текущие балансы accepted_tokens и депозитит фармиться
    }

    function balanceOf(address) public {
      // возвращает искаженное число токенов которое можно конвертировать в инвестицию
    }
}

