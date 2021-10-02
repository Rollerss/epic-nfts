const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log(
    "\x1b[44m",
    `Contract deployed to: ${nftContract.address}`,
    "\x1b[0m"
  );

  let txn = await nftContract.makeAnEpicNFT();
  await txn.wait();

  txn = await nftContract.makeAnEpicNFT();
  await txn.wait();

  //   console.log("\x1b[30m", "test");
  //   console.log("\x1b[31m", "test");
  //   console.log("\x1b[32m", "test");
  //   console.log("\x1b[33m", "test");
  //   console.log("\x1b[34m", "test");
  //   console.log("\x1b[35m", "test");
  //   console.log("\x1b[36m", "test");
  //   console.log("\x1b[37m", "test");
  //   console.log("\x1b[40m", "test");
  //   console.log("\x1b[41m", "test");
  //   console.log("\x1b[42m", "test");
  //   console.log("\x1b[43m", "test");
  console.log("\x1b[44m", "done", "\x1b[0m");
  //   console.log("testing the look");
  //   console.log("\x1b[45m", "test");
  //   console.log("\x1b[46m", "test");
  //   console.log("\x1b[47m", "test");
  //   console.log("\x1b[0m", "end test");
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();

/*
Reset =      "\x1b[0m"
Bright =     "\x1b[1m"
Dim =        "\x1b[2m"
Underscore = "\x1b[4m"
Blink =      "\x1b[5m"
Reverse =    "\x1b[7m"
Hidden =     "\x1b[8m"

FgBlack =   "\x1b[30m"
FgRed =     "\x1b[31m"
FgGreen =   "\x1b[32m"
FgYellow =  "\x1b[33m"
FgBlue =    "\x1b[34m"
FgMagenta = "\x1b[35m"
FgCyan =    "\x1b[36m"
FgWhite =   "\x1b[37m"

BgBlack =   "\x1b[40m"
BgRed =     "\x1b[41m"
BgGreen =   "\x1b[42m"
BgYellow =  "\x1b[43m"
BgBlue =    "\x1b[44m"
BgMagenta = "\x1b[45m"
BgCyan =    "\x1b[46m"
BgWhite =   "\x1b[47m"
*/
