###################################################
# Target: Step3 Generating Edges and Nodes Tables
#   Date: 01/05/2018
#     By: Y.F.T
####################################################

getwd()
setwd("/Users/YushiFTang/Desktop/Lab/Hangzhou_Bay/Function_network_re")
# 1. Environemntal factors and species #################
# 1.1 Archaea
arc_spe_env <- read.csv("Temp_data/Arc_spe_env_cor_0.01.csv", header=T, row.names=1)
arc_spe_env_edges <- data.frame()
for(i in 1:(nrow(arc_spe_env)-1)) {
  for(j in 1:(ncol(arc_spe_env)-2)){
    if(arc_spe_env[i,j] == 1){
      arc_spe_env_edges <- rbind(arc_spe_env_edges, data.frame(row.names(arc_spe_env)[i], colnames(arc_spe_env)[j]))
    }
  }
}
colnames(arc_spe_env_edges) <- c('species','environment factors')
write.csv(arc_spe_env_edges, "Temp_data/Network/arc_spe_env_edges.csv",row.names=F)

# 1.2 Bacteria
bac_spe_env <- read.csv("Temp_data/Bac_spe_env_cor_0.01.csv", header=T, row.names=1)
bac_spe_env_edges <- data.frame()
for(i in 1:(nrow(bac_spe_env)-1)) {
  for(j in 1:(ncol(bac_spe_env)-2)){
    if(bac_spe_env[i,j] == 1){
      bac_spe_env_edges <- rbind(bac_spe_env_edges, data.frame(row.names(bac_spe_env)[i], colnames(bac_spe_env)[j]))
    }
  }
}
colnames(bac_spe_env_edges) <- c('species','environment factors')
write.csv(bac_spe_env_edges, "Temp_data/Network/bac_spe_env_edges.csv",row.names=F)


# 2. Environmental factors and functions ###################
# 2.1 Archaea
arc_fun_env <- read.csv("Temp_data/Arc_fun_env_cor_0.01.csv", header=T, row.names=1)
arc_fun_env_edges <- data.frame()
for(i in 1:(nrow(arc_fun_env)-1)) {
  for(j in 1:(ncol(arc_fun_env)-2)){
    if(arc_fun_env[i,j] == 1){
      arc_fun_env_edges <- rbind(arc_fun_env_edges, data.frame(row.names(arc_fun_env)[i], colnames(arc_fun_env)[j]))
    }
  }
}
colnames(arc_fun_env_edges) <- c('functions','environment factors')
write.csv(arc_fun_env_edges, "Temp_data/Network/arc_fun_env_edges.csv",row.names=F)

# 2.2 Bacteria
bac_fun_env <- read.csv("Temp_data/Bac_fun_env_cor_0.01.csv", header=T, row.names=1)
bac_fun_env_edges <- data.frame()
for(i in 1:(nrow(bac_fun_env)-1)) {
  for(j in 1:(ncol(bac_fun_env)-2)){
    if(bac_fun_env[i,j] == 1){
      bac_fun_env_edges <- rbind(bac_fun_env_edges, data.frame(row.names(bac_fun_env)[i], colnames(bac_fun_env)[j]))
    }
  }
}
colnames(bac_fun_env_edges) <- c('species','environment factors')
write.csv(bac_fun_env_edges, "Temp_data/Network/bac_fun_env_edges.csv",row.names=F)


which.names <- function(DF, value){
  ind <- which(DF==value, arr.ind=TRUE)
  g1 <- data.frame()
  g1 <- rbind(g1, data.frame(rownames(DF)[ind[,"row"]],  colnames(DF)[ind[,"col"]]))
  return(g1)
}

bac_fun_env_edges <- which.names(bac_fun_env[1:(nrow(bac_fun_env)-1),1:(ncol(bac_fun_env)-2)], 1)
write.csv(bac_fun_env_edges, "Temp_data/Network/bac_fun_env_edges_2.csv",row.names=F)



# 3. Species and functions #######################
# 3.1 Archaea
arc_fun_spe <- read.csv("Temp_data/Arc_fun_spe_cor_0.01.csv", header=T, row.names=1)

which.names <- function(DF, value){
  ind <- which(DF==value, arr.ind=TRUE)
  g1 <- data.frame()
  g1 <- rbind(g1, data.frame(rownames(DF)[ind[,"row"]],  colnames(DF)[ind[,"col"]]))
  return(g1)
}

arc_fun_spe_edges <- which.names(arc_fun_spe[1:(nrow(arc_fun_spe)-1),1:(ncol(arc_fun_spe)-2)],1)
colnames(arc_fun_spe_edges) <- c('functions','species')
write.csv(arc_fun_spe_edges, "Temp_data/Network/arc_fun_spe_edges.csv",row.names=F)

# 3.2 Bacteria
bac_fun_spe <- read.csv("Temp_data/Bac_fun_spe_cor_0.01.csv", header=T, row.names=1)
bac_fun_spe_edges <- data.frame()

bac_fun_spe_edges <- which.names(bac_fun_spe[1:6575,1:1406],1)

colnames(bac_fun_spe_edges) <- c('functions','species')
write.csv(bac_fun_spe_edges, "Temp_data/Network/bac_fun_spe_edges.csv",row.names=F)
