#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  
  titlePanel("Risk Assessment Matrix"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      # Input: statistical confidence level of the audit tests 
      sliderInput("confidence", "Confidence:",
                  min = .7, max = .999,
                  value = .95),
      
      # Input: cost of auditing per transaction sampled  
      sliderInput("cost", "Audit $ / transaction:",
                  min = 0, max = 500,
                  value = 100),
      
      
      # Input: Text for providing a caption for the RAM 
      textInput(inputId = "caption",
                label = "Client:",
                value = "Tesla Inc.")
      
    ),
    
    
    # Main panel for displaying outputs 
    mainPanel(
      
      # Output: slider values entered 
      tableOutput("values"),
      
      # Output: Formatted text for caption 
      h3(textOutput("caption", container = span)),
      
      # Output: total cost of the audit 
      textOutput("view"), 
      
      # Output: RAM summary with sample sizes (scope) and cost
      verbatimTextOutput("summary"),
      
      
      
      h6("Risk choices are:  1 = Low,  2=Medium, 3=High"),
      h6("Risk_intel = the risk level indicated by business intelligence scanning"),
      h6("Risk_prior = the risk level indicated by audits in prior years"),
      h6("Account Amount and the Ave. Transaction size are in $ without decimals or 000 dividers"),
      h6("Scope = estimated discovery sample size that will be needed in the audit of this account"),
      h6("Audit cost = audit labor dollars per sampled transaction"),      
      h6("Confidence = statistical confidence")
      
      
    )
  )
)