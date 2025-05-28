// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/// @custom:dev-run-script ./scripts/DEMO.js

contract SimpleAccount {
    // Cüzdan sahibinin adresi
    address public owner;

    // Kullanılan gas'ı loglamak için event
    event GasUsed(uint256 gasUsed);

    // Başarılı işlem çağrılarını loglamak için event
    event Executed(address to, uint256 value, bytes data);

    // Sadece owner'ın erişebileceği fonksiyonlar için modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner"); // Sadece owner izinli
        _;
    }

    // Kurucu fonksiyon: owner'ı ayarlar
    constructor(address _owner) {
        owner = _owner;
    }

    // Tek işlem gönderme fonksiyonu
    // Örneğin bir kontrata çağrı yapmak veya ether göndermek için
    function execute(address dest, uint256 value, bytes calldata func) external onlyOwner {
        uint256 startGas = gasleft(); // İşlem öncesi kalan gas'ı ölç

        // Belirtilen adrese, değerle birlikte fonksiyon çağrısı yap
        (bool success, ) = dest.call{value: value}(func);
        require(success, "Execution failed"); // Başarısızsa revert et

        uint256 gasUsed = startGas - gasleft(); // Kullanılan gas'ı hesapla
        emit GasUsed(gasUsed); // Event ile logla
        emit Executed(dest, value, func); // İşlemi logla
    }

    // Birden fazla işlemi tek çağrıda yapmak için batch fonksiyonu
    function executeBatch(address[] calldata dests, bytes[] calldata funcs) external onlyOwner {
        // Adres ve fonksiyon dizileri aynı uzunlukta olmalı
        require(dests.length == funcs.length, "Length mismatch");

        uint256 startGas = gasleft(); // Gas ölçümünü başlat

        // Her adres için ilgili fonksiyonu çağır
        for (uint256 i = 0; i < dests.length; i++) {
            (bool success, ) = dests[i].call(funcs[i]);
            require(success, "Batch tx failed"); // Her işlem başarılı olmalı
            emit Executed(dests[i], 0, funcs[i]); // Her başarılı işlemi logla
        }

        uint256 gasUsed = startGas - gasleft(); // Toplam gas kullanımını hesapla
        emit GasUsed(gasUsed); // Gas kullanımını logla
    }

    // Bu kontratın ETH alabilmesini sağlar 
    receive() external payable {}
}
