library(shiny)
library(shinyapps)
shinyUI(navbarPage("Developing Data Product Project",
                   tabPanel("Lunch Suggestion",
                            titlePanel( h1("What's for Lunch!", 
                                           style = "font-family: 'Lobster', cursive;
                                           font-weight: 1000; line-height: 1.1; 
                                           color: #4d3a7d;")),
                            
                            sidebarPanel(
                              
                              # to let user decide he/she want to take away or not
                              radioButtons("takeaway", label = h3("Takeaway or Dine in?"),
                                           choices = list("Takeaway" = "Takeaway", "Dine in" = "Dine in"), 
                                           selected = "Takeaway"),
                              
                              hr(),
                              fluidRow(column(5, verbatimTextOutput("out_takeaway"))),
                              
                              # to let user choose his/her option on the budget
                              selectInput("budget", label = h3("What your budget?, choose from the dropdown list"), 
                                          choices = list("$5 to $10 dollars" = "$5 to $10 dollars", "Above $10 dollars" = "Above $10 dollars"), 
                                          selected = "$5 to $10 dollars"),
                              
                              hr(),
                              fluidRow(column(5, verbatimTextOutput("out_budget"))),
                              
                              actionButton("goButton1", "Submit")
                              
                            ),
                            
                            mainPanel(
                              verbatimTextOutput("output1"),
                              verbatimTextOutput("output2"),
                              
                              tableOutput("output9")
                            )),
                   tabPanel("Simple Game",
                            
                            
                            titlePanel( h1("let play Rock-paper-scissors game", 
                                           style = "font-family: 'Lobster', cursive;
                                           font-weight: 1000; line-height: 1.1; 
                                           color: #4d3a7d;")),
                            
                            sidebarPanel(
                              
                              # to let user input his/her name
                              textInput("name123", label = h3("what your name?"), value = "Enter name pls..."),
                              
                              # to let user choose his/her option
                              radioButtons("options123", label = h3("choose your pattern"),
                                           choices = list("Rock" = "rock", "Paper" = "paper", "Scissors" = "scissors"), 
                                           selected = "rock"),
                              
                              actionButton("goButton", "Let play with Computer!")
                              
                              #     hr(),
                              #     fluidRow(column(3, verbatimTextOutput("out_option123")))
                            ),
                            
                            mainPanel(
                              fluidRow(
                                column(12,
                                       h3("Game output", 
                                          style = "font-family: 'Lobster', cursive;
                                          font-weight: 500; line-height: 1.1; 
                                          color: #4d3a7d;"),
                                       fluidRow(
                                         column(6,
                                                textOutput("user_selection"),
                                                
                                                imageOutput("user_pic")
                                                
                                         ),
                                         
                                         column(width = 6,
                                                textOutput("comp_selection"),
                                                
                                                imageOutput("comp_pic")
                                         )
                                       )
                                       ),
                                column(12,
                                       h3("Final results", 
                                          style = "font-family: 'Lobster', cursive;
                 font-weight: 500; line-height: 1.1; 
                 color: #4d3a7d;"),
                                       
                                       imageOutput("result_pic")
                                )
                                )
                            )),
                   tabPanel("Lunch Dataset",
                            titlePanel( h1("Dataset used for Lunch Suggestion Apps", 
                                           style = "font-family: 'Lobster', cursive;
                                           font-weight: 1000; line-height: 1.1; 
                                           color: #4d3a7d;")),
                            sidebarPanel(
                              
                              
                              # to let user choose his/her option
                              radioButtons("data123", label = h3("choose the dataset to see"),
                                           choices = list("data1" = 1, "data2" = 2, "data3" = 3, "data4" = 4), 
                                           selected = 1)

                            ),
                            mainPanel(
                              dataTableOutput("table_data123")                               

                            )
                            )
))

