pragma solidity ^0.8.0;

import {ERC20} from "../lib/solmate/src/tokens/ERC20.sol";
import {SafeTransferLib} from "../lib/solmate/src/utils/SafeTransferLib.sol";

import {Factory} from "./Factory.sol";
import {IYearn} from "../interfaces/Yearn/IYearn.sol";

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

    function getYearnUnderlyingToken(address vault) public view returns(ERC20){
        // @return The underlying token in the YearnVault
        return ERC20(IYearn(vault).token());
    }

    function getYearnPricePerShare(address vault) public view returns(uint256){
        // @notice Computes the latest yield value for a yearn vault.
        // @return The latest yield value
        IYearn yearnVault = IYearn(vault);
        return (yearnVault.pricePerShare());
    }


    function setSomething(uint256 _something) external onlyFactory {
      something = _something;
    }

    function deposit() external {
    }

    function _invest() internal {
      // берет текущие балансы accepted_tokens и депозитит фармиться
    }

    function balanceOf(address) public {
      // возвращает искаженное число токенов которое можно конвертировать в инвестицию
    }
}

