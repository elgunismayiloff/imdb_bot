# IMDB Trailer Botudur

Funksiyaları bundan ibarətdir:

IMDB-də olan filmin id-i yazaraq və youtube-dan filmin treyler iframe kodunu köçürüb botumuza yapışdıraraq "Əlavə et" butonuna kliklədikdə artıq hər şey hazır olur.

Bot omdbapi.com saytı ilə işləyir. Bu sayta daxil olaraq özünüzə məxsus apiKey açarı əldə edərək botun kodlarına əlavə edirsiniz.

 Bu skript, IMDB-dən film məlumatlarını çəkməyə və bu məlumatları verilənlər bazasına (database) əlavə etməyə imkan tanıyır.
 Skript, PDO (PHP Data Objects) istifadə edərək MySQL verilənlər bazası ilə əlaqə yaradır.
 try-catch blokları ilə, bağlantı zamanı xətalar aşkarlandıqda müvafiq mesaj göstərilir.
 Skript, formdan göndərilən məlumatların POST metodu ilə gəlib-gəlmədiyini yoxlayır.
 Əgər POST metodu ilə gəlmişsə, IMDB ID və embed kodunu formdan alır.
 curl istifadə edərək OMDb API-dən (Open Movie Database API) film məlumatlarını çəkmək üçün HTTP GET istəyi göndərir.
 API açarı və IMDB ID'si URL-yə əlavə edilir.
 Cavab alındıqda, xətalar üçün yoxlama aparılır.
 API-dən alınan məlumatlar (film adı, buraxılış ili, IMDB reytinqi, poster, açıqlama, müddət və mükafatlar) müvafiq dəyişənlərə saxlanılır.
 Məlumatlar, films adlı cədvələ əlavə edilir. Bu proses prepared statements ilə həyata keçirilir ki, bu da SQL injeksiya hücumlarına qarşı müdafiə yaradır.
 Veb səhifənin dizaynı üçün Tailwind CSS və SweetAlert kitabxanaları istifadə olunur.
 Form, istifadəçinin IMDB ID'sini və embed iframe kodunu daxil edə biləcəyi iki giriş sahəsi ehtiva edir.
 Form göndərildikdə, AJAX (Asynchronous JavaScript and XML) vasitəsilə məlumatlar serverə göndərilir.
 JavaScript istifadə edərək formun göndərilməsi dayandırılır (e.preventDefault()), sonra FormData ilə məlumatlar toplanır.
 fetch API istifadə edərək POST istəyi göndərilir. Cavab JSON formatında alındıqda, istifadəçiyə SweetAlert ilə müvafiq mesaj göstərilir.

# İstifadə olunan texnologiyalar

PHP, PDO, cURL, Ajax, Javascript, Tailwind CSS və SweetAlert

İstifadə olunan texnologiyalar, kodun təhlükəsizliyini və istifadəçi təcrübəsini artırır.

Yalnız təhsil məqsədli yazılımdır. Necə istifadəsindən məsuliyyət daşımıram.
