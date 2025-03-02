-include .env

build: forge build

deploy-sepolia:
	forge script script/DeployFundMe.s.sol --rpc-url $(SEPOLIA_URL) --private-key $(SEPOLIA_PRIVATE_KEY) --verify $(ETHERSCAN_API_KEY) --broadcast

deploy-anvil:
		forge script script/DeployFundMe.s.sol --rpc-url $(ANVIL_URL) --private-key $(ANVIL_PRIVATE_KEY) --broadcast
