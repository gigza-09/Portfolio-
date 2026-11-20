# Downloads every image from the Figma "Moodboard > Portfolio - Final" page
# into assets\figma\<section>\, with readable names.
# The links expire soon after they were generated - run this right away:
#   powershell -ExecutionPolicy Bypass -File .\download-figma-assets.ps1
#
# For each layer you get:
#   <name>.png/.jpg          original full-resolution source image (largest one)
#   <name>-2.png, -3 ...     other source images inside the same layer (e.g. mockup frame + screen)
#   _previews\<name>.png     how the layer looks in the Figma design (cropped, 1x)

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$root = Join-Path $PSScriptRoot 'assets\figma'
$tmp  = Join-Path $root '_tmp'
New-Item -ItemType Directory -Force -Path $tmp | Out-Null

$items = @(
  @{ dir='showcase'; name='showcase-01-flowchart'; preview='https://www.figma.com/api/mcp/asset/7c7d526d-f766-4361-b0fc-aa82bb9f7d00.png'; raw=@('https://www.figma.com/api/mcp/asset/fc91b6d6-a94c-42fa-8e47-b16c2638f528','https://www.figma.com/api/mcp/asset/ccc1829d-9ce3-425e-a0ae-593ab61539e8') }
  @{ dir='showcase'; name='showcase-01-phone-mockup'; preview='https://www.figma.com/api/mcp/asset/8ea3b8d5-1c70-4904-ad1b-170a9ffad234.png'; raw=@('https://www.figma.com/api/mcp/asset/73532ab5-4e9c-46d2-ac24-c6ea1bcafad0','https://www.figma.com/api/mcp/asset/e1ac9330-dc3f-4132-98de-10dc9b26f367','https://www.figma.com/api/mcp/asset/f79e4d10-ae14-4895-93d2-cce7b948ecf6','https://www.figma.com/api/mcp/asset/61200795-8559-47b3-a9cd-fa7a3453158e') }
  @{ dir='showcase'; name='showcase-02-photo'; preview='https://www.figma.com/api/mcp/asset/d3a0f3b8-22ee-4c80-b777-73d28c973705.png'; raw=@('https://www.figma.com/api/mcp/asset/fefb9ec5-744a-45ea-b6d6-9606042e89a2','https://www.figma.com/api/mcp/asset/fbf24673-7129-4abd-8654-ff489c3400b3') }
  @{ dir='showcase'; name='showcase-02-chart-header'; preview='https://www.figma.com/api/mcp/asset/3016c7a9-b070-4212-84eb-0f7625920b66.png'; raw=@('https://www.figma.com/api/mcp/asset/23c15aca-f5ad-4650-b579-92eeb4f28a6e','https://www.figma.com/api/mcp/asset/337a4259-eea6-4960-8ee6-90230e6f8ea0') }
  @{ dir='showcase'; name='showcase-02-steps-chart'; preview='https://www.figma.com/api/mcp/asset/8216e500-5049-4a4e-8ea3-2bd666f107de.png'; raw=@('https://www.figma.com/api/mcp/asset/52d6c881-9bb1-4e12-b14f-e82a70131b6b','https://www.figma.com/api/mcp/asset/36e3d61e-e2fb-4198-99ae-39d34007d372') }
  @{ dir='showcase'; name='showcase-03-game-character'; preview='https://www.figma.com/api/mcp/asset/f8460d3f-b371-4e16-a28e-690e1e385952.png'; raw=@('https://www.figma.com/api/mcp/asset/00ffc080-2bfe-492e-8a83-c6c2b094767f','https://www.figma.com/api/mcp/asset/090a83ed-5f95-4a11-b77a-96a51c539c93') }
  @{ dir='showcase'; name='showcase-03-kid-photo'; preview='https://www.figma.com/api/mcp/asset/2945a50d-f49e-4541-be6b-2d0b0ed0b83a.png'; raw=@('https://www.figma.com/api/mcp/asset/b45948ea-3a2e-4cef-8015-eee4dd6fe824','https://www.figma.com/api/mcp/asset/068a844c-ebc6-4507-9c54-2f90959afe0e') }
  @{ dir='showcase'; name='showcase-03-phone-mockup'; preview='https://www.figma.com/api/mcp/asset/3ce0edd9-bda6-4482-8d41-082829ff7f73.png'; raw=@('https://www.figma.com/api/mcp/asset/a558b90e-6612-4814-bfca-2c1940df4b8a','https://www.figma.com/api/mcp/asset/aa1cd9fd-3b2e-43bb-81f4-1dd2fafbadd7','https://www.figma.com/api/mcp/asset/30ef29c5-d0c9-40a7-b5ce-682db51c17f5','https://www.figma.com/api/mcp/asset/5174a46d-c097-41e9-909a-50ff0c6c5a56') }
  @{ dir='showcase'; name='showcase-04-research-map'; preview='https://www.figma.com/api/mcp/asset/bb250bc9-d914-4b78-8f74-22d3761fe717.png'; raw=@('https://www.figma.com/api/mcp/asset/58b93230-9237-40f9-bae7-2fd188af07ee','https://www.figma.com/api/mcp/asset/e011388e-704c-43ee-bb7e-4fe8392e7dc2') }
  @{ dir='showcase'; name='showcase-04-imac-mockup'; preview='https://www.figma.com/api/mcp/asset/33324a52-46fc-463f-a581-9a8cf6638ce0.png'; raw=@('https://www.figma.com/api/mcp/asset/43c48de6-ebc8-4361-a7d8-0fcdbe64e387','https://www.figma.com/api/mcp/asset/a249c42f-2164-43d3-b614-ab8705aa939d','https://www.figma.com/api/mcp/asset/b267d201-4a7f-47c8-8bcc-aacfe86a4790','https://www.figma.com/api/mcp/asset/bc243b97-bc5d-47d5-83c5-677a0f44bf2a','https://www.figma.com/api/mcp/asset/c1f2086d-00ff-4349-8766-507dca677421','https://www.figma.com/api/mcp/asset/5850b14a-cc2a-4ba1-9e94-ab0aa7668d01','https://www.figma.com/api/mcp/asset/4d57d2b7-abc5-4af1-94a3-d15ece853641','https://www.figma.com/api/mcp/asset/a7b34a8f-5efb-45b1-927a-90e8fcea930d','https://www.figma.com/api/mcp/asset/ad50815e-e75e-41c1-909e-7238de9aedc7','https://www.figma.com/api/mcp/asset/d82f4b64-7ee2-4499-b96f-f7b6cef6b546','https://www.figma.com/api/mcp/asset/a0b5ffa0-6bca-4ba1-874f-b06e23638cc9','https://www.figma.com/api/mcp/asset/8fa068ce-6cfb-41b9-a5b3-ad764b465b6a','https://www.figma.com/api/mcp/asset/ee031fca-d2cf-49c7-8332-4b21b2cdd5b2','https://www.figma.com/api/mcp/asset/8f5ecbff-07d1-49db-9b4f-ca3fa905a791') }
  @{ dir='showcase'; name='showcase-05-loan-flow'; preview='https://www.figma.com/api/mcp/asset/5cef8903-d5a3-4b32-9951-aa7ff0c2e217.png'; raw=@('https://www.figma.com/api/mcp/asset/a40da593-f1f9-40fc-b0cb-22fbb7a314f3','https://www.figma.com/api/mcp/asset/470f533c-ece6-463c-bb32-c73ccd34e4f3') }
  @{ dir='showcase'; name='showcase-05-loan-screens'; preview='https://www.figma.com/api/mcp/asset/5e758229-d025-452b-ae06-efad1f18cee7.png'; raw=@('https://www.figma.com/api/mcp/asset/30eb7874-a2c0-4b68-8b60-6d18f08a7275','https://www.figma.com/api/mcp/asset/52669b2b-0c53-416c-9c3d-2c8c137e7319') }
  @{ dir='showcase'; name='showcase-06-chord-wheel-a'; preview='https://www.figma.com/api/mcp/asset/95b8b328-215c-4ff8-9a0f-221b25311c08.png'; raw=@('https://www.figma.com/api/mcp/asset/d0151550-36be-43bc-ad26-4ba715a4e2b8','https://www.figma.com/api/mcp/asset/a23a3ea6-9363-4634-baf3-864d4fd9eddd') }
  @{ dir='showcase'; name='showcase-06-chord-wheel-b'; preview='https://www.figma.com/api/mcp/asset/2d72f8aa-2fe1-4052-bd79-23b505e80dd7.png'; raw=@('https://www.figma.com/api/mcp/asset/7ae944ee-0120-4108-9284-bae1daa272ef','https://www.figma.com/api/mcp/asset/cedaefd0-f119-46eb-a014-572e35e47a24') }
  @{ dir='showcase'; name='showcase-07-arduino'; preview='https://www.figma.com/api/mcp/asset/fceb76cd-d8c5-40fb-84f2-2d896b076eb8.png'; raw=@('https://www.figma.com/api/mcp/asset/ebb77a1b-fb4e-4561-b14c-dbd3b96d0d94','https://www.figma.com/api/mcp/asset/e5e53e25-3023-4272-86c9-b41f4cbf0961') }
  @{ dir='showcase'; name='showcase-08-meow'; preview='https://www.figma.com/api/mcp/asset/eb83940e-6b54-4c1f-857e-3343491fa41a.png'; raw=@('https://www.figma.com/api/mcp/asset/3eba730e-c784-4e84-99c1-4077ed4a4a5f','https://www.figma.com/api/mcp/asset/29afaa45-d398-46d6-b08c-7c58729353e8','https://www.figma.com/api/mcp/asset/988eb4e3-354e-4831-9736-d6a0ebd026c6','https://www.figma.com/api/mcp/asset/9a21cf48-296a-4b92-8ea0-20beb04ad2f6') }
  @{ dir='showcase'; name='showcase-08-woof'; preview='https://www.figma.com/api/mcp/asset/2b6d521b-7f52-44cc-9198-03e0250cb582.png'; raw=@('https://www.figma.com/api/mcp/asset/dbff49ff-d029-4cef-a7f4-e233708783c8','https://www.figma.com/api/mcp/asset/4728a60b-5bb6-49dd-9f5e-fbb943aaf98c','https://www.figma.com/api/mcp/asset/701ebd5e-6058-42f9-afbc-50f9b1f18a12','https://www.figma.com/api/mcp/asset/6699c13e-5c0b-4102-8ea0-ef0c8515a70a') }
  @{ dir='showcase'; name='showcase-08-phone-mockup'; preview='https://www.figma.com/api/mcp/asset/73db0fe7-d307-49d3-b72d-2f9726d5ccff.png'; raw=@('https://www.figma.com/api/mcp/asset/b1166309-402c-4d88-a040-02a9db1b0927','https://www.figma.com/api/mcp/asset/f5af9f93-277e-4d54-861b-c21f3fdc140c','https://www.figma.com/api/mcp/asset/16a411dc-d514-43d4-95d5-b0c1971cc831','https://www.figma.com/api/mcp/asset/fc456a9b-b60d-4b40-8d28-1720a2d7acb4') }
  @{ dir='hero'; name='hero-portrait'; preview='https://www.figma.com/api/mcp/asset/ee0d2ca4-efa6-47c7-9d2e-de1b5f425383.png'; raw=@('https://www.figma.com/api/mcp/asset/1250b029-eb73-4883-9e16-d81540ca9824','https://www.figma.com/api/mcp/asset/b8f81b6e-24cf-4be6-9327-8bc4f02c342f','https://www.figma.com/api/mcp/asset/3f06a294-51c1-4f10-8f8b-71956c05a173','https://www.figma.com/api/mcp/asset/ad8d0224-710c-4291-bfff-5077f38cdcd1') }
  @{ dir='about'; name='about-bow'; preview='https://www.figma.com/api/mcp/asset/848d88ff-d62c-4d08-94d0-2a46f96e918c.png'; raw=@('https://www.figma.com/api/mcp/asset/4b6f1d7c-ae18-4792-9905-1e20b4ee0bfd','https://www.figma.com/api/mcp/asset/83b83403-95b1-46d3-ae85-97f70fa186bd') }
  @{ dir='about'; name='about-top-1'; preview='https://www.figma.com/api/mcp/asset/05848817-22e1-4873-90f2-d5a662bd216d.png'; raw=@('https://www.figma.com/api/mcp/asset/629b1c2a-b005-44b4-a138-92baa642d824','https://www.figma.com/api/mcp/asset/a905fa49-a129-428b-bc76-918dd38d28b3') }
  @{ dir='about'; name='about-top-2'; preview='https://www.figma.com/api/mcp/asset/c376faf7-5609-4416-8e8b-cbfd5e383d54.png'; raw=@('https://www.figma.com/api/mcp/asset/4eba5fb6-e6a7-46b6-a2c6-4405377892c4','https://www.figma.com/api/mcp/asset/d8e01841-02b9-4ed8-a842-afe3d383f1a3') }
  @{ dir='about'; name='about-top-3'; preview='https://www.figma.com/api/mcp/asset/59080e50-828d-4fd9-b87e-17b7c4f00872.png'; raw=@('https://www.figma.com/api/mcp/asset/01b6c561-c50b-41cd-abbb-7373a8c05788','https://www.figma.com/api/mcp/asset/9e9bbcf2-a863-4328-aa1b-c58767b27205') }
  @{ dir='about'; name='about-middle-group'; preview='https://www.figma.com/api/mcp/asset/3321bd90-4770-4e83-8a09-319ca697bc72.png'; raw=@('https://www.figma.com/api/mcp/asset/4562d89f-70bc-4c4f-b44f-38c622fdba90','https://www.figma.com/api/mcp/asset/a5cd5437-9b64-45ad-93c0-0e697870403b') }
  @{ dir='about'; name='about-bottom-1'; preview='https://www.figma.com/api/mcp/asset/98eefa46-825f-42e5-b942-458aa603c7c9.png'; raw=@('https://www.figma.com/api/mcp/asset/ad5868fe-7bb2-4e68-9417-b68d1023795a','https://www.figma.com/api/mcp/asset/35f84299-a975-4d25-89cc-c89c0462cbb5') }
  @{ dir='about'; name='about-bottom-2'; preview='https://www.figma.com/api/mcp/asset/0137e98e-8c21-43ae-840c-270257871797.png'; raw=@('https://www.figma.com/api/mcp/asset/930df991-c696-4456-bea7-abe5ee3daee7','https://www.figma.com/api/mcp/asset/e9289a8f-16b3-4e13-942d-c0a2fed3c6b1') }
  @{ dir='experience'; name='logo-idc-emblem'; preview='https://www.figma.com/api/mcp/asset/462963b8-04b0-4a4a-8164-42d13b363169.png'; raw=@('https://www.figma.com/api/mcp/asset/9b0a6d23-e1be-47d1-ae56-e6e3fe2775ab') }
  @{ dir='experience'; name='logo-idc-wordmark'; preview='https://www.figma.com/api/mcp/asset/0116b96a-9228-4b76-98bd-39af7ff16362.png'; raw=@('https://www.figma.com/api/mcp/asset/d7b41bd4-35e5-4ae3-a9a7-5a10696b3db7') }
  @{ dir='experience'; name='logo-orrgn'; preview='https://www.figma.com/api/mcp/asset/10c161df-ecbf-46ad-a61d-2f27e4dbbb53.png'; raw=@('https://www.figma.com/api/mcp/asset/9c610761-f5e4-404e-8fcf-522c22b777cd') }
  @{ dir='experience'; name='logo-encora'; preview='https://www.figma.com/api/mcp/asset/8850634d-d1a0-4168-8ee9-27bbcea7a22d.png'; raw=@('https://www.figma.com/api/mcp/asset/c293ce65-e563-4022-8633-65c9ecc57067','https://www.figma.com/api/mcp/asset/e05e22c9-08ff-4d53-88d7-f907731904ee') }
  @{ dir='toolkit'; name='tool-1-figma'; preview='https://www.figma.com/api/mcp/asset/bf248857-9be0-4be0-871e-3dabcae03f3a.png'; raw=@('https://www.figma.com/api/mcp/asset/a626a2cf-df47-4795-9f96-488258d84e58') }
  @{ dir='toolkit'; name='tool-2'; preview='https://www.figma.com/api/mcp/asset/03b3a3b4-4d49-40f6-806f-14bf009d385a.png'; raw=@('https://www.figma.com/api/mcp/asset/2602270b-ceda-4d41-b12d-6c07fc3e7596') }
  @{ dir='toolkit'; name='tool-3'; preview='https://www.figma.com/api/mcp/asset/698af89e-7855-4c4e-927f-ebc146b3d657.png'; raw=@('https://www.figma.com/api/mcp/asset/0cb93b62-b943-444c-8731-cf69113fc207','https://www.figma.com/api/mcp/asset/a19a46cc-9113-4834-a5ba-8a0bae3acb55') }
  @{ dir='toolkit'; name='tool-4'; preview='https://www.figma.com/api/mcp/asset/ce0e6e14-f4f9-405d-9102-654167388058.png'; raw=@('https://www.figma.com/api/mcp/asset/8a0df94c-71f9-4bf9-ad92-d0b36a3bf393') }
  @{ dir='toolkit'; name='tool-5'; preview='https://www.figma.com/api/mcp/asset/7f4f978f-9028-4eb7-b26c-302c0b5e5b45.png'; raw=@('https://www.figma.com/api/mcp/asset/e04eacfc-1e13-4fa5-a155-00165762ea24','https://www.figma.com/api/mcp/asset/8729516e-f280-4c50-96c3-1a5a28752230') }
  @{ dir='toolkit'; name='tool-6'; preview='https://www.figma.com/api/mcp/asset/4707476b-4261-4121-9591-e3fdaa429331.png'; raw=@('https://www.figma.com/api/mcp/asset/53d2835d-651e-4503-94f8-7a1cbd3f2afd') }
  @{ dir='flowers'; name='flowers-set-a'; preview='https://www.figma.com/api/mcp/asset/9c09a29f-c359-4deb-9a17-dcba8a8d7589.png'; raw=@('https://www.figma.com/api/mcp/asset/921c38a2-9aba-4834-91c1-6ad0f94fa32a','https://www.figma.com/api/mcp/asset/672d718a-fc0e-46bd-a0f4-65d463450eba','https://www.figma.com/api/mcp/asset/f02c84bf-513e-4aca-b91f-7ef0a0479d89','https://www.figma.com/api/mcp/asset/5b46e5ac-a3cf-4f39-9df5-a6a8381185b5') }
  @{ dir='flowers'; name='flowers-set-b'; preview='https://www.figma.com/api/mcp/asset/4d221755-f405-456d-b0b6-d1363683bcd1.png'; raw=@('https://www.figma.com/api/mcp/asset/3c559d09-2271-4b94-abb5-065d3e7f535e') }
)

function Get-Ext($path) {
  $b = [System.IO.File]::ReadAllBytes($path)
  if ($b.Length -ge 3 -and $b[0] -eq 0xFF -and $b[1] -eq 0xD8) { return '.jpg' }
  if ($b.Length -ge 4 -and $b[0] -eq 0x89 -and $b[1] -eq 0x50) { return '.png' }
  if ($b.Length -ge 4 -and $b[0] -eq 0x52 -and $b[1] -eq 0x49) { return '.webp' }
  if ($b.Length -ge 3 -and $b[0] -eq 0x47 -and $b[1] -eq 0x49) { return '.gif' }
  return '.bin'
}

$ok = 0; $failed = @()
foreach ($it in $items) {
  $dir = Join-Path $root $it.dir
  $prev = Join-Path $dir '_previews'
  New-Item -ItemType Directory -Force -Path $dir, $prev | Out-Null
  try {
    Invoke-WebRequest -UseBasicParsing -Uri $it.preview -OutFile (Join-Path $prev ($it.name + '.png'))
  } catch { $failed += "$($it.name) (preview)" }

  $files = @(); $i = 0
  foreach ($u in $it.raw) {
    $i++; $t = Join-Path $tmp ("$($it.name)_$i")
    try { Invoke-WebRequest -UseBasicParsing -Uri $u -OutFile $t; $files += Get-Item $t }
    catch { $failed += "$($it.name) (image $i)" }
  }
  # drop exact duplicates, biggest file first
  $seen = @{}; $uniq = @()
  foreach ($f in ($files | Sort-Object Length -Descending)) {
    $h = (Get-FileHash $f.FullName -Algorithm SHA1).Hash
    if (-not $seen.ContainsKey($h)) { $seen[$h] = 1; $uniq += $f }
  }
  $n = 0
  foreach ($f in $uniq) {
    $n++
    $suffix = if ($n -eq 1) { '' } else { "-$n" }
    $dest = Join-Path $dir ($it.name + $suffix + (Get-Ext $f.FullName))
    Move-Item -Force $f.FullName $dest
  }
  if ($uniq.Count -gt 0) { $ok++; Write-Host ("OK   {0,-32} {1} file(s)" -f $it.name, $uniq.Count) }
}
Remove-Item -Recurse -Force $tmp
Write-Host ""
Write-Host "$ok of $($items.Count) layers downloaded to $root"
if ($failed.Count) {
  Write-Host "Failed (links probably expired - ask Claude for fresh ones):" -ForegroundColor Yellow
  $failed | ForEach-Object { Write-Host "  $_" }
}
