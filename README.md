# Avax4project

# DegenGamingToken

This is a simple ERC20 token that can be used for gaming purposes. It has the following features:

* Name: Degen
* Symbol: DGN
* Decimals: 18
* Total supply: 100,000,000 DGN

The token can be transferred, burned, and minted. It also has a redeem function that allows users to redeem their tokens for a prize.

## How to use

To use the DegenGamingToken, we need to first install the Solidity compiler. Once we have the compiler installed, we can compile the code by running the following command:


solc --optimize --bin --abi DegenGamingToken.sol


This will create two files: `DegenGamingToken.bin` and `DegenGamingToken.abi`. The `.bin` file contains the compiled bytecode of the contract, and the `.abi` file contains the ABI of the contract.

Once we have the compiled bytecode and ABI, we can deploy the contract to a blockchain. we can do this using a variety of tools, such as Truffle or Remix.

## Example

Here is an example of how to use the DegenGamingToken:


// Import the ABI of the contract
import "DegenGamingToken.abi";

// Create a contract instance
const contract = new web3.eth.Contract(DegenGamingToken.abi);

// Get the balance of an address
const balance = contract.balanceOf(address);

// Transfer tokens
contract.transfer(address, amount);

// Burn tokens
contract.burn(amount);

// Redeem tokens
contract.redeem(amount, prizeSelection);

## License

The DegenGamingToken is licensed under the MIT License.
