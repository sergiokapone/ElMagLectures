# Использовать lualatex для компиляции
$lualatex = 'lualatex %O %S';

# Запуск lualatex для создания PDF
$pdf_mode = 1;           # Включить режим PDF
$pdflatex = $lualatex;    # Установить lualatex как компилятор для PDF

$aux_dir = './tmp';

# Подавление вывода в консоль (оставлять только ошибки)
$silent = 1;

$makeindex = "make -j4";





