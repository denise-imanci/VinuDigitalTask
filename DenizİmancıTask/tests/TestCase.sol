// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Remix test kütüphanesi
import "remix_tests.sol";

// Test edilecek kontratları içe aktar
import "../contracts/SimpleAccount.sol";
import "../contracts/TestToken.sol";
import "../contracts/Paymaster.sol";

// TestCase: test senaryolarını içeren kontrat
contract Ballot_test {
    // Kullanılacak kontratların değişken tanımı
    SimpleAccount public simpleAccountA;
    TestToken public testToken;
    Paymaster public paymaster;

    // Testte kullanılacak adresler
    address A;
    address B;
    address X;

    /// beforeAll: Remix bu fonksiyonu testlerden önce otomatik çalıştırır
    function beforeAll() public {
        // A, B ve X adresleri test için atanıyor
        A = address(0x1);         // Kullanıcı A
        B = address(0x2);         // Kullanıcı B
        X = address(this);        // Sponsor test kontratı

        // SimpleAccount sözleşmesini A adresi için deploy et
        simpleAccountA = new SimpleAccount(A);

        // TestToken  deploy et, A'ya 1000 token veriliyor
        testToken = new TestToken(1000 * 10**18);

        // Paymaster kontratını sponsor X adresi ile deploy et
        paymaster = new Paymaster(X);

        // Sponsor'a (yani bu kontrata) 1 ether gönderilerek gas fee sağlayıcı olarak fonlanıyor
        payable(X).transfer(1 ether);
    }

    /// testTokenTransfer: A'dan B'ye token transfer testidir
    function testTokenTransfer() public {
        uint256 amount = 10 * 10**18; // Transfer edilecek token miktarı

        // A adresinin bakiyesi 1000 olmalı (ilk dağıtım kontrolü)
        Assert.equal(testToken.balanceOf(A), 1000 * 10**18, "Anin token bakiyesi 1000 olmali");

        // A'dan B'ye token transferi yapılır
        // SimpleAccount bu örnekte doğrudan transfer fonksiyonu barındırmadığı için,
        // doğrudan testToken kontratının transfer fonksiyonu çağrılıyor
        bool sent = testToken.transfer(B, amount); // A'dan B'ye gönder

        // Transfer başarılı olmalı
        Assert.ok(sent, "Transfer basarili olmali");

        // B'nin yeni bakiyesi doğru olmalı
        Assert.equal(testToken.balanceOf(B), amount, "Bnin bakiyesi artmali");

        // A'nın bakiyesi doğru şekilde azalmış olmalı
        Assert.equal(testToken.balanceOf(A), 1000 * 10**18 - amount, "Anin bakiyesi azalmali");
    }

    /// Bu kontratın ether alabilmesi için fallback receive fonksiyonu
    receive() external payable {}
}
