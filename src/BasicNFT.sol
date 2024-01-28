// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 tokenId => string tokenUri) private s_tokenIdtoUri;

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory tokenUri) public {
        s_tokenIdtoUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter); //
        s_tokenCounter++;
    }

    //tokenURI function exists is in ERC721 (has virtual keyword so I use override) and takes a tokenId as a parameter
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_tokenIdtoUri[tokenId];
    }
}
