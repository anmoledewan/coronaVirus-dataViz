##### Global: options #####
Production = T  
options(scipen = 1000, expressions = 10000)
appVersion = "v1.0"
appName = "COVID-19 Data Visualization Platform"
appLongName = "COVID-19 Data Visualization Platform"
lastUpdate = "2020-03-23"

loader <- tagList(
  waiter::spin_loaders(42),
  br(),
  h3("Loading data")
)

source("appFiles/packageLoad.R")
source("appFiles/dataLoad.R")
source("appFiles/CSS.R", local = TRUE)
source("appFiles/dashboardPage.R", local = TRUE)
##### User interface #####
ui <- tagList( # dependencies
  use_waiter(),
  useSweetAlert(),
  waiter::waiter_show_on_load(loader, color = "#000"),
# shows before anything else
  ##### CSS and style functions #####
  CSS, #CSS.R
  # Loading message
  argonDash::argonDashPage(
    title = appLongName,
    header = argonDash::argonDashHeader(
      gradient = T,
      color = NULL,
      top_padding = 2,
      bottom_padding = 0,
      background_img = "coronavirus.jpg",
      height = 90,
      argonRow(
        argonColumn(width = 9,
                    h4(appLongName, style = 'color:white;
                       text-align:left;
                       vertical-align: middle;
                       font-size:45px;')
                    ),
        argonColumn(
          width = 3,
          argonRow(
            center = T,
            argonColumn(
              width = 12,
              center = T,
              h5(HTML("Creator and maintainer: <a href='www.shubhrampandey.com'>Shubhram Pandey</a>"), style = 'color:white;text-align:right;font-size:15px;')
            ),
            argonColumn(
              width = 12,
              argonNavMenu(
                side = "right",
                argonRow(
                  center = T,
                  
                  argonColumn(
                    width = 1,
                    argonNavItem(
                      name = "facebook",
                      src = "https://www.facebook.com/Shubhram1992",
                      icon = icon("facebook-square"),
                      tooltip = "Like us on Facebook"
                    )
                  ),
                  argonColumn(
                    width = 1,
                    offset = 1,
                    argonNavItem(
                      name = "linkedin",
                      src = "https://www.linkedin.com/in/shubhrampandey/",
                      icon = icon("linkedin"),
                      tooltip = "Follow us on Linkedin"
                    )
                  ),
                  argonColumn(
                    width = 1,
                    offset = 1,
                    argonNavItem(
                      name = "github",
                      src = "https://github.com/shubhrampandey",
                      icon = icon("github"),
                      tooltip = "Star us on Github"
                    )
                  )
                )
              )
            )
          )
        )
        
                    )
      
      
      ),
    sidebar = NULL,
    body = argonDashBody(
      tags$head( tags$meta(name = "viewport", content = "width=1600"),uiOutput("body")),
      tags$br(),
      h5("Important Note:",style = 'color:Red;font-size:20px;text-align:Left;'),
      p("1. Now, WHO is not providng the number of recovered cases, hence webscrapping was done to obtain the same. In case of any discrepnecy in the numbers please contact with me.",style = 'color:Red;font-size:15px;text-align:Left;'),
      p(paste0("2. Dashboard will be updated on daily basis at GMT 00:00. Last update: ",lastUpdate),style = 'color:Red;font-size:15px;text-align:Left;'),
      tags$hr(),
           dashboardUI
    )
  )
  )

##### server #####
server <- function(input, output, session) {
  printLogJs = function(x, ...) {
    logjs(x)
    T
  }
  # addHandler(printLogJs)
  if (!Production) options(shiny.error = recover)
  options(shiny.sanitize.errors = TRUE, width = 160)
  
  session$onSessionEnded(function() {
    stopApp()
    # q("no")
  })
  source("appFiles/dashboardServer.R", local = TRUE)
  # Hide the loading message when the rest of the server function has executed
  waiter_hide() # will hide *on_load waiter
}

# Run the application
shinyApp(ui = ui, server = server)