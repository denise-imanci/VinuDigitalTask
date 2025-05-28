 VINU DIGITAL-Account Abstraction & Meta Transaction Sponsorship System Task

Proje Hakkında

Bu proje, ERC-4337 Account Abstraction standardını kullanarak, Sepolia testnet üzerinde meta transaction sponsorship sistemini gerçekleştirmektedir.  
Ana hedef, A cüzdanından B cüzdanına token transferi yapılırken, gas ücretlerinin X (sponsor) cüzdanından kesilmesidir.



İçerikler

- SimpleAccount.sol: ERC-4337 uyumlu, basit bir account contract  
- Paymaster.sol: Gas sponsorship için paymaster contract  
- TestToken.sol: Basit ERC-20 token implementasyonu  
- Deployment Scriptleri: Kontratların Sepolia’ya deploy edilmesi  
- Testler: Transfer ve sponsorship işlevselliğini doğrulayan kapsamlı test senaryoları



Kullanılan Teknolojiler

- Solidity 0.8.18  
- Hardhat framework  
- ethers.js kütüphanesi  
- Sepolia Ethereum Testnet  
- ERC-4337 Account Abstraction Standardı


Proje Özeti ve Akış

1. SimpleAccount Contract: Kullanıcıların hesaplarını ERC-4337 uyumlu şekilde temsil eder.  
2. Paymaster Contract: Sponsor cüzdan olarak, sponsorun bakiyesinden gas ücretlerini karşılar.  
3. TestToken Contract: ERC-20 token işlevselliği sağlar, transfer işlemleri için kullanılır.  
4. Meta Transaction Oluşturma: UserOperation nesnesi ile transfer işlemi başlatılır.  
5. Test Senaryosu:  
   - A cüzdanı (SimpleAccount) oluşturulur  
   - B cüzdanı oluşturulur  
   - X sponsor cüzdanı oluşturulur ve ETH yüklenir  
   - TestToken A’ya mint edilir  
   - A’dan B’ye token transferi yapılır, gas ücretleri X’den düşülür  
   - İşlem başarıyla doğrulanır

Proje Kurulumu

bash
git clone https://github.com/denise-imanci/VinuDigitalTask
cd VinuDigitalTask
npm install
npx hardhat compile
npx hardhat test

Sepolia testnet’e deploy etmek için .env dosyasına private key ve RPC URL bilgilerini ekleyin, ardından:

bash
npx hardhat run scripts/deploy.js --network sepolia



Projeyi çalıştırmak ve test senaryosunu görmek için:

bash
npx hardhat test
Ya da scripts/demo.js dosyasını kullanarak adım adım demo yapabilirsiniz.

Yapılan Bonus Görevler
-Batch Operations
-Gas Limit Optimization

Projeyle ilgili tüm sorularınız için bana ulaşabilirsiniz.
