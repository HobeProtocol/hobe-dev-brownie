from web3 import Web3
from brownie import *

def main():
    deployer = accounts[0]

    yearnPort = YearnPort.deploy({'from': deployer})
    factory = Factory.deploy({'from': deployer})


    bytecode = factory.getCreationBytecode(yearnPort.address, {'from':deployer}) # create hobeVault bytecode
    deployTx = factory.deploy(bytecode, {'from':deployer}) # deploy a hobeVault

    hobeVaultAddr = deployTx.events['Deployed']['addr'] # get hoveVault address

    hobeVault = Vault.at(hobeVaultAddr)
    print("Defined impl in constructor is: ", hobeVault.getImplementation({'from':deployer}))

    # tx = hobeVault.setImplementation(yearnPort, {'from':accounts[1]}) implementation already defined in hobeVault constructor
    #print(tx.events) # check event of setImplementation


    print("delegateCall: ", hobeVault.testDelegateCallPricePerShare("0xF29AE508698bDeF169B89834F76704C3B205aedf", {'from':accounts[0]}))

    #print("pricePerShare is: ", yearnPort.getYearnPricePerShare("0xF29AE508698bDeF169B89834F76704C3B205aedf", {'from': deployer}))


