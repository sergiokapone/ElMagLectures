$source = "Syllabus_ElMag.pdf"
$destination = "2к_бак_105_Електрика_та_магнетизм_(ЗО6)_Пономаренко_2025.pdf"

if (Test-Path $destination) {
    Remove-Item $destination -Force
}

Copy-Item -Path $source -Destination $destination