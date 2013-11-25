require(quantmod)

require_symbol <- function(symbol, environ = parent.frame()) {
    if (is.null(environ[[symbol]])) {
        environ[[symbol]] <- getSymbols(symbol, auto.assign = FALSE)
    }

    environ[[symbol]]
}

shinyServer(function(input, output) {
    ## Env for storing data
    symbol_env <- new.env()

    ## make chart
    make_chart <- function(symbol) {
        symbol_data <-  require_symbol(symbol, symbol_env)

        chartSeries(symbol_data,
                    name = symbol,
                    type = input$chart_type,
                    subset = paste("last", input$time_num, input$time_unit),
                    log.scale = input$log_y,
                    theme = "white")
    }
    
    output$plot_aapl <- renderPlot({ make_chart("AAPL")})
    output$plot_msft <-  renderPlot({ make_chart("MSFT")})
    output$plot_imb <- renderPlot({ make_chart("IMB")})
    output$plot_goog <- renderPlot({ make_chart("GOOG")})
    output$plot_yhoo <- renderPlot({ make_chart("YHOO")})
    
})
