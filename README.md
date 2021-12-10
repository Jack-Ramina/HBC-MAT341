# Jack Ramina 
    Honors By Contract 2021

## Simulated Annealing

    This is the final project for the Honors By Contract course for MAT-341 Computational Mathematics
    We attempted to solve the travelling salesperson problem using simulated annealing.
    We are given 1000 cities and the cost and distance to travel between each city. Our goal is to travel
    to each city while minimizing the cost and the distance travelled.
    The problem that a lot of optimization algorithms face is that they tend to converge to local minima
    instead of global minima. Simulated annealing adds some randomness to the optimization scheme in hopes
    that it will kick us out of a local minimum and allow us to drop further into a global minimum.

    Cost_Matrix.mat is not used.
    Cost_and_Distance_Matrices.mat contians the matrices used to find the cost and distance between cities.
    cost_Func.m calculates the cost for the current route across all cities.
    good_Change_Finder.m finds cutoff points for "good" and "bad" changes in cost and distance
    simulated_Annealing.m is the optimization scheme.

## Problem of the Week

    The problem of the week for the week 0f 10/5 was as follows: Arrange the numbers 1-16 in order so that
    the sum of neighboring numbers is a perfect square.

    potw.m attempts to randomly arrange the numbers 1-16 until the conditions are met.
    potw2.m attempts to solve the problem numerically instead of relying on brute force.

## Sorting Algorithms
    
    6 sorting algorithms that I coded on a friday night instead of going out like a normal college student.
    Sorting algorithms have always interested me ever since I saw the sorting algorithm visualizations on
    the internet. I felt that I had the skill to code a few of them. Before I started researching, bogo
    sort was my favorite because it randomizes the data until it is sorted. After all of these were
    finished, radix sort became my favorite because it does not use and comparisons.

    bogo_Sort.m randomizes the range until it is sorted.
    bubble_Sort.m repeatedly sorts each pair of neighboring numbers until the range is sorted
    insertion_Call.m moves smaller values left until they are in the proper position relative to neighbors
    insertion_Sort.m finds the smallest value and moves it to the left until the range is sorted
    quick_Sort.m organizes the range into smaller sections then sorts each section using insertion sort
        and finally puts the sections back together
    radix_sort.m sorts by each digit in the numbers starting at 1s and ending at the starting digit
    selection_sort.m selects the smallest value and puts it in its proper position
   
## Other

    TBA
