// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    uint256 private s_tokenCounter = 0;
    string private s_sadSVGImageURi;
    string private s_happySVGImageURi;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory sadSVGImageURi, string memory happySVGImageURi) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_happySVGImageURi = happySVGImageURi;
        s_sadSVGImageURi = sadSVGImageURi;
    }

    function mintNFT() public {
        //read this function to understand safemint

        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySVGImageURi;
        } else {
            imageURI = s_sadSVGImageURi;
        }

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            // previous string memory tokenMetadata = string.concat(
                            '{"name":"',
                            name(),
                            '", "description": "NFT reflecting the mood.", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image": "',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
