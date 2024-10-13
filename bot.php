<?php
/**
 * JasperAzerbaijan
 *
 * Elgün İsmayıloff tərəfindən hazırlandı. 
 * Rahatlıqla istifadə edə bilərsiniz
 * 
 * @elgunismayiloff
 * 
 */
$host = 'localhost'; // HOST
$db = 'your_database'; // DBNAME
$user = 'your_username'; // DBUSER
$pass = 'your_password'; // DBPASSWORD

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Bazaya bağlantı xətası: " . $e->getMessage();
    exit;
}


// POST istəyini yoxlayaq
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Formdan datanı alaq
    $imdbID = $_POST['imdb_id'];
    $embedCode = $_POST['embed_code'];

    // API açarı və IMDB ID'sini ayarlayaq
    $apiKey = "key";
    $url = "http://www.omdbapi.com/?apikey=$apiKey&i=$imdbID&plot=full";

    // cURL ile veri çekme
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);

    $response = curl_exec($ch);
    if ($response === false) {
        // cURL xətası
        header('Content-Type: application/json');
        echo json_encode(['status' => 'error', 'message' => 'cURL xətası: ' . curl_error($ch)]);
        exit;
    }

    // Gələn cavabı yoxlayın
    $data = json_decode($response, true);
    if (json_last_error() !== JSON_ERROR_NONE) {
        // JSON xətası
        header('Content-Type: application/json');
        echo json_encode(['status' => 'error', 'message' => 'JSON xətası: ' . json_last_error_msg()]);
        exit;
    }

    // API-dən gələn datanı yoxlayaq
    if (isset($data['Error'])) {
        header('Content-Type: application/json');
        echo json_encode(['status' => 'error', 'message' => 'API xətası: ' . $data['Error']]);
        exit;
    }

    // Filmin məlumatlarını alırıq
    $title = isset($data['Title']) ? $data['Title'] : 'Bilinmir';
    $release_year = isset($data['Year']) ? $data['Year'] : 'Bilinmir';
    $imdb_rating = isset($data['imdbRating']) ? $data['imdbRating'] : 'N/A';
    $poster = isset($data['Poster']) && $data['Poster'] != 'N/A' ? $data['Poster'] : 'No Image Available';
    $description = isset($data['Plot']) ? $data['Plot'] : 'Açıqlama yoxdur';
    $runtime = isset($data['Runtime']) ? $data['Runtime'] : 'Bilinmir';
    $awards = isset($data['Awards']) ? $data['Awards'] : 'Yoxdur';

    try {
        // Filmi əlavə edirik bazaya
        $stmt = $pdo->prepare("INSERT INTO films (title, release_year, imdb_rating, poster, description, embed_code, runtime, awards) 
                                VALUES (:title, :release_year, :imdb_rating, :poster, :description, :embed_code, :runtime, :awards)");
        $stmt->bindParam(':title', $title);
        $stmt->bindParam(':release_year', $release_year);
        $stmt->bindParam(':imdb_rating', $imdb_rating);
        $stmt->bindParam(':poster', $poster);
        $stmt->bindParam(':description', $description);
        $stmt->bindParam(':embed_code', $embedCode);
        $stmt->bindParam(':runtime', $runtime);
        $stmt->bindParam(':awards', $awards);
        $stmt->execute();

        header('Content-Type: application/json');
        echo json_encode(['status' => 'success', 'message' => 'Film Treyleri Uğurla Əlavə Olundu!']);
    } catch (PDOException $e) {
        header('Content-Type: application/json');
        echo json_encode(['status' => 'error', 'message' => 'Xəta: ' . $e->getMessage()]);
    }

    curl_close($ch);
    exit; // İstək sonlanmalıdır
}
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Treyler Botu</title>
    <!-- Tailwind CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- SweetAlert CSS və JS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-lg">
        <h2 class="text-2xl font-bold mb-6 text-center">Treyler Botu</h2>
        <form id="trailerForm" method="POST" action="">
            <div class="mb-4">
                <label for="imdb_id" class="block text-sm font-medium text-gray-700">IMDB ID:</label>
                <input type="text" id="imdb_id" name="imdb_id" required 
                       class="mt-1 block w-full p-2 border border-gray-300 rounded-md shadow-sm focus:ring focus:ring-blue-500" placeholder="IMDB ID'sini girin">
            </div>
            <div class="mb-6">
                <label for="embed_code" class="block text-sm font-medium text-gray-700">Embed Iframe Kodu:</label>
                <textarea id="embed_code" name="embed_code" required 
                          class="mt-1 block w-full p-2 border border-gray-300 rounded-md shadow-sm focus:ring focus:ring-blue-500" rows="4" placeholder="Embed kodunu buraya yapışdırın"></textarea>
            </div>
            <div>
                <button type="submit" 
                        class="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50">
                    Əlavə et
                </button>
            </div>
        </form>
    </div>

    <script>
        document.getElementById('trailerForm').addEventListener('submit', function(e) {
            e.preventDefault(); // Formu dayandıraq
            const formData = new FormData(this);

            // AJAX istəyi göndəririk
            fetch('', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    swal("Uğurlu!", data.message, "success");
                } else {
                    swal("Xəta!", data.message, "error");
                }
            })
            .catch(error => {
                swal("Xəta!", "Bir xəta yarandı: " + error.message, "error");
            });
        });
    </script>
</body>
</html>
