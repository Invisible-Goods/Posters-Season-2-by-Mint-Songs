//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/interfaces/IERC2981Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "./metadata/ERC1155OnChainMetadata.sol";

contract PosterFactory is ERC1155OnChainMetadata, IERC2981Upgradeable {
    // Index of current PosterID.
    CountersUpgradeable.Counter private tokenId;
    // Price to mint 1 poster.
    uint256 public weiPerPoster;

    using CountersUpgradeable for CountersUpgradeable.Counter;
    using SafeMathUpgradeable for uint256;

    function initialize(
        uint256 weiPerPoster_,
        string memory name_,
        string memory symbol_,
        string memory contract_description_,
        string memory contract_image_,
        string memory contract_external_link_,
        uint256 contract_seller_fee_basis_points_,
        address royaltyRecipient_
    ) external initializer {
        __ERC1155_init("");
        __Context_init();
        __ERC165_init();
        name = name_;
        symbol = symbol_;
        contract_description = contract_description_;
        contract_image = contract_image_;
        contract_external_link = contract_external_link_;
        contract_seller_fee_basis_points = contract_seller_fee_basis_points_;
        contract_fee_recipient = royaltyRecipient_;
        weiPerPoster = weiPerPoster_;
    }

    /**
     * @dev checks caller can create a new poster.
     * @param _maxSupply amount to supply the first owner
     */
    modifier createPreCheck(uint256 _maxSupply) {
        uint256 price = weiPerPoster * _maxSupply;
        require(
            msg.value >= price,
            string(
                abi.encodePacked(
                    "msg.value too low. required cost: ",
                    StringsUpgradeable.toString(price),
                    " wei"
                )
            )
        );
        _;
    }

    /**
     * @dev Creates a new Poster.
     * @param _name name of token
     * @param _description description of token
     * @param _imageUri imageUri of token
     * @param _royaltyRecipient address of the first recipient of royalty payments
     * @param _maxSupply amount to supply the first owner
     * @return tokenId newly created token ID
     */
    function createPoster(
        string memory _name,
        string memory _description,
        string memory _imageUri,
        address _royaltyRecipient,
        uint256 _maxSupply
    ) external payable createPreCheck(_maxSupply) returns (uint256) {
        tokenId.increment();
        uint256 id = tokenId.current();
        uint256 initialSupply = 1;
        _mint(msg.sender, id, initialSupply, "");
        emit URI(_imageUri, id);
        Poster memory newPoster = Poster(
            msg.sender,
            _name,
            _description,
            _imageUri,
            initialSupply,
            _maxSupply,
            _royaltyRecipient
        );
        poster[id] = newPoster;
        return id;
    }

    /**
     * @dev Receiving native token (MATIC / ETH).
     */
    receive() external payable {}

    /**
     * @dev Receiving other ERC20 tokens.
     */
    fallback() external payable {}

    /**
     * @dev Withdrawing native token balance.
     */
    function withdraw() external {
        payable(contract_fee_recipient).transfer(address(this).balance);
    }

    /**
     * @dev Withdrawing ERC20 token balance.
     * @param _tokenContract ERC20 contract address.
     */
    function withdrawToken(address _tokenContract) external {
        IERC20Upgradeable tokenContract = IERC20Upgradeable(_tokenContract);

        tokenContract.transfer(
            contract_fee_recipient,
            tokenContract.balanceOf(address(this))
        );
    }

    /**
     * @dev See {IERC165-royaltyInfo}.
     */
    function royaltyInfo(uint256 _tokenId, uint256 _salePrice)
        external
        view
        override
        returns (address receiver, uint256 royaltyAmount)
    {
        require(poster[_tokenId].count > 0, "Nonexistent token");

        uint256 royaltyPayment = _calcRoyaltyPayment(_salePrice);

        return (poster[_tokenId].royaltyRecipient, royaltyPayment);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC1155Upgradeable, IERC165Upgradeable)
        returns (bool)
    {
        return
            interfaceId == type(IERC2981Upgradeable).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev Internal function calculate proportion of a fee for a given amount.
     *      _amount * fee / 100
     * @param _amount uint256 value to be split.
     */
    function _calcRoyaltyPayment(uint256 _amount)
        internal
        view
        returns (uint256)
    {
        return _amount.mul(contract_seller_fee_basis_points).div(1000);
    }
}
