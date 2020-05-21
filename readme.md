# Support for conveniently generating output from R Markdown file

This package is a wrapper for R packages
[knitr](https://cran.r-project.org/package=knitr)
and [markdown](https://cran.r-project.org/package=markdown)
to process R Markdown files and put output in a
specified directory.

Here is a basic example:
```
## get filename for toy R Markdown example
report <- system.file("example.rmd", package="rmdreport")
## generate markdown and HTML output files in the 'reports/' directory
## from toy example
rmdreport.generate(report, file.path("reports", "report.html"))
```

It is possible to modify `knitr` and `markdown` package settings
to modify output.  Here we modify `markdown` options
to include a table of contents and use a specific CSS style file.
```
## request a table of contents at the beginning of the output
options(markdown.HTML.options=union('toc', getOption("markdown.HTML.options")))
## use the 'style.css' from this R package to format output HTML
styles <- system.file("style.css", package="rmdreport")
options(markdown.HTML.stylesheet=styles)
## generate markdown and HTML output files in the 'reports/' directory
## from toy example
report <- system.file("example.rmd", package="rmdreport")
rmdreport.generate(report, file.path("reports", "report.html"))
```
