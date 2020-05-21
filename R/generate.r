#' Generate HTML output from RMarkdown file
#'
#' Uses the \code{knitr} R package to generate markdown from input
#' and then the \code{markdown} R package to generate HTML
#' 
#' @param input.filename R Markdown input file.
#' @param output.filename Markdown or HTML output file.  An HTML file
#' is specified using the .htm, .html, .HTM or .HTML file extension.
#' When html is specified, a similarly named markdown file is also
#' generated.
#' All output files including cache and figures will appear in the
#' same folder as \code{output.filename}.
#' @param stylesheet Argument passed to \code{markdownToHTML()}
#' (Default: \code{getOption("markdown.HTML.stylesheet")})
#' @param  ... Arguments to be passed to \code{\link{knitr::knit}}
#' @return Returns \code{output.filename}.
#'
#' @examples
#' ## request a table of contents at the beginning of the output
#' options(markdown.HTML.options=union('toc', getOption("markdown.HTML.options")))
#' ## use the 'style.css' from this R package to format output HTML
#' styles <- system.file("style.css", package="rmdreport")
#' options(markdown.HTML.stylesheet=styles)
#' ## generate markdown and HTML output files in the 'reports/' directory
#' ## from toy example
#' report <- system.file("example.rmd", package="rmdreport")
#' rmdreport.generate(report, file.path("reports", "report.html"))
#'
#' @export
rmdreport.generate <- function(input.filename, output.filename,
                     stylesheet=getOption("markdown.HTML.stylesheet"), ...) {
    
    input.filename <- normalizePath(input.filename)
    output.filename <- normalizePath(output.filename)

    output.dir <- dirname(output.filename)
    if (!file.exists(output.dir))
        dir.create(output.dir)

    current.dir <- getwd()
    on.exit(setwd(current.dir))
    setwd(output.dir)

    name <- gsub("\\.[^.]+$", "", basename(output.filename))
    suffix <- gsub(".*\\.([^.]+)$", "\\1", output.filename)
    is.html <- tolower(suffix) %in% c("htm","html")

    if (is.html)
        md.filename <- paste(name, "md", sep=".")
    else
        md.filename <- basename(output.filename)
    
    knit(input.filename, output=md.filename, envir=parent.frame(), ...)

    if (is.html)
        markdownToHTML(md.filename, basename(output.filename), stylesheet=stylesheet)

    output.filename
}
