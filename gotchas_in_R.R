## Author: Rebecca Stubbs
## Date: 4/6/2017

# Get a list of the names in your global environment:
ls()

# set/get a working directory that serves as the root for all your file paths:
  #getwd()
  #setwd("some_other_path")

# get rid of everything in your current working environment (don't write this on top of scripts
# unless you know you don't care about preserving anything, it makes people angry when you
# wipe their workspace)
  #rm(list=ls()) # wipes out the entire workspace

# You can define a list two ways:
df_list<-list(data_frame_a,data_frame_b)

# with named items
df_list_named<-list()
df_list_named[["a"]]<-data_frame_a # adding named entries
df_list_named[["b"]]<-data_frame_b


# Things for Ben to remember:
#- List indices: single brackets [] refers to the name/dictionary, while double [[]] referes to the index (python style)
#- Indices ALWAYS START AT 1 in R
#- Things that are defined in the loop won't exist out of the loop unless you refer to the external object within
#   the list that they are referring to: you need to overwrite the data object in the loop with the transformed
#   version of that data frame. Then, you can use/manipuate/have the list you started with, that is now altered.
#- Broadly, lists in R are basically like dictionaries, but you can avoid having a name if you don't define one--
#   this doesn't get you out of needing to use double brackets, though, even if the name of the list item isn't defined.

# This person had your exact problem: http://stackoverflow.com/questions/39012992/loop-through-variables-to-melt-in-r

# This will NOT work
  for (df in df_list){
    suppressWarnings(df<-melt(df,id.vars="cnty"))
    print(names(df))
  }

# This WILL work
  # Using list indices:
  for (i in seq(1:length(df_list))){ # for i in a sequence from 1 to the length of the lits
    print(i)
    df_list[[i]]<-melt(df_list[[i]],id.vars="cnty") # reassign the list's 
  }

# This will ALSO work-- names() returns the key/list item name
for (name in names(df_list_named)){ # for each named item in the list; this won't work if you haven't defined names
  df_list_named[[name]]<-melt(df_list_named[[name]],id.vars="cnty") #
}

# Exploring vectors and lists:
  vector<-c(1,2,3) # starting a vector
  vector
  vector<-c(vector,4) # adding to a vector
  vector

# You can make lists (like Python dictionaries) a bunch of ways:
  L_names<- list(name1 = "hi", name2 = "hello")
  L_names_as_strings<- list("name1" = "hi", "name2" = "hello")
  L_names==L_names_as_strings
  L_names_alt<-list()
  L_names_alt[["name1"]]<-"hi"
  L_names_alt[["name2"]]<-"hello"
  # super handy function in data.table package, 
  # will evaluate each column named the same, if the columns are named the same, but the data inside are different,
  # it will spit out a quantitative report on how different they are on averate
  all.equal(L_names,L_names_as_strings,L_names_alt)

  # Note that you can't concatenate to the list, but you can add to it in an index:
    L<-list(1,2,3)
    L
    cat("Length of list is:",length(L))
    L_1<-list(L,4) # you have now made a list of lists
    L_1
    cat("Length of new list is:",length(L_1))
  # You can, however, add another item on based on giving it the index PAST what it currently has
    L[[length(L)+1]]<-4
    L
    cat("Length of list is:",length(L))

# sneaky/janky way to do it-- evalute objects in the global environment based on the
# string version of their name. 
data_frame_name_list<-list("data_frame_a","data_frame_b")

for(df in data_frame_name_list){
  the_df<-get(df)
  df_melted<-suppressWarnings(melt( the_df ,id.vars="cnty"))
  assign(df, df_melted) # assigns it OUTSIDE the loop, affects global scope
  print(head(get(df)))
}

# More fun with "assign": Loading in data to as-of-yet-undefined object names
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Say your files follow the following convention:
  file_path<-paste0(root,"color_",color,".csv")
    # and you have some of each color (red,blue,and green):
  colors<-c("red","blue","green") # colors you know you have as .csv files
  
  # This would create data frames with the names "red", "blue", "green" in the working
  # environment, loaded in from outside. 
  for (color in colors){
    assign(csv,fread(file_path<-paste0(root,"color_",color,".csv")))
  }
