# TronBox TRC-20 Bitirme Projesi

Bu proje, TRON test ağına dağıtılabilen standart ve sabit arzlı bir TRC-20 token içerir.

- Ad: `fUSDT`
- Sembol: `fUSDT`
- Decimal: `6`
- Cüzdanda görünen toplam arz: `250.000 fUSDT`
- Zincirdeki ham toplam arz: `250000000000`
- İlk arzın tamamı: sözleşmeyi dağıtan cüzdana gider
- Transfer: standart `transfer` ve `transferFrom` fonksiyonlarıyla desteklenir
- Ek token üretme, vergi, kara liste, durdurma veya sahip yetkisi: yoktur

> Bu proje eğitim amacıyla test ağında kullanılmak üzere hazırlanmıştır. Private key için yalnızca ayrı bir test cüzdanı kullanın.

## 1. Gerekenler

- Node.js 18 veya üzeri
- TronLink tarayıcı eklentisi
- Shasta ya da Nile test ağına ait ücretsiz test TRX

## 2. Kurulum (Windows PowerShell)

Proje klasöründe terminal açın:

```powershell
npm install
Copy-Item .env.example .env
```

`.env` dosyasına yalnızca test cüzdanınızın private key değerini yazın:

```text
PRIVATE_KEY_SHASTA=BURAYA_TEST_CUZDANI_PRIVATE_KEY
PRIVATE_KEY_NILE=
```

`.env` dosyasını kimseyle paylaşmayın ve GitHub'a yüklemeyin.

## 3. Derleme ve test

```powershell
npm run compile
npm test
```

## 4. Shasta test ağına dağıtma

Önce TronLink'te Shasta ağına geçin ve aynı test cüzdanına faucet üzerinden test TRX alın. Ardından:

```powershell
npm run deploy:shasta
```

Terminal çıktısındaki `GraduationToken` sözleşme adresini (`T...`) kopyalayın.

Nile kullanmak isterseniz `.env` içindeki `PRIVATE_KEY_NILE` alanını doldurup şu komutu çalıştırın:

```powershell
npm run deploy:nile
```

## 5. Token'ı TronLink'te gösterme

1. TronLink'in dağıtım yaptığınız test ağında olduğundan emin olun.
2. Varlık ekleme (`+`) bölümünü açın.
3. Terminalde verilen TRC-20 sözleşme adresini aratın veya özel token olarak ekleyin.
4. Dağıtımı yapan cüzdanda `250,000 fUSDT` görünür.

Token hemen aramada görünmezse sözleşmeyi ilgili test ağı TRONSCAN sayfasında açın ve indekslenmesi için kısa süre bekleyin. Ad, sembol ve decimal değerleri sözleşmeden otomatik okunabilir.

## 6. Başka cüzdana gönderme

TronLink'te `fUSDT` token'ını açıp `Send` seçin, hedef TRON adresini (`T...`) ve görünen token miktarını girin. Gönderim işlemi test ağında Energy/Bandwidth tüketir; bu nedenle gönderen cüzdanda bir miktar test TRX bulunmalıdır.

Örnek: `1.5 fUSDT`, sözleşme seviyesinde `1500000` temel birime eşittir.

## Token adını değiştirme

Dağıtımdan önce `contracts/GraduationToken.sol` içindeki şu iki değeri değiştirin:

```solidity
string public constant name = "fUSDT";
string public constant symbol = "fUSDT";
```

Sonra tekrar `npm run compile` çalıştırın. Dağıtımdan sonra ad, sembol, decimal ve toplam arz değiştirilemez.
