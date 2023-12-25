#' Tab navigation creator
#'
#' Create a tab navigator for a list of visuals 
#' @param visualList the list of all visuals 
#' @param tabVec a vector of character names for each visual of the tabs
#' @return a tab navigation output
#' @examples 
#' tab_vis <- tabFUN(list(table1,plot1),c("Table","Plot"))
#' @export

tabFUN <- function(visualList,tabVec) {
  
  if (length(visualList)!=length(tabVec)) {
    
    stop("Visual list is not the same length as tab labels!")
    
  }
  
  rand <- sample.int(99999999,1)
  
  aTag <- list()
  
  for (i in 1:length(tabVec)) {
    
    aTag[[i]] <- htmltools::a(tabVec[i],
                              href="#",
                              id=paste0("tab",rand,i))
    
  }
  
  divTag <- list()
  
  for (i in 1:length(tabVec)) {
    
    if (i==1) {
      
      divTag[[1]] <- htmltools::tags$div(visualList[[1]],
                                         id=paste0("tab",rand,1))
      
    } else {
      
      divTag[[i]] <- htmltools::tags$div(visualList[[i]],
                                         id=paste0("tab",rand,i),
                                         class=paste0("hidenav",rand))
      
    }
    
  }
  
  arr <- paste(seq(1,length(tabVec)),collapse=", ")
  
  htmltools::tags$html(
    htmltools::tags$style(
      ".top {
  background:#99b5c7;
  overflow:hidden;
  font-family:'Varela Round';
  color: #f2f2f2;
  }
  .top a {
  float: left;
  display: block;
  color: black;
  text-align: center;
  margin-right: 50px;
  margin-left: 15px;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  }
  .top a:hover {
  background-color: #ddd;
  color: black;
  }
  a:checked {
  background-color: #ddd;
  color: black;
  }"),
  htmltools::br(),
  htmltools::br(),
  htmltools::tags$script(src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"),
  htmltools::tags$script(paste0(
    "$(document).ready(function(){
    
    const rand =",rand," 
    const arr = [",arr,"]
    $.each( arr, function( index, value ){
  
      $('a#tab'+rand+value).on('click',function() {
        
        function canFil(ind) {
          return ind != arr[index]
        };
  
        let newarr = arr.filter(canFil);
  
        $.each( newarr, function( index2, value2 ){
          $('div#tab'+rand+value2).hide(); 
        });
  
        $('div#tab'+rand+value).fadeIn();
          return false;
        });
  
    });
      
    $( window ).load(function () {
      $('div.hidenav'+rand).hide();
    }); 
  
  });
"
  )),
htmltools::div(id=paste0("navbar",rand),
               class="top",
               aTag,
),
htmltools::br(),
htmltools::br(),
divTag)
  
  
}