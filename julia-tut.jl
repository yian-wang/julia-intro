#Introduction to Julia

#After downloading Atom and Juno:

#*************************ADDING PACKAGES*************************
#Type the below into your REPL:

#`using Pkg`
#`Pkg.add("StatsPlots")` #Can use Plots but I prefer StatsPlots
#`Pkg.add("CSV")`
#`Pkg.add("DataFrame")`

#OR:

#`] activate .` #including the space
  ##creates new environment
#`status` allows you to see what packages you have installed

#then `add PackageName`
#**********************************************


#*************************IMPORT CSV*************************
using CSV
using DataFrames
#df = CSV.read("pathname")

reale = CSV.read("/Users/yianwang/Desktop/reale.csv")

#*************************BASIC MANIPULATION*************************

names(reale) #get column names

#since variable names in Julia cannot contain spaces, we will reference
#columns names with spaces as below:

names(reale)[2]

#we can also use reale[2] to index & reference the entire column but
#it will give us a depreciated warning so we use `reale[!, col_ind]` instead:

reale[!, 2]

#Renaming a column name:
#rename() function doesn't work on sale & list prices since there are spaces
#in the variable name and we cannot call it (gives error)


#In general, to rename something the function rename() is as below:
  #`rename(dfName, :old_name1 => :new_name1, :old_name2 => :new_name2)`
   #*note we can rename multiple columns at once*

#save renamed table as new variable in case you want to revisit your old table
reale2 = rename(reale, :Case_ID => :ID)


#*************************DELETE COLUMNS*************************
#`select!(df_name, Not(:col))` where col = column you wish to delete

select!(reale2, Not(:taxes))

#in the case we wish to delete a column with spaces in the name, we reference
#the indexing of the dataframe as before:

select!(reale2, Not(names(reale2)[2]))


#*************************DOT NOTATION*************************
#element-wise calculations must be done "manually"
#this is because since Julia is so good for computational sciences,
#it makes it easy to multiply whole matrices & such but if you want
#to do element wise calculations then you need a dot in front of your operator

reale[!, :new_col] = reale[!, 2] .+ 2
reale[!, :new_col2] = log.(reale[!, 2])


#*************************PLOTTING*************************
using StatsPlots #you can use Plots, though I have had some trouble with it

sale_price = reale[!, 2] #naming the variables
list_price = reale[!, 3] #naming the variables

boxplot(sale_price, color = :green, size = (400,700), label = "Sale Prices in \$100000", title = "Boxplot of Sale Prices")
savefig("box")

#We can create others using: scatter(), histogram(), plot()

scatter(sale_price,list_price, size = (800,500), xlabel = "sale price in \$100000", ylabel = "list price in \$100000", title = "Scatterplot of Sale Price vs List Price")
savefig("scatter")
