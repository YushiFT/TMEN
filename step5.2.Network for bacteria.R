################################################
# Topic: Construct Bacterial Network
#  Date: 01/05/2018
#    By: Y.F.T
################################################

library(igraph)

bac_fun_env_edges <- read.csv("/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Temp_data/Network/bac_fun_env_edges.csv",header=T)
bac_fun_spe_edges <- read.csv("/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Temp_data/Network/bac_fun_spe_edges.csv",header=T)
bac_spe_env_edges <- read.csv("/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Temp_data/Network/bac_spe_env_edges.csv",header=T)

colnames(bac_fun_env_edges) <- c("V1","V2")
colnames(bac_fun_spe_edges) <- c("V1","V2")
colnames(bac_spe_env_edges) <- c("V1","V2")

bac_edges <- rbind(bac_fun_env_edges, bac_fun_spe_edges)
bac_edges <- rbind(bac_edges, bac_spe_env_edges)

bac_nodes <- read.csv("/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Temp_data/Network/nodes_bacteria.csv")

# 1.0 Plot the total tripartite graph ######################################

g.bac <- graph_from_data_frame(d = bac_edges, vertices = bac_nodes, directed=FALSE)

# Delete nodes with 0 degree
g.bac.new <- delete_vertices(g.bac, degree(g.bac, mode=c("total"))==0)

# Plot network and color vertices by type
V(g.bac.new)$color <- ifelse(V(g.bac.new)$type == 'functions', "dodgerblue", "gold")
V(g.bac.new)$color <- ifelse(V(g.bac.new)$type == 'environmental factors', "red", V(g.bac.new)$color)

# Identify key nodes using eigenvector centrality
g.bac.new.ec <- eigen_centrality(g.bac.new)
which.max(g.bac.new.ec$vector)

tiff(file="/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/bac.note_2.tiff",width=1600,height=1600,pointsize=36)
plot(g.bac.new,
     vertex.label = NA,
     vertex.size = 9*(g.bac.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.006,
     layout = layout_components(g.bac.new),
     main = "Tripartite Microbe-Environment Network of Bacteria")
dev.off()

# 2.0 Plot the spe_env factors seperately ###################################################
g.bac.spe.env <- graph_from_data_frame(d = bac_spe_env_edges, vertices = bac_nodes, directed = FALSE)
g.bac.spe.env.new <- delete_vertices(g.bac.spe.env, degree(g.bac.spe.env, mode=c("total"))==0)

V(g.bac.spe.env.new)$color <- ifelse(V(g.bac.spe.env.new)$type == 'environmental factors', "red", "gold")


# Identify key nodes using eigenvector centrality
g.bac.spe.env.new.ec <- eigen_centrality(g.bac.spe.env.new)
(g.bac.spe.env.new.ec$vector[1:20])

tiff(file="/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/bac_spe_env.note.tiff",width=1600,height=1600,pointsize=36)
plot(g.bac.spe.env.new,
     vertex.label.color = "black", 
     vertex.label.cex = 0.2,
     vertex.size = 18*(g.bac.spe.env.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.7,
     layout = layout_in_circle(g.bac.spe.env.new),
     main = "Bipartite Microbial Species-Environment Network of Bacteria")
dev.off()

tiff(file="/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/bac_spe_env.tiff",width=1600,height=1600,pointsize=36)
plot(g.bac.spe.env.new,
     vertex.label = NA,
     vertex.size = 18*(g.bac.spe.env.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.7,
     layout = layout_in_circle(g.bac.spe.env.new),
     main = "Bipartite Microbial Species-Environment Network of Bacteria")
dev.off()

tiff(file="/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/bac_spe_env.note_2.tiff",width=1600,height=1600,pointsize=36)
plot(g.bac.spe.env.new,
     vertex.label.color = "black", 
     vertex.label.cex = 0.2,
     vertex.size = 18*(g.bac.spe.env.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.7,
     layout = layout_nicely(g.bac.spe.env.new),
     main = "Bipartite Microbial Species-Environment Network of Bacteria")
dev.off()

tiff(file="/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/bac_spe_env.note_3.tiff",width=1600,height=1600,pointsize=36)
plot(g.bac.spe.env.new,
     vertex.label = NA,
     vertex.size = 18*(g.bac.spe.env.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.7,
     layout = layout_nicely(g.bac.spe.env.new),
     main = "Bipartite Microbial Species-Environment Network of Bacteria")
dev.off()

# 3.0 Plot the fun_env factors seperately ###########################################################
g.bac.fun.env <- graph_from_data_frame(d = bac_fun_env_edges, vertices = bac_nodes, directed = FALSE)
g.bac.fun.env.new <- delete_vertices(g.bac.fun.env, degree(g.bac.fun.env, mode=c("total"))==0)

V(g.bac.fun.env.new)$color <- ifelse(V(g.bac.fun.env.new)$type == 'environmental factors', "red", "dodgerblue")


# Identify key nodes using eigenvector centrality
g.bac.fun.env.new.ec <- eigen_centrality(g.bac.fun.env.new)
g.bac.fun.env.new.ec$vector[1:20]

tiff(file="/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/bac_fun_env.note.tiff",width=1600,height=1600,pointsize=36)
plot(g.bac.fun.env.new,
     vertex.label.color = "black", 
     vertex.label.cex = 0.2,
     vertex.size = 18*(g.bac.fun.env.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.6,
     layout = layout_components(g.bac.fun.env.new),
     main = "Bipartite Microbial Functions-Environment Network of Bacteria")
dev.off()

tiff(file="/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/bac_fun_env.tiff",width=1600,height=1600,pointsize=36)
plot(g.bac.fun.env.new,
     vertex.label = NA, 
     vertex.size = 18*(g.bac.fun.env.new.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.6,
     layout = layout_components(g.bac.fun.env.new),
     main = "Bipartite Microbial Functions-Environment Network of Bacteria")
dev.off()


# 4.0 Community detection ########################

# Fast-greedy community determine
bc <- fastgreedy.community(g.bac.new)

# Determine sizes of each community
sizes(bc)

# Determine which individuals belong to which community
mac <- membership(bc)
mac[1]

tiff
plot(bc, g.bac.new)

tiff(file="/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/bac_community.tiff",width=1600,height=1600,pointsize=15)
plot_dendrogram(bc)
dev.off()



adj.bac = get.adjacency((g.bac.new),sparse=FALSE)
env = c(bc[[1]][1:3],bc[[2]][1:4],bc[[3]][1:9],bc[[4]][1:3])
spe = c(bc[[1]][4:405],bc[[2]][5:179],bc[[3]][10:438],bc[[4]][4:403])
fun = c(bc[[1]][406:length(bc[[1]])],bc[[2]][180:length(bc[[2]])],
        bc[[3]][439:length(bc[[1]])],bc[[4]][404:length(bc[[1]])])

# 1). plot spe_fun
reds = spe
blues = fun

#########################
adj.bac = get.adjacency((g.bac.new),sparse=FALSE)
adj.bac = adj.bac[reds,]
adj.bac = adj.bac[,blues]

library(gplots)

(reds <- as.integer(factor(reds)))
(blues <- as.integer(factor(blues)))
(rowsep = cumsum(as.vector(table(reds))))
(colsep = cumsum(as.vector(table(blues))))
(labCol <- as.character(sort(blues)))
labCol[duplicated(labCol)] <- ""
(labRow <- as.character(sort(reds)))
labRow[duplicated(labRow)] <- ""

tiff(file="~/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/bac_community_heatmap.fun_spe_full.note.tiff",width=1600,height=1600,pointsize=36)
heatmap.2(adj.bac, Rowv=FALSE, Colv=FALSE, dendrogram="none", keysize=1.25,
          col=colorpanel(10, "white", "black"), scale="none",
          key=TRUE, symkey=FALSE, density.info="none", trace="none",
          main="Community Structure of TMEN for Bacteria", sepcol="white",
          sepwidth = c(0, 0), margins=c(3,3),
          labCol=labCol, labRow=labRow, offsetRow=0, offsetCol=0,
          breaks=sort(c(0.1,seq(0, max(adj.bac),length.out=10))))

dev.off()



# 2). plot env_spe
reds = spe
blues = env

#########################
adj = get.adjacency((g.bac.new),sparse=FALSE)
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

tiff(file="/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Figures/bac_community_heatmap.spe_env.note.tiff",width=1600,height=1600,pointsize=36)
heatmap.2(adj, Rowv=FALSE, Colv=FALSE, dendrogram="none", keysize=1.25,
          col=colorpanel(10, "white", "black"), scale="none",
          key=TRUE, symkey=FALSE, density.info="none", trace="none",
          main="Community Structure of TMEN for Archaea", sepcol="#DDDDDD", colsep=colsep, rowsep=rowsep,
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

tiff(file="/Users/YushiFTang/Desktop/Hangzhou_Bay/Function_network/Figure/arc_community_heatmap.fun_env.note.tiff",width=1600,height=1600,pointsize=36)
heatmap.2(adj, Rowv=FALSE, Colv=FALSE, dendrogram="none", keysize=1.25,
          col=colorpanel(10, "white", "black"), scale="none",
          key=TRUE, symkey=FALSE, density.info="none", trace="none",
          main="Community Structure of TMEN for Archaea", sepcol="#DDDDDD", colsep=colsep, rowsep=rowsep,
          sepwidth = c(0.025, 0.025), margins=c(3,3),
          labCol=labCol, labRow=labRow, offsetRow=0, offsetCol=0,
          breaks=sort(c(0.1,seq(0, max(adj),length.out=10))))

dev.off()


# 4.2 Plot subgraph of bacterial community #############################

# subgraph of community 1
g.bac.mod1 <- induced.subgraph(graph = g.bac.new, vids = bc[[1]] )
# Identify key nodes using eigenvector centrality
g.bac.mod1.ec <- eigen_centrality(g.bac.mod1)
V(g.bac.mod1)$color <- c("dodgerblue")

#V(g.bac.mod1)$color <- ifelse(V(g.bac.mod1)$type == 'functions', "dodgerblue", "gold")
#V(g.bac.mod1)$color <- ifelse(V(g.bac.mod1)$type == 'environmental factors', "red", V(g.bac.mod1)$color)
plot(g.bac.mod1,
     vertex.label = NA,
     vertex.size = 18*(g.bac.mod1.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.02,
     layout = layout_in_circle(g.bac.mod1),
     main = "Community 1 of TMEN for Bacteria")

# subgraph of community 2
g.bac.mod2 <- induced.subgraph(graph = g.bac.new, vids = bc[[2]] )
# Identify key nodes using eigenvector centrality
g.bac.mod2.ec <- eigen_centrality(g.bac.mod2)
V(g.bac.mod2)$color <- c("khaki1")

#V(g.bac.mod2)$color <- ifelse(V(g.bac.mod2)$type == 'functions', "dodgerblue", "gold")
#V(g.bac.mod2)$color <- ifelse(V(g.bac.mod2)$type == 'environmental factors', "red", V(g.bac.mod2)$color)

plot(g.bac.mod2,
     vertex.label = NA,
     vertex.size = 18*(g.bac.mod2.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.02,
     layout = layout_in_circle(g.bac.mod2),
     main = "Community 2 of TMEN for Bacteria")

# subgraph of community 3
g.bac.mod3 <- induced.subgraph(graph = g.bac.new, vids = bc[[3]] )
# Identify key nodes using eigenvector centrality
g.bac.mod3.ec <- eigen_centrality(g.bac.mod3)
V(g.bac.mod3)$color <- c("limegreen")
#V(g.bac.mod3)$color <- ifelse(V(g.bac.mod3)$type == 'functions', "dodgerblue", "gold")
#V(g.bac.mod3)$color <- ifelse(V(g.bac.mod3)$type == 'environmental factors', "red", V(g.bac.mod3)$color)
plot(g.bac.mod3,
     vertex.label = NA,
     vertex.size = 18*(g.bac.mod3.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.02,
     layout = layout_in_circle(g.bac.mod3),
     main = "Community 3 of TMEN for Bacteria")

# subgraph of community 4
g.bac.mod4 <- induced.subgraph(graph = g.bac.new, vids = bc[[4]] )
# Identify key nodes using eigenvector centrality
g.bac.mod4.ec <- eigen_centrality(g.bac.mod4)
V(g.bac.mod4)$color <- c("orange")
#V(g.bac.mod4)$color <- ifelse(V(g.bac.mod4)$type == 'functions', "dodgerblue", "gold")
#V(g.bac.mod4)$color <- ifelse(V(g.bac.mod4)$type == 'environmental factors', "red", V(g.bac.mod4)$color)

plot(g.bac.mod4,
     vertex.label = NA,
     vertex.size = 18*(g.bac.mod4.ec$vector),
     edge.color = 'gray77',
     edge.width = 0.02,
     layout = layout_in_circle(g.bac.mod4),
     main = "Community 4 of TMEN for Bacteria")


# 5. Hub species analysis ##########################
# Find the species with the largest degree
g.bac.degree <- degree(g.bac.new, mode="total")
table(g.bac.degree)
g.bac.degree.order = order(g.bac.degree)
table(g.bac.degree.order)

which.max(g.bac.degree)
# BS818 ID837
max(g.bac.degree)

# Find the species with the largest betweenness score
g.bac.be <- betweenness(g.bac.new, directed = FALSE)
table(g.bac.be)
which.max(g.bac.be)
# BS818 ID827
# S.TOC
max(g.bac.be)

# Identify key nodes using eigenvector centrality
g.bac.new.ec <- eigen_centrality(g.bac.new)
table(g.bac.new.ec$vector)
which.max(g.bac.new.ec$vector)
# BS818 ID837
max(g.bac.new.ec$value)


# BS818
n818 <- neighbors(g.bac.new, 'BS818', mode = c('total'))
gb818 <- make_ego_graph(g.bac.new, order=2, nodes = 'BS818', mode = c("all"))[[1]]
gb818.ec <- eigen_centrality(gb818)
dists <- distances(gb818, "BS818")
colors <- c("red", "gold", "deepskyblue", "orange", "olivedrab1", "turquoise", "violet", "goldenrod1", "violetred1", "cadetblue1", "coral", "slateblue1")
V(gb818)$color <- colors[dists+1]

plot(gb818, 
     vertex.label = NA,
     vertex.label.cex =0.02,
     edge.color = 'gray',
     edge.width = 0.2,
     vertex.size = 9*gb818.ec$vector,
     main = "Ego Graph of BS818",
     layout = layout_nicely(gb818)
)


# BS634
(n634 <- neighbors(g.bac.new, 'BS634', mode = c('total')))
gb634 <- make_ego_graph(g.bac.new, order=2, nodes = 'BS634', mode = c("all"))[[1]]
gb634.ec <- eigen_centrality(gb634)
dists <- distances(gb634, "BS634")
colors <- c("red", "gold", "deepskyblue", "orange", "olivedrab1", "turquoise", "violet", "goldenrod1", "violetred1", "cadetblue1", "coral", "slateblue1")
V(gb634)$color <- colors[dists+3]

plot(gb634, 
     vertex.label = NA,
     vertex.label.cex =0.2,
     edge.color = 'gray',
     edge.width = 0.7,
     vertex.size = 9*gb634.ec$vector,
     main = "Ego Graph of BS634",
     layout = layout_nicely(gb634)
)

# BS593
(n593 <- neighbors(g.bac.new, 'BS593', mode = c('total')))
gb593 <- make_ego_graph(g.bac.new, order=2, nodes = 'BS593', mode = c("all"))[[1]]
gb593.ec <- eigen_centrality(gb593)
dists <- distances(gb593, "BS593")
colors <- c("red", "gold", "deepskyblue", "orange", "olivedrab1", "turquoise", "violet", "goldenrod1", "violetred1", "cadetblue1", "coral", "slateblue1")
V(gb593)$color <- colors[dists+5]

plot(gb593, 
     vertex.label = NA,
     vertex.label.cex =0.2,
     edge.color = 'gray',
     edge.width = 0.7,
     vertex.size = 9*gb593.ec$vector,
     main = "Ego Graph of BS593",
     layout = layout_nicely(gb593)
)

# BS635
(n635 <- neighbors(g.bac.new, 'BS635', mode = c('total')))
gb635 <- make_ego_graph(g.bac.new, order=2, nodes = 'BS635', mode = c("all"))[[1]]
gb635.ec <- eigen_centrality(gb635)
dists <- distances(gb635, "BS635")
colors <- c("red", "gold", "deepskyblue", "orange", "olivedrab1", "turquoise", "violet", "goldenrod1", "violetred1", "cadetblue1", "coral", "slateblue1")
V(gb635)$color <- colors[dists+7]

plot(gb635, 
     vertex.label = NA,
     vertex.label.cex =0.2,
     edge.color = 'gray',
     edge.width = 0.7,
     vertex.size = 9*gb635.ec$vector,
     main = "Ego Graph of BS635",
     layout = layout_nicely(gb635)
)

# BS162
(n162 <- neighbors(g.bac.new, 'BS162', mode = c('total')))
gb162 <- make_ego_graph(g.bac.new, order=2, nodes = 'BS162', mode = c("all"))[[1]]
gb162.ec <- eigen_centrality(gb162)
dists <- distances(gb162, "BS162")
colors <- c("red", "gold", "deepskyblue", "orange", "olivedrab1", "turquoise", "violet", "goldenrod1", "violetred1", "cadetblue1", "coral", "slateblue1")
V(gb162)$color <- colors[dists+9]

plot(gb162, 
     vertex.label = NA,
     vertex.label.cex =0.2,
     edge.color = 'gray',
     edge.width = 0.7,
     vertex.size = 9*gb162.ec$vector,
     main = "Ego Graph of BS162",
     layout = layout_nicely(gb162)
)

# 6. Detect Important Environmental Factors ######################
g.bac.degree[1:19]

g.bac.be[1:19]

g.bac.new.ec$vector[1:19]

# 7. Calculate average nearest neighbor degree of species ###################
vertex <- V(g.bac)[[type == 'species']]
nei_degree <- as.data.frame(knn(g.bac, vids=vertex)[1])
spe_degree <- as.data.frame(degree(g.bac, v=vertex))
spe_between <- as.data.frame(betweenness(g.bac, v=vertex))
spe_centra <- as.data.frame((eigen_centrality(g.bac))[[1]][20:1425])

bac_degree <- cbind(spe_degree, nei_degree)
bac_degree <- cbind(bac_degree, spe_between)
bac_degree <- cbind(bac_degree, spe_centra)


colnames(bac_degree) <- c("D", "AND", "B", "C")

bac_degree$ND = bac_degree$D * bac_degree$AND

bac_degree[is.na(bac_degree)] <- 0 

write.csv(bac_degree, "/Users/YushiFTang/Desktop/Lab/Undergraduate/Hangzhou_Bay/Function_network_re/Table/bac_graph_indicator.csv")




