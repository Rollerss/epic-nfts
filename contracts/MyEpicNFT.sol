// SPDX-License-Identifier: UNLICENSE

pragma solidity ^0.8.0;

import { Base64 } from "./libraries/Base64.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    //string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string svgPartOne = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='";
    string svgPartTwo = "'/><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string[] colors = ["red", "#08C2A8", "black", "yellow", "blue", "green"];

    string[] firstWords = ["Time","Person","Year","Way","Day","Thing","Man","World","Life","Hand","Part","Child","Eye","Woman","Place","Work","Week","Case","Point","Government","Company","Number","Group","Problem","Fact"];

    string[] secondWords = ["Be","Have","Do","Say","Get","Make","Go","Know","Take","See","Come","Think","Look","Want","Give","Use","Find","Tell","Ask","Work","Seem","Feel","Try","Leave","Call"];

    string[] thirdWords = ["Good","New","First","Last","Long","Great","Little","Own","Other","Old","Right","Big","High","Different","Small","Large","Next","Early","Young","Important","Few","Public","Bad","Same","Able"];

    event NewEpicNFTMinted(address sender, uint256 tokenId);

    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Woah!");
    }

    function random(string memory input) internal pure returns (uint256){
        return uint256(keccak256(abi.encode(input)));
    }

    function pickRandomWords(string memory seed) public view returns (uint256){
        return random(string(abi.encodePacked(seed, Strings.toString(_tokenIds.current()), Strings.toString(block.timestamp))));
    } 

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        string memory first = firstWords[pickRandomWords("FIRST_WORD") % firstWords.length];
        string memory second = secondWords[pickRandomWords("SECOND_WORD") % secondWords.length];
        string memory third = thirdWords[pickRandomWords("THIRD_WORD") % thirdWords.length];
        string memory combinedWords = string(abi.encodePacked(first, second, third));

        string memory color = colors[pickRandomWords("COLOR") % colors.length];
        string memory finalSvg = string(abi.encodePacked(svgPartOne, color, svgPartTwo, combinedWords, "</text></svg>"));

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "', combinedWords,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory finalTokenUri = string(abi.encodePacked("data:application/json;base64,", json));

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);

        _setTokenURI(newItemId, finalTokenUri);
        //"https://drive.google.com/file/d/1jPPH4Fwlz1IBDPCxfQj_0UAhT9ngHJWQ/view?usp=sharing");

        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

        _tokenIds.increment();

        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

        emit NewEpicNFTMinted(msg.sender, newItemId);
    }
}