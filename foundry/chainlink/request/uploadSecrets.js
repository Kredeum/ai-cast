const { SecretsManager } = require("@chainlink/functions-toolkit");
const ethers = require("ethers");
require("@chainlink/env-enc").config();

const main = async () => {
  // Sepolia
  // const routerAddress = "0xb83E47C2bC239B3bf370bc41e1459A34b41238D0";
  // const donId = "fun-ethereum-sepolia-1";
  // const rpcUrl = process.env.ETHEREUM_SEPOLIA_RPC_URL;

  // Base Sepolia
  const routerAddress = "0xf9B8fc078197181C841c296C876945aaa425B278";
  const donId = "fun-base-sepolia-1";
  const rpcUrl = process.env.ETHEREUM_BASE_SEPOLIA_RPC_URL;

  const gatewayUrls = [
    "https://01.functions-gateway.testnet.chain.link/",
    "https://02.functions-gateway.testnet.chain.link/",
  ];

  const slotIdNumber = 0;
  const expirationTimeMinutes = 600; // expiration time in minutes of the secrets
  const secrets = { openaiKey: process.env.OPENAI_API_KEY };
  const privateKey = process.env.PRIVATE_KEY;

  if (!privateKey) throw new Error("private key not provided - check your environment variables");
  if (!rpcUrl) throw new Error(`rpcUrl not provided  - check your environment variables`);

  const provider = new ethers.providers.JsonRpcProvider(rpcUrl);
  const wallet = new ethers.Wallet(privateKey);
  const signer = wallet.connect(provider);

  // First encrypt secrets and upload the encrypted secrets to the DON
  const secretsManager = new SecretsManager({
    signer: signer,
    functionsRouterAddress: routerAddress,
    donId: donId,
  });
  await secretsManager.initialize();

  // Encrypt secrets and upload to DON
  const encryptedSecretsObj = await secretsManager.encryptSecrets(secrets);
  // console.log("main ~ encryptedSecretsObj\n", JSON.stringify(encryptedSecretsObj, null, 2));

  console.log(
    `Upload encrypted secret to gateways ${gatewayUrls}. slotId ${slotIdNumber}. Expiration in minutes: ${expirationTimeMinutes}`
  );
  // Upload secrets
  const uploadResult = await secretsManager.uploadEncryptedSecretsToDON({
    encryptedSecretsHexstring: encryptedSecretsObj.encryptedSecrets,
    gatewayUrls: gatewayUrls,
    slotId: slotIdNumber,
    minutesUntilExpiration: expirationTimeMinutes,
  });

  if (!uploadResult.success)
    throw new Error(`Encrypted secrets not uploaded to ${gatewayUrls}`);

  console.log(
    `\n✅ Secrets uploaded properly to gateways ${gatewayUrls}! Gateways response: `,
    uploadResult
  );
};

main().catch(console.error);
