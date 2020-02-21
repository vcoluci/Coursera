##This function Function makeCacheMatrix gets a matrix as an input, set the value of the matrix,
#get the value of the matrix, set the inverse Matrix and get the inverse Matrix. The matrix object
#can cache its own object. 

#<<- operator is used to assign a value to an object in an environment that is different 
#from the current environment 

makeCacheMatrix <- function(x = matrix()) {
  inversa <- NULL
  
  setMatrix <- function(y) {
    x <<- y
    inversa <<- NULL
  }
  
  getMatrix <- function() x                            #get the value of the Matrix
  setInverse <- function(inverse) inversa <<- inverse  #set the value of the invertible matrix
  getInverse <- function() inversa                     #get the value of the invertible matrix
  list(setMatrix = setMatrix, getMatrix = getMatrix,
       setInverse = setInverse, getInverse = getInverse)
  
}

## The function cacheSolve takes the output of the previous matrix makeCacheMatrix(matrix) as an 
# input and checks inverse matrix from makeCacheMatrix(matrix) has any value in it or not.
# In case inverse matrix from makeCacheMatrix((matrix) is empty, it gets the original matrix data from 
# and set the invertible  matrix by using the solve function.
# In case inverse matrix from makeCacheMatrix((matrix) has some value in it (always works
#after running the code 1st time), it returns a message  "Getting Cached Invertible Matrix" 
#and the cached object

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  
  #get the value of the invertible matrix from the makeCacheMatrix function
  inversa <- x$getInverse()
  if(!is.null(inversa)) {                       
    message("Getting Cached Invertible Matrix")   
    return(inversa)                             
  }
  
  MatrixData <- x$getMatrix()       
  inversa <- solve(MatrixData, ...)
  x$setInverse(inversa)
  return(inversa)
 
}
