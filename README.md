# AI cast

AI Cast : PolyMarket by AI , create question / bet on answer / resolved by  AI  via Chainlink


## SETUP

1. Setup Chainlink
On `https://functions.chain.link/sepolia`
- Get subscription Id
- Fund deployer address with some LINK

2. Setup environnment variables
In `.env`file
- ETHEREUM_SEPOLIA_RPC_URL
- OPENAI_API_KEY
- PRIVATE_KEY

## DEPLOY
3. Deploy AI Cast contract to Sepolia

In `script/deploy/DeployAIcast.sol` ;
- set subscription Id = 3275;
- set Sepolia router = 0xb83E47C2bC239B3bf370bc41e1459A34b41238D0;
- set gasLimit = 300000;
- set donID = 0x66756e2d657468657265756d2d7365706f6c69612d3100000000000000000000;

```sh
$ pnpm run deploy:sepolia
````
get deployed address

4. Add deploy contract address to Chainlink subscription

On `https://functions.chain.link/sepolia`

5. Deploy secretly OpenAI Key to DON

```sh
$ cd chainlink/request

$ node 5-use-secrets-threshold.js
````
get `donHostedSecretsVersion` value in return


## RUN
6. Run AI Cast on Sepolia

In `script/send/AIcastRequest.sol` ;
- set `donHostedSecretsVersion`
- set your prompt

```sh
$ pnpm run func
````

7. Get result

On `https://functions.chain.link/sepolia`

On Sepolia explorer

