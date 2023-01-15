library(shiny)
library(ggplot2)
library(markdown)
library(shinythemes)
library(psych)
library(car)
library(lmtest)
library(GGally)
library(knitr)

titlePanel("Multiple Regression Linear")
fluidPage(theme = shinytheme("darkly"),
          navbarPage("Multiple Linear Regression App",
                     navbarMenu("Concept",
                                tabPanel("Multiple Linear Regression",
                                         includeMarkdown("Multiple Linear Regression.md")
                                ),            
                                tabPanel("Classical Assumption Test",
                                         includeMarkdown("Classical Asumption Test.md")
                                )),
                     
                     tabPanel("Descriptive Statistics & Datasets ",
                              sidebarLayout(
                                sidebarPanel(
                                  #Memasukan data
                                  tags$h2("Datasets"),
                                  fileInput("file", "Choose File",
                                            multiple = FALSE,
                                            accept = c("text/csv",
                                                       "text/comma-separated-value,text/plain",
                                                       ".csv")),
                                  #Horizontal line
                                  tags$hr(),
                                  
                                  #Input: checkbox if file has header
                                  checkboxInput("header", "Header", TRUE),
                                  
                                  #Input:Select display
                                  radioButtons("disp", "Display",
                                               choices = c(Head = "head",
                                                           All = "all"),
                                               selected = "head"),
                                  
                                  #input: select separator
                                  radioButtons("sep", "Separators",
                                               choices = c(Comma = ",",
                                                           Semicolon = ";",
                                                           Tab = "\t"),
                                               selected = ","),
                                  
                                  
                                ),
                                mainPanel(
                                  tableOutput("contents")
                                )
                              ),
                              #Summary
                              tags$h2("Descriptive Statistics"),
                              verbatimTextOutput("sum")
                              
                     ),
                     
                     tabPanel("Multiple Linear Regression  & Classical Assumption Testing",
                              
                              sidebarLayout(
                                sidebarPanel(
                                  textInput("Y", "Input dependent varibale's name (Y)"),
                                  textInput("X1", "Input independent varibale's name (X1)"),
                                  textInput("X2", "Input independent varibale's name (X2)")
                                ),
                                mainPanel(
                                  tabsetPanel(type = "tabs",
                                              tabPanel("Matrix Correlation",
                                                       tags$h2("Korelasi Matriks"),
                                                       plotOutput("matriks")
                                              ),
                                              tabPanel("Regression", verbatimTextOutput("summary")),
                                              tabPanel("Normality Test", verbatimTextOutput("norm")),
                                              tabPanel("Multicolinearity Test ", verbatimTextOutput("linear")),
                                              tabPanel("Autocorrelation Test", verbatimTextOutput("korelasi")),
                                              tabPanel("Heteroscedasticity Test", verbatimTextOutput("hete")),
                                              tabPanel("Histogram Distribution",
                                                       fluidRow(
                                                         column(6, plotOutput("distribution1")),
                                                         column(6, plotOutput("distribution2")),
                                                         column(6, plotOutput("distribution3"))
                                                       )))
                                )
                              )
                              
                              
                     ),
                     tabPanel("Notes",
                              tags$h2("Dibuat oleh Hanani Mustaghfiroh"),
                              tags$h2("Nama kelompok : Hanani Mustaghfiroh, Anissa Wahyu Novita, Iswara H "),
                              tags$h2("Tugas Mata Kuliah : Workshop Komputer dan Statistika")
                                          
                              
                              
                     )
                     
          )
)