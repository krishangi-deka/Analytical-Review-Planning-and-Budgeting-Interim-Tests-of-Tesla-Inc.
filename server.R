
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

server <- function(input, output) {
  
  # auditors risk assessment matrix generated from prior years' workpapers, etc.
  ram <- read.csv("risk_asst_matrix_q7.csv")
  
  
  # Reactive expression to create data frame of slider input values 
  sliderValues <- reactive({
    
    data.frame(
      Audit_Parameter = c("confidence",
                          "cost"),
      Value = as.character(c(input$confidence,
                             input$cost)),
      stringsAsFactors = FALSE)
  })
  
  
  # Show the values in an HTML table ----
  output$values <- renderTable({
    sliderValues()
  })
  
  
  output$caption <- renderText({
    input$caption
  })
  
  
  # Recompute scope and cost whenever input$confidence or input$cost change
  
  output$summary <- renderPrint({
    ram <- ram
    conf <- input$confidence
    cost <- input$cost
    risk <- (10 - (as.numeric(ram[,2]) * as.numeric(ram[,3])) )/100
    Scope <-  ceiling( log(1-conf) / log( 1- risk))
    ram <- cbind(ram[,1:5], Scope)
    Min_cost <- Scope * cost
    ram <- cbind(ram[,1:6], Min_cost)
    ram
  })
  
  # Recompute minimum audit cost whenever input$confidence or input$cost change
  
  output$view <- renderText({
    ram <- ram
    conf <- input$confidence
    cost <- input$cost
    risk <- (10 - (as.numeric(ram[,2]) * as.numeric(ram[,3])) )/100
    Scope <-  ceiling( log(1-conf) / log( 1- risk))
    ram <- cbind(ram[,1:5], Scope)
    Min_cost <- Scope * cost
    minimum_audit_cost <- sum(Min_cost)
    c("Minimum estimated audit cost = ",minimum_audit_cost)
  })
}

