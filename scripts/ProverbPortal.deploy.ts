import { ethers } from "hardhat";

(async () => {
  try {
    const ProverbContract = await ethers.getContractFactory("ProverbPortal");
    const proverbContract = await ProverbContract.deploy();

    await proverbContract.deployed();

    console.log(`Contract deployed to: ${proverbContract.address}`);

    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
})();
