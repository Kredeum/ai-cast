import fs from 'fs-extra';

const mergeAbis = async () => {
  const addresses = await fs.readJSON('./addresses.json');
  const deployedContracts: any = {};

  for (const [chainId, contracts] of Object.entries(addresses)) {
    deployedContracts[chainId] = {};

    for (const [contractName, address] of Object.entries(contracts as any)) {
      if (contractName === "chainName") break;
      const json = await fs.readJSON(`./out/${contractName}.sol/${contractName}.json`);

      deployedContracts[chainId][contractName] = {
        address, abi: json.abi
      }

    }
    console.log("deployedContracts[Number ~ deployedContracts:", deployedContracts);
    await fs.writeJSON('./deployedContracts.json', deployedContracts, { spaces: 2 });
  }
}

mergeAbis().catch(console.error);