# Insert the element x in a sorted list xs of length n
def insert_in_sorted(x,xs,n):

    # We start from the end of the list
    i = n-1

    # Shift all elements that are greater than x one step to the right
    while (0 <= i and xs[i] > x):
        xs[i+1] = xs[i]
        i -= 1

    # Update the relevant index
    xs[i+1] = x


# Sort a list xs of length n
def insertion_sort(xs,n):

    # We first initalize an array of size n. In C this can be done
    # using malloc.
    out = []
    for i in range(n):
        out.append(0)

    # Insert the elements of xs into out. Note that we pass i as it is
    # the current number of inserted elements in out.
    for i in range(n):
        insert_in_sorted(xs[i],out,i)

    return out

mylist = [ 12, -3, 27, 2, 3, 1, 9 ]
print(insertion_sort(mylist,len(mylist)))