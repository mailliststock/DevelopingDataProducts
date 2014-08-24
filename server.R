library(shiny)
data(mtcars)

shinyServer(
  function(input, output) {
    output$prediction <- renderPrint({mpg_calculator(input$wt, input$hp)})
    output$ocyl <- renderText(as.numeric({input$cyl}))
    output$ohp <- renderText({input$hp})
    output$owt <- renderText({input$wt})
    output$oam <- renderText(c('Automatic', 'Manual')[as.numeric({input$am}) + 1])
    
    output$wtPlot <- renderPlot({
      plot(mtcars$wt, mtcars$mpg, 
           main = "MPG versus WEIGHT", 
           ylab = "MPG", 
           xlab = "WEIGHT/1000 lbs)")
    })
    output$hpPlot <- renderPlot({
      plot(mtcars$hp, mtcars$mpg, 
           main = "MPG versus HP", 
           ylab = "MPG", 
           xlab = "HP")
    })
    output$oprediction <- renderText({
      d <- data.frame(cyl = as.numeric({input$cyl}), 
                            wt = {input$wt}/1000, 
                            hp = {input$hp}, 
                            am = as.numeric({input$am}))
      f <- lm(mpg ~ cyl+hp+wt+am, mtcars)
      p <- predict(f, d, interval = 'prediction', level = .90)
      paste('MPG expected is ', round(p[1,1]), 
            ' and with 90% confidence, your MPG is within [', 
            floor(p[1,2]), ', ', ceiling(p[1,3]), '].', sep = '')
    }) 
  }
)