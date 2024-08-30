
# 1. Ellenőrizzük, hogy az npm telepítve van-e
if (-not (Get-Command "npm" -ErrorAction SilentlyContinue)) {
    Write-Error "Az npm nincs telepítve. Kérlek, telepítsd az npm-t."
    exit
}

# 2. Ellenőrizzük, hogy a szükséges globális npm csomag (pl. http-server) telepítve van-e
$globalPackage = "http-server"
if (-not (npm list -g $globalPackage <#--depth 0 -ErrorAction SilentlyContinue#> )) {
    # 3. Ha a csomag nincs telepítve, telepítsük
    Write-Host "$globalPackage nincs telepítve. Telepítés..."
    npm install -g $globalPackage
}

# 4 vizsgáljuk meg hogy a globális npm csomagokat tartalmazó mappa benne van-e a PATH-ban
$npmGlobalPackagesPath = (npm config get prefix)
if ($env:path -notlike "*${npmGlobalPackagesPath}*") {
    Write-Host "A globális npm csomagokat tartalmazó mappa nincs a PATH-ban. Hozzáadás..."
    $env:path += ";${npmGlobalPackagesPath}"
}


# 5. Indítsuk el a statikus szerver csomagot a webalkalmazás könyvtárában
http-server -p 8080 -o