#############################################################
# Topic: Calculating environmental-function correlation
#  Date: 03/19/2018
#    By: Y.F.T
############################################################

getwd()
setwd("/Users/YushiFTang/Desktop/Lab/Hangzhou_Bay/Function_network_re")
hard_arcspe_env <- read.csv("Temp_data/Arc_spe_env_cor_0.01.csv",row.names = 1)
hard_bacspe_env <- read.csv("Temp_data/Bac_spe_env_cor_0.01.csv",row.names = 1)
hard_arcfun_env <- read.csv("Temp_data/Arc_fun_env_cor_0.01.csv", row.names = 1)
hard_bacfun_env <- read.csv("Temp_data/Bac_fun_env_cor_0.01.csv", row.names = 1)
hard_arcfun_spe <- read.csv("Temp_data/Arc_fun_spe_cor_0.01.csv", row.names = 1)
hard_bacfun_spe <- read.csv("Temp_data/Bac_fun_spe_cor_0.01.csv", row.names = 1)



# 2. Degree distribution analysis ###########################
# 2.1 For species degree distribution #############################
degree_arc_spe <- as.data.frame(hard_arcspe_env[1:168,"sum_arc_fun"])
row.names(degree_arc_spe) <- rownames(hard_arcspe_env)[1:168]
degree_arc_spe <- cbind(degree_arc_spe, t(hard_arcfun_spe["sum_arc_spe",1:168]))
colnames(degree_arc_spe) <- c("degree_env","degree_fun")
degree_arc_spe$degree_arc_spe = degree_arc_spe$degree_env + degree_arc_spe$degree_fun

degree_bac_spe <- as.data.frame(hard_bacspe_env[1:1406,"sum_bac_fun"])
row.names(degree_bac_spe) <- rownames(hard_bacspe_env)[1:1406]
degree_bac_spe <- cbind(degree_bac_spe, t(hard_bacfun_spe["sum_bac_spe", 1:1406]))
colnames(degree_bac_spe) <- c("degree_env","degree_fun")
degree_bac_spe$degree_bac_spe = degree_bac_spe$degree_env + degree_bac_spe$degree_fun

sum_arc <- degree_arc_spe$degree_arc_spe[degree_arc_spe$degree_arc_spe!=0]
sum_arc <- sum_arc[1:(length(sum_arc)-1)]
fre_arc <- as.data.frame(table(sum_arc))
plot(fre_arc$sum_arc,fre_arc$Freq,type="p")


sum_bac <- degree_bac_spe$degree_bac_spe[degree_bac_spe$degree_bac_spe!=0]
sum_bac <- sum_bac[1:(length(sum_bac)-1)]
fre_bac <- as.data.frame(table(sum_bac))
plot(fre_bac$sum_bac,fre_bac$Freq,type="p")


# What if we only consider the relationship between 

write.csv(degree_arc_spe, file = "Temp_data/degree_arc_spe.csv", row.names=T)
write.csv(degree_bac_spe, file = "Temp_data/degree_bac_spe.csv", row.names=T)


library(ggplot2)
fre_arc_plot <- as.data.frame(sapply(fre_arc, as.integer))
ggplot(fre_arc_plot) +
  geom_point(aes(x=sum_arc, y=Freq)) +
  scale_y_log10() +
  scale_x_log10() +
  xlab("Degree") +
  ylab("Frequency") +
  ggtitle("Archaea Species Degree Distribution") +
  theme_bw() +
  theme(axis.text.x = element_text(hjust = 1)) +
  theme(plot.title=element_text(hjust=0.5))

fre_bac_plot <- as.data.frame(sapply(fre_bac, as.integer))
ggplot(fre_bac_plot) +
  geom_point(aes(x=sum_bac, y=Freq)) +
  scale_y_log10() +
  scale_x_log10() +
  xlab("Degree") +
  ylab("Frequency") +
  ggtitle("Bacterial Species Degree Distribution") +
  theme_bw() +
  theme(axis.text.x = element_text(hjust = 1)) +
  theme(plot.title=element_text(hjust=0.5))

write.csv(fre_arc_plot, file="Temp_data/fre_arc_spe_plot.csv", row.names=T)
write.csv(fre_bac_plot, file="Temp_data/fre_bac_spe_plot.csv", row.names=T)


# 2.2 For function degree distribution #######################
degree_arc_fun <- as.data.frame(hard_arcfun_spe[1:6575,"sum_arc_fun"])
row.names(degree_arc_fun) <- rownames(hard_arcfun_spe)[1:6575]
degree_arc_fun <- cbind(degree_arc_fun,hard_arcfun_env[1:6575,"sum_arc_fun"])
colnames(degree_arc_fun) <- c("degree_spe","degree_env")
degree_arc_fun$degree_arc_fun = degree_arc_fun$degree_spe + degree_arc_fun$degree_env

degree_bac_fun <- as.data.frame(hard_bacfun_spe[1:6575,"sum_bac_fun"])
row.names(degree_bac_fun) <- rownames(hard_bacfun_spe)[1:6575]
degree_bac_fun <- cbind(degree_bac_fun,hard_bacfun_env[1:6575,"sum_bac_fun"])
colnames(degree_bac_fun) <- c("degree_spe","degree_env")
degree_bac_fun$degree_bac_fun = degree_bac_fun$degree_spe + degree_bac_fun$degree_env


sum_arc <- degree_arc_fun$degree_arc_fun[degree_arc_fun$degree_arc_fun!=0]
sum_arc <- sum_arc[1:(length(sum_arc)-1)]
fre_arc <- as.data.frame(table(sum_arc))
plot(fre_arc$sum_arc,fre_arc$Freq,type="p")


sum_bac <- degree_bac_fun$degree_bac_fun[degree_bac_fun$degree_bac_fun!=0]
sum_bac <- sum_bac[1:(length(sum_bac)-1)]
fre_bac <- as.data.frame(table(sum_bac))
plot(fre_bac$sum_bac,fre_bac$Freq,type="p")

write.csv(degree_arc_fun, file = "Temp_data/degree_arc_fun.csv", row.names=T)
write.csv(degree_bac_fun, file = "Temp_data/degree_bac_fun.csv", row.names=T)



library(ggplot2)
fre_arc_plot <- as.data.frame(sapply(fre_arc, as.integer))
ggplot(fre_arc_plot) +
  geom_point(aes(x=sum_arc, y=Freq)) +
  scale_y_log10() +
  scale_x_log10() +
  xlab("Degree") +
  ylab("Frequency") +
  ggtitle("Archaea Function Degree Distribution") +
  theme_bw() +
  theme(axis.text.x = element_text(hjust = 1)) +
  theme(plot.title=element_text(hjust=0.5))

fre_bac_plot <- as.data.frame(sapply(fre_bac, as.integer))
ggplot(fre_bac_plot) +
  geom_point(aes(x=sum_bac, y=Freq)) +
  scale_y_log10() +
  scale_x_log10() +
  xlab("Degree") +
  ylab("Frequency") +
  ggtitle("Bacterial Function Degree Distribution") +
  theme_bw() +
  theme(axis.text.x = element_text(hjust = 1)) +
  theme(plot.title=element_text(hjust=0.5))

write.csv(fre_arc_plot, file="Temp_data/fre_arc_fun_plot.csv", row.names=T)
write.csv(fre_bac_plot, file="Temp_data/fre_bac_fun_plot.csv", row.names=T)


# 2.3 For environmental factors degree distribution ###################

# 2.4 Draw plot ##############################
# Manual edition for the function_degree and species_degree files in EXCEL
degree_function <- read.csv("Temp_data/function_degree.csv", header=T)
degree_species <- read.csv("Temp_data/species_degree.csv", header=T)

library(ggplot2)
ggplot(degree_function) +
  geom_point(aes(x=function_degree, y=freq, color=species), size=2.4) +
  scale_y_log10() +
  scale_x_log10() +
  xlab("Degree") +
  ylab("Frequency (absolute)") +
  ggtitle("Microbial Function Degree Distribution") +
  theme_bw() +
  theme(axis.text.x = element_text(hjust = 1)) +
  theme(text = element_text(size=15)) +
  theme(plot.title=element_text(hjust=0.5))

ggplot(degree_function) +
  geom_point(aes(x=function_degree, y=relative_freq, color=species),size=2.4) +
  scale_y_log10() +
  scale_x_log10() +
  xlab("Degree") +
  ylab("Frequency (relative)") +
  ggtitle("Microbial Function Degree Distribution") +
  theme_bw() +
  theme(axis.text.x = element_text(hjust = 1)) +
  theme(text = element_text(size=15)) +
  theme(plot.title=element_text(hjust=0.5))


ggplot(degree_species) +
  geom_point(aes(x=species_degree, y=freq, color=species),size=2.4) +
  scale_y_log10() +
  scale_x_log10() +
  xlab("Degree") +
  ylab("Frequency (absolute)") +
  ggtitle("Microbial Species Degree Distribution") +
  theme_bw() +
  theme(axis.text.x = element_text(hjust = 1)) +
  theme(text = element_text(size=15)) +
  theme(plot.title=element_text(hjust=0.5))

ggplot(degree_species) +
  geom_point(aes(x=species_degree, y=relative_freq, color=species),size=2.4) +
  scale_y_log10() +
  scale_x_log10() +
  xlab("Degree") +
  ylab("Frequency (relative)") +
  ggtitle("Microbial Species Degree Distribution") +
  theme_bw() +
  theme(axis.text.x = element_text(hjust = 1)) +
  theme(text = element_text(size=15)) +
  theme(plot.title=element_text(hjust=0.5))
