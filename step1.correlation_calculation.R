#############################################################
# Topic: Calculating environmental-function correlation
#  Date: 12/21/2017
#    By: Y.F.T
############################################################

getwd()
setwd("/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re")
arcfun <- read.csv("Temp_data/arc_function_trans.csv",header=T,row.names=1)
bacfun <- read.csv("Temp_data/bac_function_trans.csv",header=T,row.names=1)
env_19 <- read.csv("Temp_data/environment_19_trans.csv",header=T,row.names=1)
arcspe <- read.csv("Temp_data/arc_spe_tran.csv",header=T,row.names=1)
bacspe <- read.csv("Temp_data/bac_spe_tran.csv",header=T,row.names=1)


arc_fun <- as.data.frame(sapply(arcfun[2:13,], as.numeric))
bac_fun <- as.data.frame(sapply(bacfun[2:13,], as.numeric))
env <- as.data.frame(sapply(env_19[,2:20], as.numeric))
arc_spe_original <- as.data.frame(sapply(arcspe[2:13,], as.numeric))
bac_spe_original <- as.data.frame(sapply(bacspe[2:13,], as.numeric))

arc_spe = arc_spe_original
bac_spe = bac_spe_original

for(i in 1:12){
  sum = rowSums(arc_spe_original)[i]
  for(j in 1:ncol(arc_spe_original)){
    arc_spe[i,j] = arc_spe_original[i,j] / sum
  }
}

for(i in 1:12){
  sum = rowSums(bac_spe_original)[i]
  for(j in 1:ncol(bac_spe_original)){
    bac_spe[i,j] = bac_spe_original[i,j] / sum
  }
}

arcfun_env_cor <- as.data.frame(cor(arc_fun,env, method="pearson"))
bacfun_env_cor <- as.data.frame(cor(bac_fun,env, method="pearson"))
arcspe_env_cor <- as.data.frame(cor(arc_spe,env, method="pearson"))
bacspe_env_cor <- as.data.frame(cor(bac_spe,env, method="pearson"))
arcfun_spe_cor <- as.data.frame(cor(arc_fun,arc_spe, method="pearson"))
bacfun_spe_cor <- as.data.frame(cor(bac_fun,bac_spe, method="pearson"))


pearson_t <- function(dat){
  return(dat/sqrt((1-dat^2)/(12-2)))
}
# abs(t) is supposed to be larger than 3.169 (alpha=0.01)

arcfun_env_t <- as.data.frame(sapply(arcfun_env_cor, pearson_t))
bacfun_env_t <- as.data.frame(sapply(bacfun_env_cor, pearson_t))
arcspe_env_t <- as.data.frame(sapply(arcspe_env_cor, pearson_t))
bacspe_env_t <- as.data.frame(sapply(bacspe_env_cor, pearson_t))
arcfun_spe_t <- as.data.frame(sapply(arcfun_spe_cor, pearson_t))
bacfun_spe_t <- as.data.frame(sapply(bacfun_spe_cor, pearson_t))




# Selecte correlation with p-value less than 0.01
replace <- function(dat){
  return(ifelse(abs(dat)>3.169, 1, 0) )
}


hard_arcfun_env <- as.data.frame(sapply(arcfun_env_t, replace))
hard_bacfun_env <- as.data.frame(sapply(bacfun_env_t, replace))
hard_arcspe_env <- as.data.frame(sapply(arcspe_env_t, replace))
hard_bacspe_env <- as.data.frame(sapply(bacspe_env_t, replace))
hard_arcfun_spe <- as.data.frame(sapply(arcfun_spe_t, replace))
hard_bacfun_spe <- as.data.frame(sapply(bacfun_spe_t, replace))


row.names(hard_arcfun_env) <- colnames(arc_fun)
row.names(hard_bacfun_env) <- colnames(bac_fun)
row.names(hard_arcspe_env) <- colnames(arc_spe)
row.names(hard_bacspe_env) <- colnames(bac_spe)
row.names(hard_arcfun_spe) <- colnames(arc_fun)
row.names(hard_bacfun_spe) <- colnames(bac_fun)

# hard_bacfun_spe[is.na(hard_bacfun_spe)] <- 0
# hard_bacspe_env[is.na(hard_bacspe_env)] <- 0

sum(hard_arcfun_env)
sum(hard_bacfun_env)
sum(hard_arcspe_env)
sum(hard_bacspe_env)
sum(hard_arcfun_spe)
sum(hard_bacfun_spe)

hard_arcfun_env$sum_arc_fun <- rowSums(hard_arcfun_env)
hard_bacfun_env$sum_bac_fun <- rowSums(hard_bacfun_env)
hard_arcspe_env$sum_arc_fun <- rowSums(hard_arcspe_env)
hard_bacspe_env$sum_bac_fun <- rowSums(hard_bacspe_env)
hard_arcfun_spe$sum_arc_fun <- rowSums(hard_arcfun_spe)
hard_bacfun_spe$sum_bac_fun <- rowSums(hard_bacfun_spe)



hard_arcfun_env["sum_env",] <- colSums(hard_arcfun_env)
hard_bacfun_env["sum_env",] <- colSums(hard_bacfun_env)
hard_arcspe_env["sum_env",] <- colSums(hard_arcspe_env)
hard_bacspe_env["sum_env",] <- colSums(hard_bacspe_env)
hard_arcfun_spe["sum_arc_spe",] <- colSums(hard_arcfun_spe)
hard_bacfun_spe["sum_bac_spe",] <- colSums(hard_bacfun_spe)


hard_arcfun_env[1:(nrow(hard_arcfun_env)-1),"annotation"] <- t(arcfun[1,])
hard_bacfun_env[1:(nrow(hard_bacfun_env)-1),"annotation"] <- t(bacfun[1,])
hard_arcspe_env[1:(nrow(hard_arcspe_env)-1),"annotation"] <- t(arcspe[1,])
hard_bacspe_env[1:(nrow(hard_bacspe_env)-1),"annotation"] <- t(bacspe[1,])
hard_arcfun_spe[1:(nrow(hard_arcfun_env)-1),"annotation"] <- t(arcfun[1,])
hard_bacfun_spe[1:(nrow(hard_bacfun_env)-1),"annotation"] <- t(bacfun[1,])


write.csv(hard_arcfun_env,file="Temp_data/Arc_fun_env_cor_0.01.csv",row.names=T)
write.csv(hard_bacfun_env,file="Temp_data/Bac_fun_env_cor_0.01.csv",row.names=T)
write.csv(hard_arcspe_env,file="Temp_data/Arc_spe_env_cor_0.01.csv",row.names=T)
write.csv(hard_bacspe_env,file="Temp_data/Bac_spe_env_cor_0.01.csv",row.names=T)
write.csv(hard_arcfun_spe,file="Temp_data/Arc_fun_spe_cor_0.01.csv",row.names=T)
write.csv(hard_bacfun_spe,file="Temp_data/Bac_fun_spe_cor_0.01.csv",row.names=T)


