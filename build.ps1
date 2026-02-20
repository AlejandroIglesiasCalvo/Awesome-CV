param(
    [ValidateSet("all", "spanish", "english")]
    [string]$Target = "all"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$cvDir = Join-Path $repoRoot "MiCurriculum"
$tempDir = Join-Path $repoRoot ".temp"
$outDir = Join-Path $repoRoot "CVs"

New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
New-Item -ItemType Directory -Path $outDir -Force | Out-Null

function Get-XeLaTeXPath {
    $cmd = Get-Command xelatex -ErrorAction SilentlyContinue
    if ($cmd) {
        return "xelatex"
    }

    $fallback = Join-Path $env:LOCALAPPDATA "Programs\MiKTeX\miktex\bin\x64\xelatex.exe"
    if (Test-Path $fallback) {
        return $fallback
    }

    throw "No se encontro xelatex. Instala MiKTeX o agrega xelatex al PATH."
}

$xelatex = Get-XeLaTeXPath

$targets = @{
    spanish = @(
        "resume.tex",
        "Alejandro-Iglesias-Calvo-cv.tex",
        "coverletter.tex"
    )
    english = @(
        "resume-eng.tex",
        "Alejandro-Iglesias-Calvo-cv-eng.tex",
        "coverletter-eng.tex"
    )
}
$targets["all"] = @($targets["spanish"] + $targets["english"])

$docs = $targets[$Target]
$failed = @()

Push-Location $cvDir
try {
    foreach ($doc in $docs) {
        $base = [System.IO.Path]::GetFileNameWithoutExtension($doc)
        $log = Join-Path $tempDir ("build-{0}.log" -f $base)

        Write-Host ("Compilando {0}..." -f $doc)
        $prevErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = "Continue"
        & $xelatex -interaction=nonstopmode -file-line-error -halt-on-error -output-directory $tempDir $doc *> $log
        $ErrorActionPreference = $prevErrorActionPreference

        if ($LASTEXITCODE -ne 0) {
            Write-Host ("ERROR en {0}. Ultimas lineas del log:" -f $doc)
            Get-Content $log -Tail 30
            $failed += $doc
            continue
        }

        $pdf = "$base.pdf"
        Copy-Item -Path (Join-Path $tempDir $pdf) -Destination (Join-Path $outDir $pdf) -Force
        Write-Host ("OK -> CVs/{0}" -f $pdf)
    }
}
finally {
    Pop-Location
}

if ($failed.Count -gt 0) {
    throw ("Fallo la compilacion de: {0}" -f ($failed -join ", "))
}

Write-Host "Listo. PDFs actualizados en CVs/."
