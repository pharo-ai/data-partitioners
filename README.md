# RandomPartitioner

This is a Pharo library for partitioning a collection. Given a set of K proportions, for example 50%, 30%, and 20%, it shuffles the collection and divides it into K non-empty subsets in such a way that every element is included in exactly one subset.

`RandomPartitioner` can be used in machine learning and statistical analysis for splitting the data into training, validation, and test (a.k.a. holdout) sets, or partitioning the data for cross-validation.

## How to install it?

To install `RandomPartitioner`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'RandomPartitioner';
  repository: 'github://olekscode/RandomPartitioner/src';
  load.
```

## How to depend on it?

If you want to add a dependency on `RandomPartitioner` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'RandomPartitioner'
  with: [ spec repository: 'github://olekscode/RandomPartitioner/src' ].
```

If you are new to baselines and Metacello, check out this wonderful [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## How to use it?

### Simple example

Here is a small array of 10 letters:

```Smalltalk
letters := #(a b c d e f g h i j).
```
We can split it in 3 random subsets with 50%, 30%, and 20% of data respectively:

```Smalltalk
partitioner := RandomPartitioner new.
subsets := partitioner split: letters withProportions: #(0.5 0.3 0.2).
```
The result might look something like this:

```Smalltalk
#((d h j a b)
  (i f e)
  (g c))
```

Alternatively, you might want to specify exact sizes of each partition. Let's split the array in two random subset with 3 and 7 elements:

```Smalltalk
subsets := partitioner split: letters withSizes: #(3 7).
```

This may produce the following partition:

```Smalltalk
#((d e a) 
  (c j g f i b h))
```
