# Установка и сборка Книги I

Понадобится TeX Live 2026 с поддержкой кириллицы и установленными `pdflatex`, `latexmk`, `biber` и `makeindex`. Полная установка TeX Live включает пакеты, которые использует проект. [TeX Live](https://tug.org/texlive/) · [Latexmk](https://ctan.org/pkg/latexmk)

В Windows откройте PowerShell, в Linux или macOS — терминал. Перейдите в папку с `dissertation.tex` и запустите:

```sh
latexmk -norc -r latexmkrc -pdf -interaction=nonstopmode -halt-on-error dissertation.tex
```

`latexmk` читает настройки проекта из `latexmkrc` и выполняет нужные проходы, чтобы обновить оглавление, номера и ссылки. Готовый файл `dissertation.pdf` появится в корне проекта.

## Проверка сборки

- Если терминал не находит одну из команд, проверьте, что каталог исполняемых файлов TeX доступен через `PATH`.
- Если LaTeX не находит файл `.sty`, установите соответствующий пакет средствами вашего дистрибутива TeX и повторите сборку.
- При ошибке начните с первого сообщения об ошибке в `dissertation.log`. Место в исходниках обычно указано рядом.
- Предупреждение Biber об отсутствии записей для цитирования ожидаемо для текущей Книги I. Ссылки на параграфы, рисунки и скан оформлены через LaTeX.

Сборка проверена с TeX Live 2026 на Windows. Эту же команду выполняет GitHub Actions на Linux. [Автоматические сборки](https://github.com/rockyversus/kiselev-geometry-schoolbook/actions)

В разных установках TeX Live могут отличаться переносы и разбивка страниц. Номера страниц для цитирования и сообщений об ошибках берите из PDF опубликованного выпуска. [Выпуски книги](https://github.com/rockyversus/kiselev-geometry-schoolbook/releases)

[К описанию книги](../README.md)
