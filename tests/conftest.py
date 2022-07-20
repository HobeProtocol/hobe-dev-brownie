import brownie
import pytest
from pathlib import Path


def pytest_addoption(parser):
    parser.addoption("--mainnet-fork", action="store_true", help="run forked mainnet tests")


def pytest_configure(config):
    if config.getoption("--mainnet-fork"):
        brownie.network.connect("mainnet-fork")
    else:
        brownie.network.connect("development")

@pytest.fixture(scope="function", autouse=True)
def isolation():
    brownie.chain.snapshot()
    yield
    brownie.chain.revert()


@pytest.fixture(scope="session")
def alice():
    yield brownie.accounts[0]


@pytest.fixture(scope="session")
def bob():
    yield brownie.accounts[1]