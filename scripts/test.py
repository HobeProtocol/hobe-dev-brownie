from web3 import Web3
from brownie import *
import time


def main():
    #dai = Contract.from_explorer('0x6B175474E89094C44Da98b954EedeAC495271d0F')
    #time.sleep(1.5)
    #whale = accounts.at('0xe78388b4ce79068e89bf8aa7f218ef6b9ab0e9d0', force=True)

    deployer = accounts[0]

    factory = Factory.deploy({'from': deployer})
    factory.createVault({'from': deployer})
    Yearnvault = Vault.at(factory.testing_lastcreated())

    print("pricePerShare is: ", Yearnvault.getPricePerShare("0x986b4AFF588a109c09B50A03f42E4110E29D353F", {'from': deployer}))
