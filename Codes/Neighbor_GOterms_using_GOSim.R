## Author - Ajaya Kumar Sahoo
# This code gives the neighbor GO terms (parents and children) using the GOSim R package for a list of GO terms as input

library(GOSim)

# input file with GO term id as the 1st column and GO term name as 2nd column
inp <- read.delim('input.tsv',sep='\t') #provide the name of the input file here

GetParentsList<- function(val){
  parents_GO <- c()
  parentslist <- getParents()[[val]]
  #print(parents)
  if (length(parentslist) == 0){
    return('')
  } else {
    for (i in 1:length(parentslist)){
      parents_GO <- c(parents_GO,parentslist[[i]])
    }
    allparents <- paste(parents_GO,collapse='|')
    return(allparents)
  }
}

parents <- c()
parents <- apply(inp[c('phenotypeid')], 1, GetParentsList)                        


GetChildrensList<- function(val){
  children_GO <- c()
  childrenslist <- getChildren()[[val]]
  #print(childrens)
  if (length(childrenslist) == 0){
    return('')
  } else {
    for (i in 1:length(childrenslist)){
      children_GO <- c(children_GO,childrenslist[[i]])
    }
    allchildrens <- paste(children_GO,collapse='|')
    return(allchildrens)
  }
}

childrens <- c()
childrens <- apply(inp[c('phenotypeid')], 1, GetChildrensList)    

inp1 <- cbind(inp,parents,childrens)

write.table(inp1,file='GOterm_neighbor.tsv',quote=FALSE,sep='\t',na='',row.names=FALSE)
