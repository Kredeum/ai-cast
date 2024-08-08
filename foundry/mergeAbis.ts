import fs from 'fs-extra';

const mergeAbis = async () => {
  const addresses = await fs.readJSON('./addresses.json');
  const deployedContracts: any = {};

  for (const [chainId, contracts] of Object.entries(addresses)) {
    for (const [contractName, address] of Object.entries(contracts as any)) {
      const jsonPath = `./out/${contractName}.sol/${contractName}.json`;
      if (!fs.existsSync(jsonPath)) continue;

      const abi = (await fs.readJSON(jsonPath)).abi;

      deployedContracts[chainId] ||= {};
      deployedContracts[chainId][contractName] = { address, abi }
    }
  }
  console.log("deployedContracts", deployedContracts);
  await fs.writeJSON('./deployedContracts.json', deployedContracts, { spaces: 2 });
}

mergeAbis().catch(console.error);