//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "./metadata/ERC1155OnChainMetadata.sol";

contract PosterFactory is ERC1155OnChainMetadata {
    using CountersUpgradeable for CountersUpgradeable.Counter;
    // Index of current PosterID.
    CountersUpgradeable.Counter private tokenId;
    // Mapping of PosterID => Creator.
    mapping(uint256 => address) public creator;
    // Mapping of PosterID => # of Editions.
    mapping(uint256 => uint256) public posterSupply;
    // Mapping of PosterID => Max # of Editions.
    mapping(uint256 => uint256) public posterMaxSupply;
    // Mapping of PosterID => Royalty Recipient.
    mapping(uint256 => address) public royaltyRecipient;

    function initialize(string memory uri_) external initializer {
        __ERC1155_init(uri_);
        __Context_init();
        __ERC165_init();
    }

    /**
     * @dev Creates a new token type and assigns _maxSupply to an address
     * NOTE: remove onlyOwner if you want third parties to create new tokens on your contract (which may change your IDs)
     * @param _initialOwner address of the first owner of the token
     * @param _initialRoyaltyRecipient address of the first recipient of royalty payments
     * @param _maxSupply amount to supply the first owner
     * @return The newly created token ID
     */
    function createGiveaway(
        address _initialOwner,
        address _initialRoyaltyRecipient,
        uint256 _maxSupply
    ) external payable returns (uint256) {
        tokenId.increment();
        uint256 id = tokenId.current();
        creator[id] = msg.sender;
        royaltyRecipient[id] = _initialRoyaltyRecipient;

        // emit URI(uri(id), id);

        _mint(_initialOwner, id, 1, "");
        posterSupply[id] = 1;
        posterMaxSupply[id] = _maxSupply;
        return id;
    }
}
