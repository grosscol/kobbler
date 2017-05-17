# Simple hello world 
perform <- function(name, times){
 greeting <- sprintf("Hello, %s", name) 
 result <- cat( rep(greeting, times), sep="\n")
 return result
}
