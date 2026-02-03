# Шаблон русской кандидатской диссертации

Шаблон русской кандидатской диссертации на языке разметки [Typst](https://typst.app/) - современной альтернативы LaTeX.

![Пример диссертации](https://github.com/user-attachments/assets/4a492d7f-a076-4900-9b02-dbbce777ff39)

## Установка Typst

Typst можно установить через различные пакетные менеджеры. Обратите внимание, что версии в пакетных менеджерах могут отставать от последнего релиза.

| Платформа   | Команда установки                                                                                  |
| ----------- | -------------------------------------------------------------------------------------------------- |
| **Linux**   | См. [Repology](https://repology.org/project/typst/versions) или [Snap](https://snapcraft.io/typst) |
| **macOS**   | `brew install typst`                                                                               |
| **Windows** | `winget install --id Typst.Typst`                                                                  |

Подробнее см. в [официальном репозитории Typst](https://github.com/typst/typst).

### Расширение для VS Code

Для удобной работы с Typst в VS Code рекомендуется установить расширение [Tinymist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist). Оно обеспечивает:

- Предпросмотр документа в реальном времени
- Подсветку синтаксиса
- Автодополнение и переход к определениям
- Диагностику ошибок

## Конфигурация

Список литературы формируется из файлов `common/external.bib` и `common/author.bib`.

Список сокращений и условных обозначений формируется из данных, записанных в файле `common/acronyms.typ` `common/symbols.typ`. Список определений формируется из данных в файле `common/glossary.typ`.

## Компиляция

Для компиляции проекта из CLI используйте:

```bash
typst compile thesis.typ
```

Или если вы хотите следить за изменениями:

```bash
typst watch thesis.typ
```

## Особенности

- Стандарт ГОСТ Р 7.0.11-2011.

## Благодарности

- Благодарность авторам шаблона диссертации на [LaTeX](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template)

- [Полезные ссылки](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template/wiki/Links#%D0%BF%D1%80%D0%BE%D1%87%D0%B8%D0%B5-%D1%80%D0%B5%D0%BF%D0%BE%D0%B7%D0%B8%D1%82%D0%BE%D1%80%D0%B8%D0%B8-%D1%81-%D0%BF%D0%BE%D0%BB%D0%B5%D0%B7%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BF%D1%80%D0%B8%D0%BC%D0%B5%D1%80%D0%B0%D0%BC%D0%B8)
