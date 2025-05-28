// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract TestToken {
    // Token adı
    string public name = "Test USD";
    // Token sembolü
    string public symbol = "TUSD";
    // Standart basamak sayısı
    uint8 public decimals = 18;
    // Toplam token arzı
    uint256 public totalSupply;

    // Her adresin token bakiyesini tutan mapping
    mapping(address => uint256) public balanceOf;
    // Bir adresin diğer adreslere verdiği harcama izinlerini tutan mapping
    mapping(address => mapping(address => uint256)) public allowance;

    // Kurucu fonksiyon (deploy edilirken çağrılır)
    // initialSupply parametresi ile toplam arz belirlenir
    constructor(uint256 initialSupply) {
        totalSupply = initialSupply;
        // Deploy eden adresin bakiyesine toplam arz atanır
        balanceOf[msg.sender] = totalSupply;
    }

    // Token transferi yapan fonksiyon
    function transfer(address to, uint256 amount) external returns (bool) {
        // Gönderenin yeterli bakiyesi olup kontrol edilir
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        // Gönderenin bakiyesi azaltılır
        balanceOf[msg.sender] -= amount;
        // Alıcının bakiyesi artırılır
        balanceOf[to] += amount;
        // İşlem başarılı ise true döner
        return true;
    }

    // Başka birinin hesabından token harcama izni vermek için fonksiyon
    function approve(address spender, uint256 amount) external returns (bool) {
        // msg.sender'ın spender adresine harcama izni vermesi
        allowance[msg.sender][spender] = amount;
        // İşlem başarılı ise true döner
        return true;
    }

    // İzin verilen adresten token transferi yapmak için fonksiyon
    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        // Gönderenin yeterli bakiyesi olup kontrol edilir
        require(balanceOf[from] >= amount, "Insufficient balance");
        // msg.sender'ın izin verilen miktarı aşmaması kontrol edilir
        require(allowance[from][msg.sender] >= amount, "Not allowed");
        // Gönderenin bakiyesi azaltılır
        balanceOf[from] -= amount;
        // Alıcının bakiyesi artırılır
        balanceOf[to] += amount;
        // İzin verilen miktar güncellenir (kullanılan miktar düşürülür)
        allowance[from][msg.sender] -= amount;
        // İşlem başarılı ise true döner
        return true;
    }
}
