<#
.SYNOPSIS
    Знаходить лекції зі змінами, які ще не закомічені, і перезбирає їх.

.DESCRIPTION
    Лекція — це тека в корені репозиторію з файлом <Тека>/<Тека>.tex.
    Скрипт бере `git status` (змінені, додані та невідстежувані файли),
    відкидає артефакти збірки (pdf, aux, log, ...), групує решту за лекціями,
    показує що змінилось, компілює кожну лекцію через latexmk рушієм з
    magic-коментаря `% !TeX program = ...` і підсумовує помилки/попередження з логу.

.PARAMETER ListOnly
    Лише показати змінені лекції та файли, без компіляції.

.PARAMETER Open
    Відкрити PDF кожної успішно зібраної лекції.

.PARAMETER Lecture
    Обмежитись конкретними лекціями (назви тек), напр. -Lecture MagFieldVacuum.

.EXAMPLE
    .\review.ps1
    .\review.ps1 -ListOnly
    .\review.ps1 -Lecture MagFieldMedia -Open
#>
[CmdletBinding()]
param(
    [switch]$ListOnly,
    [switch]$Open,
    [string[]]$Lecture
)

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$Root = $PSScriptRoot
Set-Location $Root

# Чекає натискання клавіші, щоб вікно не закрилось одразу, і виходить з кодом
function Exit-WithPause([int]$Code = 0) {
    if (-not [Console]::IsInputRedirected) {
        Write-Host "`nPress any key..." -NoNewline
        try { $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown') } catch { }
        Write-Host
    }
    exit $Code
}

# Файли, зміни в яких не означають зміни змісту лекції
$ArtifactPattern = '\.(pdf|aux|log|bbl|bcf|blg|nav|snm|out|toc|vrb|fls|fdb_latexmk|synctex\.gz|run\.xml|xdv|thm)$|-SAVE-ERROR$|/\.vscode/|/_minted'

# --- 1. Зібрати змінені файли з git ------------------------------------------
$status = git -c core.quotepath=off status --porcelain=v1 -uall
if ($LASTEXITCODE -ne 0) { Write-Host 'git status завершився з помилкою' -ForegroundColor Red; Exit-WithPause 1 }

$changes = foreach ($line in $status) {
    if ($line.Length -lt 4) { continue }
    $code = $line.Substring(0, 2)
    $path = $line.Substring(3).Trim('"')
    if ($path -match ' -> ') { $path = ($path -split ' -> ')[-1].Trim('"') }  # перейменування
    if ($path -notmatch '/') { continue }                                   # файли в корені
    if ($path -match $ArtifactPattern) { continue }
    [pscustomobject]@{
        Lecture = ($path -split '/')[0]
        Code    = $code
        Path    = $path
    }
}

$groups = @($changes | Group-Object Lecture | Where-Object {
    Test-Path (Join-Path $Root "$($_.Name)/$($_.Name).tex")
})
if ($Lecture) { $groups = @($groups | Where-Object { $Lecture -contains $_.Name }) }

if (-not $groups) {
    Write-Host 'Незакомічених змін у лекціях немає.' -ForegroundColor Green
    Exit-WithPause 0
}

# --- 2. Показати, що змінилось -----------------------------------------------
$codeNames = @{ 'M' = 'змінено'; 'A' = 'додано'; 'D' = 'видалено'; 'R' = 'перейменовано'; '?' = 'новий' }

Write-Host "`nЛекції з незакоміченими змінами: $($groups.Count)`n" -ForegroundColor Cyan
foreach ($g in $groups) {
    Write-Host "■ $($g.Name)" -ForegroundColor Yellow
    foreach ($c in $g.Group) {
        $k = ($c.Code.Trim())[0]
        $label = if ($codeNames.ContainsKey([string]$k)) { $codeNames[[string]$k] } else { $c.Code }
        $stat = ''
        if ($k -ne '?') {
            $ns = git -c core.quotepath=off diff HEAD --numstat -- $c.Path 2>$null
            if ($ns) { $p = $ns -split "`t"; $stat = "  (+$($p[0]) -$($p[1]))" }
        }
        Write-Host ("    {0,-13} {1}{2}" -f $label, $c.Path, $stat)
    }
}

if ($ListOnly) { Exit-WithPause 0 }

# --- 3. Скомпілювати кожну лекцію й розібрати лог ---------------------------
$results = foreach ($g in $groups) {
    $name = $g.Name
    $dir = Join-Path $Root $name
    $tex = "$name.tex"

    $engine = 'lualatex'
    $magic = Select-String -Path (Join-Path $dir $tex) -Pattern '^\s*%\s*!TeX\s+program\s*=\s*(\w+)' -List
    if ($magic) { $engine = $magic.Matches[0].Groups[1].Value.ToLower() }

    Write-Host "`n=== Збірка $name ($engine) ===" -ForegroundColor Cyan
    $sw = [Diagnostics.Stopwatch]::StartNew()
    Push-Location $dir
    try {
        $null = latexmk "-$engine" -interaction=nonstopmode -file-line-error -synctex=1 $tex 2>&1
        $ok = ($LASTEXITCODE -eq 0)
    } finally {
        Pop-Location
    }
    $sw.Stop()

    $log = Join-Path $dir "$name.log"
    $errors = @(); $warnings = @(); $undef = 0; $overfull = 0
    if (Test-Path $log) {
        $lines = Get-Content $log -Encoding UTF8
        $errors = @($lines | Where-Object { $_ -match '^(\S+\.\w+:\d+: |! )' } | Select-Object -Unique)
        $warnings = @($lines | Where-Object { $_ -match '(LaTeX|Package \S+|Class \S+) Warning' })
        $undef = @($lines | Where-Object { $_ -match 'undefined' -and $_ -match 'Warning' }).Count
        $overfull = @($lines | Where-Object { $_ -match '^Overfull' }).Count
    }

    if ($ok) { Write-Host "  OK за $([int]$sw.Elapsed.TotalSeconds) с" -ForegroundColor Green }
    else     { Write-Host "  ПОМИЛКА збірки (див. $name/$name.log)" -ForegroundColor Red }
    $errors | Select-Object -First 10 | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
    if ($errors.Count -gt 10) { Write-Host "  ... ще $($errors.Count - 10)" -ForegroundColor Red }

    if ($ok -and $Open) {
        $pdf = Join-Path $dir "$name.pdf"
        if (Test-Path $pdf) { Invoke-Item $pdf }
    }

    [pscustomobject]@{
        'Лекція'      = $name
        'Статус'      = if ($ok) { 'OK' } else { 'FAIL' }
        'Помилки'     = $errors.Count
        'Попередж.'   = $warnings.Count
        'Undefined'   = $undef
        'Overfull'    = $overfull
        'Час, с'      = [int]$sw.Elapsed.TotalSeconds
    }
}

# --- 4. Підсумок -------------------------------------------------------------
Write-Host "`n=== Підсумок ===" -ForegroundColor Cyan
$results | Format-Table -AutoSize | Out-Host

Exit-WithPause $(if ($results | Where-Object { $_.'Статус' -eq 'FAIL' }) { 1 } else { 0 })
