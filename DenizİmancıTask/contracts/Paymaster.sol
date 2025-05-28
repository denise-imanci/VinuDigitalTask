// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./UserOperation.sol";

contract Paymaster {
    // Sponsor adresi 
    address public sponsor;

    // Constructor: deploy edilirken sponsor adresi belirlenir
    constructor(address _sponsor) {
        sponsor = _sponsor;
    }

    // UserOperation için sponsor tarafından yapılacak validasyon fonksiyonu
    // Bu fonksiyon UserOperation'u (kullanıcı işlemini) doğrulamak için kullanılır
    function validatePaymasterUserOp(UserOperation calldata userOp) external view returns (bool) {
        // Basit bir doğrulama örneği:
        // Paymaster kontratının bakiyesi en az 0.01 ether olmalı, yoksa revert edilir
        require(address(this).balance > 0.01 ether, "Insufficient balance");

        // Ayrıca UserOperation'daki maxFeePerGas 100 gwei'den küçük olmalı
        // Bu limit aşılırsa işlem onaylanmaz
        return userOp.maxFeePerGas < 100 gwei;
    }

    // Kontratın ETH alabilmesi için receive fonksiyonu (fallback)
    receive() external payable {}
}
