server <- function(input, output, session) {
  output$contents <- renderTable({
    req(input$file)
    
    
    tryCatch(
      {
        df <- read.csv(input$file$datapath,
                       header = input$header,
                       sep = input$sep)
        
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    if(input$disp == "head") {
      return(head(df))
    }
    else {
      return(df)
    }
  })
  
  
  
  #Ouput statistika deskriptif
  output$sum <- renderPrint({
    req(input$file)
    
    tryCatch(
      {
        df <- read.csv(input$file$datapath,
                       header = input$header,
                       sep = input$sep)
      },
      error =function(e){
        stop(safeError(e))
      }
    )
    
    describe(df)
    
  })
  
  
  #Ouput Regresi
  output$summary <- renderPrint({
    req(input$file)
    
    tryCatch(
      {
        df <- read.csv(input$file$datapath,
                       header = input$header,
                       sep = input$sep)
      },
      error = function(e){
        stop(safeError(e))
      }
    )
    
    tryCatch(
      {
        fit <- lm(df[,input$Y]~df[,input$X1]+df[,input$X2])
        names(fit$coefficient) <- c("Intercept", input$X1, input$X2)
        summary(fit)
      },
      error = function(e){
        print("you have to Input dependent & independent variable's name")
      }
    )
    
  })
  
  #Uji Normalitas Residu
  output$norm <- renderPrint({
    req(input$file)
    
    tryCatch(
      {
        df <- read.csv(input$file$datapath,
                       header = input$header,
                       sep = input$sep)
      },
      error = function(e){
        stop(safeError(e))
      }
    )
    tryCatch(
      {
        res = residuals(lm(df[,input$Y]~df[,input$X1]+df[,input$X2]))
        shapiro.test(res)
      }
    )
  })
  
  #Uji Autokorelasi
  output$korelasi <- renderPrint({
    req(input$file)
    
    tryCatch(
      {
        df <- read.csv(input$file$datapath,
                       header = input$header,
                       sep = input$sep)
      },
      error = function(e){
        stop(safeError(e))
      }
    )
    
    tryCatch(
      {
        model = lm(df[,input$Y]~df[,input$X1]+df[,input$X2])
        bgtest(model)
      },
      error = function(e){
        stop(safeError(e))
      }
    )
  })
  
  #Uji Heterokedastisitas
  output$hete <- renderPrint({
    req(input$file)
    
    tryCatch(
      {
        df <- read.csv(input$file$datapath,
                       header = input$header,
                       sep = input$sep)
      },
      error = function(e){
        stop(safeError(e))
      }
    )
    
    tryCatch(
      {
        model = lm(df[,input$Y]~df[,input$X1]+df[,input$X2])
        bptest(model)
      },
      error = function(e){
        stop(safeError(e))
      }
    )
  })
  
  #Distribution
  output$distribution2 <- renderPlot({
    req(input$file)
    
    tryCatch(
      {
        df <- read.csv(input$file$datapath,
                       header = input$header,
                       sep = input$sep)
      },
      error = function(e){
        stop(safeError(e))
      }
    )
    
    tryCatch(
      {
        hist(df[, input$X1], main = "", xlab = input$X1, col = rainbow(15))
      },
      error = function(e){
        print("")
      }
    )
  })
  
  output$distribution1 <- renderPlot({
    req(input$file)
    
    tryCatch(
      {
        df <- read.csv(input$file$datapath,
                       header = input$header,
                       sep = input$sep)
      },
      error = function(e){
        stop(safeError(e)) 
      }
    )
    
    tryCatch(
      {
        hist(df[, input$Y], main = "", xlab = input$Y, col = rainbow(15))
      }
    )
  })
  
  output$distribution3 <- renderPlot({
    req(input$file)
    
    tryCatch(
      {
        df <- read.csv(input$file$datapath,
                       header = input$header,
                       sep = input$sep)
      },
      error = function(e){
        stop(safeError(e))
      }
    )
    
    tryCatch(
      {
        hist(df[, input$X2], main = "", xlab = input$X2, col = rainbow(15))
      },
      error = function(e){
        print("")
      }
    )
  })
  
  #Uji Multikolineraitas
  output$linear <- renderPrint({
    req(input$file)
    
    tryCatch(
      {
        df <- read.csv(input$file$datapath,
                       header = input$header,
                       sep = input$sep) 
      },
      error = function(e){
        stop(safeError(e))
      }
    )
    
    tryCatch(
      {
        multi = (lm(df[,input$Y] ~ df[,input$X1]+df[,input$X2], data = df))
        vif(multi)
      },
      
      error = function(e){
        stop(safeError(e))
      }
    )
  })
  
  #Visualisasi Matriks Plot
  output$matriks <- renderPlot({
    req(input$file)
    
    tryCatch(
      {
        df <- read.csv(input$file$datapath,
                       header = input$header,
                       sep = input$sep)
      },
      error = function(e){
        stop(safeError(e))
      }
    )
    ggpairs(df)
  })
}
