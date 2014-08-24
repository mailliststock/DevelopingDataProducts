library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Fuel Efficiency Prediction"),
  sidebarPanel(
    h3('Data Input'), 
    numericInput('wt', "Weight (WT)", 2000, min = 1000, max = 5000, step = 50),
    radioButtons('cyl', 'Number of Cylinders', c('4'=4, '6'=6, '8'=8)),
    radioButtons('am', 'Transmission (AM)', c('Automatic' = 0, 'Manual' = 0)),
    numericInput('hp', "Horsepower (HP)", 200, min = 100, max = 500, step =5 ),
    p('Describe your auto above and click Predict button bellow.'),
    submitButton('Predict', icon = icon("none"))
  ),
  mainPanel(
    h3('About'),
    p('This piece of software was developed for the Coursera Developing Data Products 
			course project. It uses the mtcars dataset available from the mtcars R.
      A linear regression model was build to predict fuel efficiency (miles per gallon).'),
    h3 ('Graph'), plotOutput('wtPlot'), plotOutput('hpPlot'), 
    h3 ('Your Prediction Result'), verbatimTextOutput('oprediction')
  )
))
