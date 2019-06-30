#######################################################################
# Topic: Calculation for species ecological indicators 
#  Date: 01/10/2018
#    By: Y.F.T
########################################################################
getwd()
setwd("~/Desktop/Lab/Hangzhou_Bay/Function_network_re")
arc_original <- read.csv("Temp_data/arc_36_trans.csv",header=T, row.names=1)
bac_original <- read.csv("Temp_data/bac_36_trans.csv",header=T, row.names=1)
sample <- read.csv("Temp_data/sample.csv",header=T, row.names=1)
arc <- arc_original[2:37,]
bac <- bac_original[2:37,]

# 1.0 Ecological indicators calculating ###############################
# 1.1 Variance and mean of abundance ##################
arc_eco <- bac_spea.frame()
bac_eco <- bac_spea.frame()
arc_eco <- t(arc_original[1,])
bac_eco <- t(bac_original[1,])
row.names(arc_eco) <- colnames(arc_original)
row.names(bac_eco) <- colnames(bac_original)

arc_per <- read.csv("Temp_data/arc_36_relative_spe.csv", header=T, row.names=1)
bac_per <- read.csv("Temp_data/bac_36_relative_spe.csv", header=T, row.names=1)
arc_per <- arc_per[,2:37]
bac_per <- bac_per[,2:37]
for(i in 1:nrow(arc_per)){
  arc_per[i, 'var'] <- var(t(arc_per[i,1:36]))
  arc_per[i, 'mean'] <- mean(t(arc_per[i,1:36]))
}

for(i in 1:nrow(bac_per)){
  bac_per[i, 'var'] <- var(t(bac_per[i,1:36]))
  bac_per[i, 'mean'] <- mean(t(bac_per[i,1:36]))
}

arc_eco <- cbind(arc_eco, arc_per[,c("var","mean")])
bac_eco <- cbind(bac_eco, bac_per[,c("var","mean")])

# 1.2 Contribution to the dissimilarity ###################

library(vegan)
arc_sim <- as.bac_spea.frame(sapply(arc, as.numeric))
bac_sim <- as.bac_spea.frame(sapply(bac, as.numeric))

row.names(arc_sim) <- row.names(arc)
row.names(bac_sim) <- row.names(bac)

sim_arc <- with(sample, simper(arc_sim, Sample))
sim_bac <- with(sample, simper(bac_sim, Sample))

con_arc <- as.bac_spea.frame(sim_arc[[1]]$average)
row.names(con_arc) <- sim_arc[[1]]$species
for(i in 2:length(sim_arc)){
  con_arc <- cbind(con_arc, sim_arc[[i]]$average)
}

con_bac <- as.bac_spea.frame(sim_bac[[1]]$average)
row.names(con_bac) <- sim_bac[[1]]$species
for(i in 2:length(sim_bac)){
  con_bac <- cbind(con_bac, sim_bac[[i]]$average)
}



for(i in 1:nrow(con_arc)){
  con_arc[i, 'mean_cd'] <- mean(t(con_arc[i,1:66]))
}

for(i in 1:nrow(con_bac)){
  con_bac[i, 'mean_cd'] <- mean(t(con_bac[i,1:66]))
}

arc_eco <- cbind(arc_eco, con_arc$mean_cd)
bac_eco <- cbind(bac_eco, con_bac$mean_cd)


# 1.3 Contribution diversity ###################################
## Artificial example given in
## Table 2 in Lu et al. 2007
#x <- matrix(c(
# 1/3,1/3,1/3,0,0,0,
#  0,0,1/3,1/3,1/3,0,
#  0,0,0,1/3,1/3,1/3),
#  3, 6, byrow = TRUE,
#  dimnames = list(LETTERS[1:3],letters[1:6]))
#x

arc_per <- arc_per[,1:36]
bac_per <- bac_per[,1:36]

arc_contribdiv_rich <- contribdiv(arc_per, 'richness')
bac_contribdiv_rich <- contribdiv(bac_per, 'richness')
colnames(arc_contribdiv_rich) <- c("rich_alpha","rich_beta","rich_gamma")
colnames(bac_contribdiv_rich) <- c("rich_alpha","rich_beta","rich_gamma")

arc_eco <- cbind(arc_eco, arc_contribdiv_rich)
bac_eco <- cbind(bac_eco, bac_contribdiv_rich)



arc_contribdiv_simp <- contribdiv(arc_per, 'simpson')
bac_contribdiv_simp <- contribdiv(bac_per, 'simpson')
colnames(arc_contribdiv_simp) <- c("simpson_alpha","simpson_beta","simpson_gamma")
colnames(bac_contribdiv_simp) <- c("simpson_alpha","simpson_beta","simpson_gamma")

arc_eco <- cbind(arc_eco, arc_contribdiv_simp)
bac_eco <- cbind(bac_eco, bac_contribdiv_simp)

# 2. Degree calculation ##################################
degree_arc <- read.csv("Temp_data/degree_arc_spe.csv",header=T, row.names=1)
degree_bac <- read.csv("Temp_data/degree_bac_spe.csv",header=T, row.names=1)

arc_eco <- cbind(arc_eco, degree_arc$degree_arc_spe)
bac_eco <- cbind(bac_eco, degree_bac$degree_bac_spe)

write.csv(arc_eco, "Table/arc_eco_indicator.csv")
write.csv(bac_eco, "Table/bac_eco_indicator.csv")

# 3. Add classification information #############################
arc_eco <- read.csv("Table/arc_eco_indicator.csv", header=T, row.names=1)
bac_eco <- read.csv("Table/bac_eco_indicator.csv", header=T, row.names=1)

arc_eco <- arc_eco[,1:10]
bac_eco <- bac_eco[,1:10]

arc_original <- read.csv("Temp_data/arc_36_relative_spe.csv",header=T, row.names=1)
bac_original <- read.csv("Temp_data/bac_36_relative_spe.csv",header=T, row.names=1)

arc_spe <- arc_original[,2:37]
bac_spe <- bac_original[,2:37]
arc_spe$category <- -1
bac_spe$category <- -1

# Annotation #######################
# 1: RT
# 2: MT
# 3: AT
# 4: CRT
# 5: CAT
# 6: CRAT
####################################

category <- function(dat){
  for (i in 1:nrow(dat)){
    if( min(dat[i,1:36]) < 0.001 & max(dat[i,1:36]) < 0.001){ 
      dat[i,'category'] <- 1
      }
    if( 0.001 <= min(dat[i,1:36]) & min(dat[i,1:36]) < 0.01 & 0.001 <= max(dat[i,1:36]) & max(dat[i,1:36]) <= 0.01 ){
      dat[i,'category'] <- 2
      }
    if( 0.01 <= min(dat[i,1:36]) & 0.01 <= max(dat[i,1:36])){
      dat[i,'category'] <- 3
      }
    if( min(dat[i,1:36]) < 0.001 & 0.001 <= max(dat[i,1:36]) & max(dat[i,1:36]) < 0.01){
      dat[i,'category'] <- 4
      }
    if( 0.001 <= min(dat[i,1:36]) & min(dat[i,1:36]) < 0.01 & 0.01 <= max(dat[i,1:36])){
      dat[i,'category'] <- 5
      }
    if( min(dat[i,1:36]) < 0.001 & 0.01 <= max(dat[i,1:36])){
      dat[i,'category'] <- 6
    }
  }
  return(dat)
}


arc_spe <- category(arc_spe)
bac_spe <- category(bac_spe)

arc_eco <- cbind(arc_eco, arc_spe$category)
bac_eco <- cbind(bac_eco, bac_spe$category)

write.csv(arc_eco, "Table/arc_eco_indicator.csv")
write.csv(bac_eco, "Table/bac_eco_indicator.csv")


