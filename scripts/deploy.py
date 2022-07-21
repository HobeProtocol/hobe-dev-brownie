from web3 import Web3
from brownie import *
import time

def main():
    deployer = accounts[0]

    implementation = YearnPort.deploy({'from': deployer})
    vault_example = Vault.deploy({'from': deployer})
    factory = Factory.deploy({'from': deployer})

    # deploy vault
    deployTx = factory.deploy(vault_example,implementation,{'from':deployer})
    vault_addr = deployTx.events['Deployed']['addr']
    vault = Vault.at(vault_addr)
    # check we passed implementation right
    assert implementation == vault.implementation()

    tx = vault.testDelegateCallPricePerShare("0xF29AE508698bDeF169B89834F76704C3B205aedf", {'from': deployer})
    res = tx.events['Test']['test']
    print("delegateCall: ", res)

    #print("pricePerShare is: ", yearnPort.getYearnPricePerShare("0xF29AE508698bDeF169B89834F76704C3B205aedf", {'from': deployer}))
    time.sleep(0.1)


