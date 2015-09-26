# start server
library(shiny)
library(shinyapps)
data11=read.csv("tab1.csv", header=T)
data12=read.csv("tab2.csv", header=T)
data21=read.csv("tab3.csv", header=T)
data22=read.csv("tab4.csv", header=T)

fx=c("rock","rock","rock","paper","paper","paper","scissors","scissors","scissors")
fy=c("rock","paper","scissors","rock","paper","scissors","rock","paper","scissors")
fd=c(1,2,3,3,1,2,2,3,1)

#draw=1, lose = 2, win = 3

xydc=data.frame(fx,fy,fd)
xydc$combine=paste(fx,fy)


shinyServer(function(input, output) {
  
  output$out_takeaway <- renderPrint({ input$takeaway })
  
  # to translate user option to the data-points 
  x1<- reactive({ifelse(input$takeaway=="Takeaway",1,2)})
  y1<- reactive({ifelse(input$budget=="$5 to $10 dollars",1,2)})
  
  output$out_budget <- renderPrint({ input$budget })
  
  final_xy1=reactive({paste("d" ,x1(), y1(),sep='')})
  
  # random number between 0 to 14 by random uniform
  z1 <- eventReactive(input$goButton1, {
    floor(runif(1,0,15))
  })
  
  final_lunch2=reactive({ if(final_xy1()=="d11"){
    data11[data11$s.n==z1(),2:3]
  }else if (final_xy1()=="d12"){
    data12[data12$s.n==z1(),2:3]
  } else if (final_xy1()=="d21"){
    data21[data21$s.n==z1(),2:3]
  } else {data22[data22$s.n==z1(),2:3]}
  })
  
  output$output1 <- renderPrint({paste("You have selected", input$takeaway)})
  output$output2 <- renderPrint({paste("Your budget for lunch is", input$budget)})
  output$output9 <- renderTable({final_lunch2()}) 
  
  # print out user selected which option  at the main panel
  output$user_selection <- renderText({ paste(input$name123 ,"have selected", input$options123)})
  
  # diplayed out user selection photo  
  x<- reactive({ifelse(input$options123=="rock","images/rock.png",ifelse(input$options123=="paper","images/paper.png","images/scissors.png"))})
  
  output$user_pic<-renderImage({
    list(src=x(), alt=NULL)
  },deleteFile=FALSE)
  
  # random number between 0, 1, 2 by random uniform
  y <- eventReactive(input$goButton, {
    floor(runif(1,0,3))
  })  
  
  final_y=reactive({ifelse(y()==0,"rock",ifelse(y()==1,"paper","scissors"))})
  
  y_src=reactive({ifelse(final_y()=="rock","images/rock.png",ifelse(final_y()=="paper","images/paper.png","images/scissors.png"))})
  
  output$comp_selection <- renderText({ paste("Computer have selected", final_y())})
  
  output$comp_pic<-renderImage({
    list(src=y_src(), alt=NULL)
  },deleteFile=FALSE)
  
  combine_xy=reactive({paste(input$options123,final_y())})
  
  # end_game=reactive({xydc$fd[xydc$combine==(combine_xy())]})
  
  #draw=1, lose = 2, win = 3
  # end_result=reactive({ifelse(combine_xy()==("paper paper"|"rock rock"|"scissors scissors"),"images/again.png",ifelse(combine_xy()==("paper scissors"|"rock paper"|"scissors rock"),"images/lose.png","images/win.png"))})
  
  end_result=reactive({ifelse(((combine_xy()==("paper paper"))|(combine_xy()==("rock rock"))|(combine_xy()==("scissors scissors"))),"images/again.png",ifelse(((combine_xy()==("paper scissors"))|(combine_xy()==("rock paper"))|(combine_xy()==("scissors rock"))),"images/lose.png","images/win.png"))})
  
  output$result_pic<-renderImage({
    list(src=end_result(), alt=NULL)
  },deleteFile=FALSE)
  
  final_data_output=reactive({if(input$data123==1){
    data11
  }else if(input$data123==2){
    data12
  } else if (input$data123==3){
    data21
  } else data22
    })
 
  output$table_data123 <- renderDataTable({final_data_output()}) 

})