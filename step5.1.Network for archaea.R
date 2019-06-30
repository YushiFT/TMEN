################################################
# Topic: Construct Archaea Network
#  Date: 01/05/2018
#    By: Y.F.T
################################################
getwd()
setwd("~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/")

library(igraph)

arc_fun_env_edges <- read.csv("Temp_data/Network/arc_fun_env_edges.csv",header=T)
arc_fun_spe_edges <- read.csv("Temp_data/Network/arc_fun_spe_edges.csv",header=T)
arc_spe_env_edges <- read.csv("Temp_data/Network/arc_spe_env_edges.csv",header=T)

colnames(arc_fun_env_edges) <- c("V1","V2")
colnames(arc_fun_spe_edges) <- c("V1","V2")
colnames(arc_spe_env_edges) <- c("V1","V2")

arc_edges <- rbind(arc_fun_env_edges, arc_fun_spe_edges)
arc_edges <- rbind(arc_edges, arc_spe_env_edges)

arc_nodes <- read.csv("Temp_data/Network/nodes_archaea.csv")

# 1.0 Plot the total tripartite graph ######################################

g.arc <- graph_from_data_frame(d = arc_edges, vertices = arc_nodes, directed=FALSE)

# Delete nodes with 0 degree
g.arc.new <- delete_vertices(g.arc, degree(g.arc, mode=c("total"))==0)

# Plot network and color vertices by type
V(g.arc.new)$color <- ifelse(V(g.arc.new)$type == 'environmental factors', "red", "dodgerblue")
V(g.arc.new)$color <- ifelse(V(g.arc.new)$type == 'functions', "green", V(g.arc.new)$color)

# Identify key nodes using eigenvector centrality
g.arc.new.ec <- eigen_centrality(g.arc.new)
which.max(g.arc.new.ec$vector)

tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc.note.tiff",width=1600,height=1600,pointsize=36)
plot(g.arc.new,
     vertex.label = NA,
     vertex.size = 18*(g.arc.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.02,
     layout = layout_in_circle(g.arc.new),
     main = "Tripartite Microbe-Environment Network of Archaea")
dev.off()

tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc.note_3.tiff",width=1600,height=1600,pointsize=36)
plot(g.arc.new,
     vertex.label = NA,
     vertex.size = 18*(g.arc.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.14,
     layout = layout_components(g.arc.new),
     main = "Tripartite Microbe-Environment Network of Archaea")
dev.off()




# 2.0 Plot the spe_env factors seperately ###################################################
g.arc.spe.env <- graph_from_data_frame(d = arc_spe_env_edges, vertices = arc_nodes, directed = FALSE)
g.arc.spe.env.new <- delete_vertices(g.arc.spe.env, degree(g.arc.spe.env, mode=c("total"))==0)

V(g.arc.spe.env.new)$color <- ifelse(V(g.arc.spe.env.new)$type == 'environmental factors', "red", "dodgerblue")


# Identify key nodes using eigenvector centrality
g.arc.spe.env.new.ec <- eigen_centrality(g.arc.spe.env.new)


tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc_spe_env.note.tiff",width=1600,height=1600,pointsize=36)
plot(g.arc.spe.env.new,
     vertex.label.color = "black", 
     vertex.label.cex = 0.9,
     vertex.size = 18*(g.arc.spe.env.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.7,
     layout = layout_in_circle(g.arc.spe.env.new),
     main = "Bipartite Microbial Species-Environment Network of Archaea")
dev.off()

tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc_spe_env.note_2.tiff",width=1600,height=1600,pointsize=36)
plot(g.arc.spe.env.new,
     vertex.label.color = "black", 
     vertex.label.cex = 0.7,
     vertex.size = 18*(g.arc.spe.env.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.7,
     layout = layout_components(g.arc.spe.env.new),
     main = "Bipartite Microbial Species-Environment Network of Archaea")
dev.off()

tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc_spe_env.note_3.tiff",width=1600,height=1600,pointsize=36)
plot(g.arc.spe.env.new,
     vertex.size = 18*(g.arc.spe.env.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.7,
     layout = layout_components(g.arc.spe.env.new),
     main = "Bipartite Microbial Species-Environment Network of Archaea")
dev.off()

tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc_spe_env.note_4.tiff",width=1600,height=1600,pointsize=36)
plot(g.arc.spe.env.new,
     vertex.label = NA,
     vertex.size = 18*(g.arc.spe.env.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.7,
     layout = layout_components(g.arc.spe.env.new),
     main = "Bipartite Microbial Species-Environment Network of Archaea")
dev.off()


# 3.0 Plot the fun_env factors seperately ###########################################################
g.arc.fun.env <- graph_from_data_frame(d = arc_fun_env_edges, vertices = arc_nodes, directed = FALSE)
g.arc.fun.env.new <- delete_vertices(g.arc.fun.env, degree(g.arc.fun.env, mode=c("total"))==0)

V(g.arc.fun.env.new)$color <- ifelse(V(g.arc.fun.env.new)$type == 'environmental factors', "red", "green")


# Identify key nodes using eigenvector centrality
g.arc.fun.env.new.ec <- eigen_centrality(g.arc.fun.env.new)
(g.arc.fun.env.new.ec$vector[1:20])

tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc_fun_env.note.tiff",width=1600,height=1600,pointsize=36)
plot(g.arc.fun.env.new,
     vertex.label.color = "black", 
     vertex.label.cex = 0.2,
     vertex.size = 18*(g.arc.fun.env.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.3,
     layout = layout_components(g.arc.fun.env.new),
     main = "Bipartite Microbial Functions-Environment Network of Archaea")
dev.off()

tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc_fun_env_2.tiff",width=1600,height=1600,pointsize=36)
plot(g.arc.fun.env.new,
     vertex.label = NA, 
     vertex.size = 18*(g.arc.fun.env.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.7,
     layout = layout_components(g.arc.fun.env.new),
     main = "Bipartite Microbial Functions-Environment Network of Archaea")
dev.off()




# 4.0 Detect community ########################
# Fast-greedy community determine
ac <- fastgreedy.community(g.arc.new)

# Determine sizes of each community
sizes(ac)

# Determine which individuals belong to which community
mac <- membership(ac)
mac[1]

plot(ac, g.arc.new)

tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc_community.tiff",width=1600,height=1600,pointsize=15)
plot_dendrogram(ac)
dev.off()

# Community figure for main paper
# subgraph of community 1
g.arc.mod1 <- induced.subgraph(graph = g.arc.new, vids = ac[[1]] )
# Identify key nodes using eigenvector centrality
g.arc.mod1.ec <- eigen_centrality(g.arc.mod1)

V(g.arc.mod1)$color = "limegreen"

plot(g.arc.mod1,
     vertex.label = NA,
     vertex.size = 18*(g.arc.mod1.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.36,
     layout = layout_in_circle(g.arc.mod1),
     main = "Community 1 of TMEN for Archaea")

# subgraph of community 2
g.arc.mod2 <- induced.subgraph(graph = g.arc.new, vids = ac[[2]] )
# Identify key nodes using eigenvector centrality
g.arc.mod2.ec <- eigen_centrality(g.arc.mod2)

V(g.arc.mod2)$color = "orange"

plot(g.arc.mod2,
     vertex.label = NA,
     vertex.label.cex = 0.5,
     vertex.size = 18*(g.arc.mod2.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.36,
     layout = layout_in_circle(g.arc.mod2),
     main = "Community 2 of TMEN for Archaea")

# subgraph of community 3
g.arc.mod3 <- induced.subgraph(graph = g.arc.new, vids = ac[[3]] )
# Identify key nodes using eigenvector centrality
g.arc.mod3.ec <- eigen_centrality(g.arc.mod3)

V(g.arc.mod3)$color = "lightskyblue"

plot(g.arc.mod3,
     vertex.label = NA,
     vertex.size = 18*(g.arc.mod3.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.36,
     layout = layout_in_circle(g.arc.mod3),
     main = "Community 3 of TMEN for Archaea")

# subgraph of community 4
g.arc.mod4 <- induced.subgraph(graph = g.arc.new, vids = ac[[4]] )
# Identify key nodes using eigenvector centrality
g.arc.mod4.ec <- eigen_centrality(g.arc.mod4)

V(g.arc.mod4)$color = "khaki1"

plot(g.arc.mod4,
     vertex.label = NA,
     vertex.size = 18*(g.arc.mod4.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.36,
     layout = layout_in_circle(g.arc.mod4),
     main = "Community 4 of TMEN for Archaea")

# subgraph of community 5
g.arc.mod5 <- induced.subgraph(graph = g.arc.new, vids = ac[[5]] )
# Identify key nodes using eigenvector centrality
g.arc.mod5.ec <- eigen_centrality(g.arc.mod5)

V(g.arc.mod5)$color = "dodgerblue2"

plot(g.arc.mod5,
     vertex.label = NA,
     vertex.size = 18*(g.arc.mod5.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.36,
     layout = layout_in_circle(g.arc.mod5),
     main = "Community 5 of TMEN for Archaea")

# subgraph of community 6
g.arc.mod6 <- induced.subgraph(graph = g.arc.new, vids = ac[[6]] )
# Identify key nodes using eigenvector centrality
g.arc.mod6.ec <- eigen_centrality(g.arc.mod6)

V(g.arc.mod6)$color = "darkorange2"

plot(g.arc.mod6,
     vertex.label = NA,
     vertex.size = 18*(g.arc.mod6.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.36,
     layout = layout_in_circle(g.arc.mod6),
     main = "Community 6 of TMEN for Archaea")

# subgraph of community 7
g.arc.mod7 <- induced.subgraph(graph = g.arc.new, vids = ac[[7]] )
# Identify key nodes using eigenvector centrality
g.arc.mod7.ec <- eigen_centrality(g.arc.mod7)

V(g.arc.mod7)$color = "lightcoral"

plot(g.arc.mod7,
     vertex.label = NA,
     vertex.size = 18*(g.arc.mod7.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.36,
     layout = layout_in_circle(g.arc.mod7),
     main = "Community 7 of TMEN for Archaea")

# subgraph of community 8
g.arc.mod8 <- induced.subgraph(graph = g.arc.new, vids = ac[[8]] )
# Identify key nodes using eigenvector centrality
g.arc.mod8.ec <- eigen_centrality(g.arc.mod8)

V(g.arc.mod8)$color = "violet"

plot(g.arc.mod8,
     vertex.label = NA,
     vertex.size = 18*(g.arc.mod8.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.36,
     layout = layout_in_circle(g.arc.mod8),
     main = "Community 8 of TMEN for Archaea")

# subgraph of community 9
g.arc.mod9 <- induced.subgraph(graph = g.arc.new, vids = ac[[9]] )
# Identify key nodes using eigenvector centrality
g.arc.mod9.ec <- eigen_centrality(g.arc.mod9)

V(g.arc.mod9)$color = "orangered"

plot(g.arc.mod9,
     vertex.label = NA,
     vertex.size = 18*(g.arc.mod9.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.36,
     layout = layout_in_circle(g.arc.mod9),
     main = "Community 9 of TMEN for Archaea")



# Community figure for supplimentary paper
plot(g.arc.mod1,
     vertex.label = NA,
     vertex.size = 18*(g.arc.mod1.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.02,
     layout = layout_components(g.arc.mod1),
     main = "Community 1 of TMEN for Archaea")

# subgraph of community 2
g.arc.mod2 <- induced.subgraph(graph = g.arc.new, vids = ac[[2]] )
# Identify key nodes using eigenvector centrality
g.arc.mod2.ec <- eigen_centrality(g.arc.mod2)


plot(g.arc.mod2,
     vertex.label.col = "black",
     vertex.label.cex = 0.5,
     vertex.size = 18*(g.arc.mod2.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.7,
     layout = layout_in_circle(g.arc.mod2),
     main = "Community 2 of TMEN for Archaea")

# subgraph of community 3
g.arc.mod3 <- induced.subgraph(graph = g.arc.new, vids = ac[[3]] )
# Identify key nodes using eigenvector centrality
g.arc.mod3.ec <- eigen_centrality(g.arc.mod3)


plot(g.arc.mod3,
     vertex.label = NA,
     vertex.size = 18*(g.arc.mod3.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.07,
     layout = layout_in_circle(g.arc.mod3),
     main = "Community 3 of TMEN for Archaea")

# subgraph of community 4
g.arc.mod4 <- induced.subgraph(graph = g.arc.new, vids = ac[[4]] )
# Identify key nodes using eigenvector centrality
g.arc.mod4.ec <- eigen_centrality(g.arc.mod4)


plot(g.arc.mod4,
     vertex.label.col = "black",
     vertex.label.cex = 0.2,
     vertex.size = 18*(g.arc.mod4.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.7,
     layout = layout_in_circle(g.arc.mod4),
     main = "Community 4 of TMEN for Archaea")

# subgraph of community 5
g.arc.mod5 <- induced.subgraph(graph = g.arc.new, vids = ac[[5]] )
# Identify key nodes using eigenvector centrality
g.arc.mod5.ec <- eigen_centrality(g.arc.mod5)


plot(g.arc.mod5,
     vertex.label.col = "black",
     vertex.label.cex = 0.2,
     vertex.size = 18*(g.arc.mod5.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.7,
     layout = layout_in_circle(g.arc.mod5),
     main = "Community 5 of TMEN for Archaea")


adj = get.adjacency((g.arc.new),sparse=FALSE)
env = c(ac[[1]][1:6],ac[[2]][1:5],ac[[3]][1:5],ac[[4]][1:2],ac[[8]][1])
spe = c(ac[[1]][7:43],ac[[2]][6:47],ac[[3]][6:38],ac[[4]][3:35],ac[[5]][1:13],ac[[6]][1:6],ac[[7]][1],ac[[8]][1:3],ac[[9]][1])
fun = c(ac[[1]][44:length(ac[[1]])],ac[[2]][48:length(ac[[2]])],
        ac[[3]][39:length(ac[[3]])],ac[[4]][36:length(ac[[4]])],
        ac[[5]][14:length(ac[[5]])],ac[[6]][7:length(ac[[6]])],
        ac[[7]][2:length(ac[[7]])],ac[[8]][4:length(ac[[8]])],
        ac[[9]][2:length(ac[[9]])])

# 1). plot spe_fun
reds = spe
blues = fun

#########################
adj = get.adjacency((g.arc.new),sparse=FALSE)
adj = adj[reds,]
adj = adj[,blues]

library(gplots)

(reds <- as.integer(factor(reds)))
(blues <- as.integer(factor(blues)))
(rowsep = cumsum(as.vector(table(reds))))
(colsep = cumsum(as.vector(table(blues))))
(labCol <- as.character(sort(blues)))
labCol[duplicated(labCol)] <- ""
(labRow <- as.character(sort(reds)))
labRow[duplicated(labRow)] <- ""

tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc_community_heatmap.fun_spe.full.note.tiff",width=1600,height=1600,pointsize=36)
heatmap.2(adj, Rowv=FALSE, Colv=FALSE, dendrogram="none", keysize=1.25,
          col=colorpanel(10, "white", "black"), scale="none",
          key=TRUE, symkey=FALSE, density.info="none", trace="none",
          main="Community Structure of TMEN for Archaea", sepcol="white",
          sepwidth = c(0, 0), margins=c(3,3),
          labCol=labCol, labRow=labRow, offsetRow=0, offsetCol=0,
          breaks=sort(c(0.1,seq(0, max(adj),length.out=10))))

dev.off()


tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc_community_heatmap.fun_spe.note.tiff",width=1600,height=1600,pointsize=36)
heatmap.2(adj, dendrogram="none", keysize=1.25,
          scale="none",
          key=TRUE, symkey=FALSE, density.info="none", trace="none",
          main="Community Structure of TMEN for Archaea", sepcol="white", colsep=colsep, rowsep=rowsep,
          sepwidth = c(0.025, 0.025), margins=c(3,3),
          labCol=labCol, labRow=labRow, offsetRow=0, offsetCol=0,
          breaks=sort(c(0.1,seq(0, max(adj),length.out=10))))

dev.off()


# 2). plot env_spe
reds = env
blues = spe

#########################
adj = get.adjacency((g.arc.new),sparse=FALSE)
adj = adj[reds,]
adj = adj[,blues]

library(gplots)

(reds <- as.integer(factor(reds)))
(blues <- as.integer(factor(blues)))
(rowsep = cumsum(as.vector(table(reds))))
(colsep = cumsum(as.vector(table(blues))))
(labCol <- as.character(sort(blues)))
labCol[duplicated(labCol)] <- ""
(labRow <- as.character(sort(reds)))
labRow[duplicated(labRow)] <- ""

tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc_community_heatmap.spe_env.note.tiff",width=1600,height=1600,pointsize=36)
heatmap.2(adj, Rowv=FALSE, Colv=FALSE, dendrogram="none", keysize=1.25,
          col=colorpanel(10, "yellow", "blue"), scale="none",
          key=TRUE, symkey=FALSE, density.info="none", trace="none",
          main="Community Structure of TMEN for Archaea", sepcol="white", colsep=colsep, rowsep=rowsep,
          sepwidth = c(0.025, 0.025), margins=c(3,3),
          labCol=labCol, labRow=labRow, offsetRow=0, offsetCol=0,
          breaks=sort(c(0.1,seq(0, max(adj),length.out=10))))

dev.off()


# 3). plot env_fun
reds = fun
blues = env

#########################
adj = get.adjacency((g.arc.new),sparse=FALSE)
adj = adj[reds,]
adj = adj[,blues]

library(gplots)

(reds <- as.integer(factor(reds)))
(blues <- as.integer(factor(blues)))
(rowsep = cumsum(as.vector(table(reds))))
(colsep = cumsum(as.vector(table(blues))))
(labCol <- as.character(sort(blues)))
labCol[duplicated(labCol)] <- ""
(labRow <- as.character(sort(reds)))
labRow[duplicated(labRow)] <- ""

tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/arc_community_heatmap.fun_env.note.tiff",width=1600,height=1600,pointsize=36)
heatmap.2(adj, Rowv=FALSE, Colv=FALSE, dendrogram="none", keysize=1.25,
          col=colorpanel(10, "yellow", "blue"), scale="none",
          key=TRUE, symkey=FALSE, density.info="none", trace="none",
          main="Community Structure of TMEN for Archaea", sepcol="white", colsep=colsep, rowsep=rowsep,
          sepwidth = c(0.025, 0.025), margins=c(3,3),
          labCol=labCol, labRow=labRow, offsetRow=0, offsetCol=0,
          breaks=sort(c(0.1,seq(0, max(adj),length.out=10))))

dev.off()


# 5. Hub species analysis ##########################
# Find the species with the largest degree
g.arc.degree <- degree(g.arc.new, mode="total")
table(g.arc.degree)

which.max(g.arc.degree)
# AS106 ID125
max(g.arc.degree)
# 1080

# Find the species with the largest betweenness score
g.arc.be <- betweenness(g.arc.new, directed = FALSE)
which.max(g.arc.be)
# AS106 ID125
max(g.arc.be)
# 2014696

# Identify key nodes using eigenvector centrality
g.arc.new.ec <- eigen_centrality(g.arc.new)
table(g.arc.new.ec$vector)
which.max(g.arc.new.ec$vector)
# AS106 ID 125
max(g.arc.new.ec$value)
# 69.09636

# AS106
(n106 <- neighbors(g.arc.new, 'AS106', mode = c('total')))
ga106 <- make_ego_graph(g.arc.new, order=2, nodes = 'AS106', mode = c("all"))[[1]]
ga106.ec <- eigen_centrality(ga106)
dists <- distances(ga106, "AS106")
colors <- c("red", "gold", "deepskyblue", "orange", "olivedrab1", "turquoise", "violet", "goldenrod1", "violetred1", "cadetblue1", "coral", "slateblue1")
V(ga106)$color <- colors[dists+2]


plot(ga106, 
     vertex.label = NA,
     vertex.label.cex = 0.02,
     edge.color = 'gray',
     edge.width = 0.2,
     vertex.size = 18*ga106.ec$vector,
     main = "Ego Graph of AS106",
     layout = layout_nicely(ga106),
)


# AS35
(n35 <- neighbors(g.arc.new, 'AS35', mode = c('total')))
ga35 <- make_ego_graph(g.arc.new, order=2, nodes = 'AS35', mode = c("all"))[[1]]
ga35.ec <- eigen_centrality(ga35)
dists <- distances(ga35, "AS35")
colors <- c("red", "gold", "deepskyblue", "orange", "olivedrab1", "turquoise", "violet", "goldenrod1", "violetred1", "cadetblue1", "coral", "slateblue1")
V(ga35)$color <- colors[dists+4]


plot(ga35, 
     vertex.label = NA,
     vertex.label.cex = 0.02,
     edge.color = 'gray',
     edge.width = 0.7,
     vertex.size = 18*ga35.ec$vector,
     main = "Ego Graph of AS35",
     layout = layout_nicely(ga35),
)

# AS96
(n96 <- neighbors(g.arc.new, 'AS96', mode = c('total')))
ga96 <- make_ego_graph(g.arc.new, order=2, nodes = 'AS96', mode = c("all"))[[1]]
ga96.ec <- eigen_centrality(ga96)
dists <- distances(ga96, "AS96")
colors <- c("red", "gold", "deepskyblue", "orange", "olivedrab1", "turquoise", "violet", "goldenrod1", "violetred1", "cadetblue1", "coral", "slateblue1")
V(ga96)$color <- colors[dists+6]


plot(ga96, 
     vertex.label = NA,
     vertex.label.cex = 0.02,
     edge.color = 'gray',
     edge.width = 0.7,
     vertex.size = 18*ga96.ec$vector,
     main = "Ego Graph of AS96",
     layout = layout_nicely(ga96),
)

# AS127
(n127 <- neighbors(g.arc.new, 'AS127', mode = c('total')))
ga127 <- make_ego_graph(g.arc.new, order=2, nodes = 'AS127', mode = c("all"))[[1]]
ga127.ec <- eigen_centrality(ga127)
dists <- distances(ga127, "AS127")
colors <- c("red", "gold", "deepskyblue", "orange", "olivedrab1", "turquoise", "violet", "goldenrod1", "violetred1", "cadetblue1", "coral", "slateblue1")
V(ga127)$color <- colors[dists+8]


plot(ga127, 
     vertex.label = NA,
     vertex.label.cex = 0.02,
     edge.color = 'gray',
     edge.width = 0.7,
     vertex.size = 18*ga127.ec$vector,
     main = "Ego Graph of AS127",
     layout = layout_nicely(ga127),
)

# AS52
(n52 <- neighbors(g.arc.new, 'AS52', mode = c('total')))
ga52 <- make_ego_graph(g.arc.new, order=2, nodes = 'AS52', mode = c("all"))[[1]]
ga52.ec <- eigen_centrality(ga52)
dists <- distances(ga52, "AS52")
colors <- c("red", "gold", "deepskyblue", "orange", "olivedrab1", "turquoise", "violet", "goldenrod1", "violetred1", "cadetblue1", "coral", "slateblue1")
V(ga52)$color <- colors[dists+10]


plot(ga52, 
     vertex.label = NA,
     vertex.label.cex = 0.02,
     edge.color = 'gray',
     edge.width = 0.7,
     vertex.size = 18*ga52.ec$vector,
     main = "Ego Graph of AS52",
     layout = layout_nicely(ga52),
)


# 6. Detect Important Environmental Factors ######################
g.arc.degree[1:19]

g.arc.be[1:19]

g.arc.new.ec$vector[1:19]



# 7. Calculate average nearest neighbor degree of species ###################
vertex <- V(g.arc)[[type == 'species']]
nei_degree <- as.data.frame(knn(g.arc, vids=vertex)[1])
spe_degree <- as.data.frame(degree(g.arc, v=vertex))
spe_between <- as.data.frame(betweenness(g.arc, v=vertex))
spe_centra <- as.data.frame((eigen_centrality(g.arc))[[1]][20:187])

arc_degree <- cbind(spe_degree, nei_degree)
arc_degree <- cbind(arc_degree, spe_between)
arc_degree <- cbind(arc_degree, spe_centra)

colnames(arc_degree) <- c("D", "AND", "B", "C")

arc_degree$ND = arc_degree$D * arc_degree$AND

arc_degree[is.na(arc_degree)] <- 0 

write.csv(arc_degree, "/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Table/arc_graph_indicator.csv")

